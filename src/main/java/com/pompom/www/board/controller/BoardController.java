package com.pompom.www.board.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pompom.www.board.dto.BoardDTO;
import com.pompom.www.board.dto.BoardTagCountDTO;
import com.pompom.www.board.dto.BoardTagDTO;
import com.pompom.www.board.dto.BoardTopWritersDTO;
import com.pompom.www.board.dto.PagingVO;
import com.pompom.www.board.dto.QuestionDTO;
import com.pompom.www.board.dto.ScrapDTO;
import com.pompom.www.board.service.BoardService;
import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.member.service.MemberService;
import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.service.UploadService;
import com.pompom.www.util.Auth;

import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@Log4j
public class BoardController {

	@Autowired
	private BoardService boardService;
	@Autowired
	private MemberService memberService;
	@Autowired
	private UploadService uploadService;

	// questions 게시판 보여주기
	@GetMapping("/questions")
	public void questions(PagingVO vo, Model model, @RequestParam(value = "nowPage", required = false) String nowPage,
			@RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
		int total = boardService.getTotalQuestions();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "7";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) {
			cntPerPage = "7";
		}

		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);

		List<BoardDTO> questionsList = boardService.questionsList(vo);
		// log.info("questionsList >>>> " + questionsList);
		List<BoardTagCountDTO> tagCount = boardService.tagCountList();
		List<BoardTopWritersDTO> topWriters = boardService.topWriterList();
		List<BoardTagDTO> BoardTagList = boardService.BoardTagList();
		List<AttachDTO> attachList = uploadService.selectAll();
		Map<String, List<String>> imgMap = new HashMap<>();

		for (AttachDTO attachDTO : attachList) {
			String memberId = attachDTO.getMemberId();
			String fileCallPath = "/upload/" + attachDTO.getUploadpath() + "/" + attachDTO.getUuid() + "_"
					+ attachDTO.getFilename();

			// map에 memberId가 이미 있는지 확인
			if (imgMap.containsKey(memberId)) {
				// memberId가 있으면 fileCallPaths 목록을 가져오고 여기에 새 목록을 추가
				List<String> fileCallPaths = imgMap.get(memberId);
				fileCallPaths.add(fileCallPath);
			} else {
				// memberId가 없으면 새 목록을 만들고 여기에 fileCallPath를 추가합니다.
				List<String> fileCallPaths = new ArrayList<>();
				fileCallPaths.add(fileCallPath);
				imgMap.put(memberId, fileCallPaths);
			}
		}
		model.addAttribute("imgMap", imgMap);
		model.addAttribute("BoardTagList", BoardTagList);
		model.addAttribute("tagCount", tagCount);
		model.addAttribute("topWriters", topWriters);
		model.addAttribute("questionsList", questionsList);
	}

	// 글 작성 폼 전송
	@Auth
	@GetMapping("/writeForm")
	public void writeForm() {

	}

	// 글 작성 / 태그 작성 / board_tag 작성
	@PostMapping("/write")
	public String write(BoardDTO boardDTO, @RequestParam("tag") String tag, HttpSession session,
			HttpServletRequest request, RedirectAttributes rttr)
			throws JsonParseException, JsonMappingException, IOException {
		// 세션빼기
		session = request.getSession();
		// 세션에 붙어있는 auth (_member) 객체를 가져오기
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("auth");
		// 가져온 객체에서 아이디빼서 boardDTO에 넣어줌
		String memberId = memberDTO.getMemberId();
		boardDTO.setMemberId(memberId);

		log.info("boardDTO >>>>>>>>>>>>>>> " + boardDTO);
		log.info("tag >>>>>>>>>>>>>>> " + tag);
		// ObjectMapper 사용하여 Jackson 타입 문자열로 변환
		ObjectMapper mapper = new ObjectMapper();
		// TypeReference 사용하여 컬렉션 타입으로 변환
		List<Map<String, String>> paramList = mapper.readValue(tag, new TypeReference<List<Map<String, String>>>() {
		});
		log.info("paramList >>>>>>>>>>>>>>> " + paramList);
		List<String> tagList = new ArrayList<String>();
		for (Map<String, String> map : paramList) {
			tagList.add(map.get("value"));
		}
		log.info("tagList >>>>>>>>>>>>>> " + tagList);
		// 게시판 작성 시 첨부파일이 있으면
		if (boardDTO.getAttachList() != null) {
			
			boardDTO.getAttachList().forEach(attach -> log.info(attach));

		}
		// 게시글과,문자열타입의 리스트를 가지고 서비스요청
		int result = boardService.write(boardDTO, tagList);
		if (result > 0) {
			memberService.activeScoreUp(boardDTO.getMemberId());
			rttr.addFlashAttribute("SuccessWrite", "success");
		}

		return "redirect:/board/questions";

	}

	// 태그 찾아오기
	@GetMapping("/searchTag")
	@ResponseBody
	public List<String> searchTag(String param) {
		List<String> list = new ArrayList<String>();
		// log.info("param >>>>>>>>>>>>>>>>>> " + param);
		list = boardService.getTagList(param);
		// log.info("list >>>>>>>>>>>>>>>>>> " + list);
		return list;
	}

	// 선택 글 보여주기
	@GetMapping("/questionsView")
	public String questionsView(@RequestParam("Bno") long Bno, HttpServletRequest request, HttpServletResponse response,
			Model model) {
		// log.info("Bno >>> " + Bno);
		// 쿠키 이름과 값 설정
		String cookieName = "board_view_" + Bno;
		String cookieValue = "";

		// 요청된 게시물에 대한 쿠키를 검사
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					cookieValue = cookie.getValue();
					break;
				}
			}
		}

		// 쿠키가 존재하지 않으면 조회수 증가
		if (cookieValue.equals("")) {
			boardService.viewsUp(Bno);

			// 조회수 증가 후, 클라이언트에게 쿠키 전송
			Cookie viewCookie = new Cookie(cookieName, "viewed");
			viewCookie.setMaxAge(12 * 60 * 60); // 쿠키 유효 기간 설정 (예: 12시간)
			response.addCookie(viewCookie);
		}

		List<BoardDTO> boardView = boardService.questionsGet(Bno);

		String memberId = "";

		for (BoardDTO boardDTO : boardView) {
			memberId = boardDTO.getMemberId();
		}
		AttachDTO attachDTO = uploadService.selectAttach(memberId);
		if (attachDTO != null) {
			// log.info("attachDTO >>>>> " + attachDTO);
			String fileCallPath = "/upload/" + attachDTO.getUploadpath() + "/" + attachDTO.getUuid() + "_"
					+ attachDTO.getFilename();
			// log.info("fileCallPath >>> " + fileCallPath);
			model.addAttribute("fileCallPath", fileCallPath);
		}

		// log.info("boardView >>>> " + boardView);
		model.addAttribute("boardView", boardView);

		return "board/questionsView";
	}

	// 수정 폼 전달
	@GetMapping("/questionsModify")
	public String questionsModify(Model model, @RequestParam("Bno") long Bno) {
		// log.info("Bno >>>> " + Bno);
		List<BoardDTO> boardModify = boardService.questionsGet(Bno);
		model.addAttribute("boardModify", boardModify);
		return "board/questionsModify";

	}

	// 게시글 수정
	@PostMapping("/questionsModify")
	public String Modify(Model model, BoardDTO boardDTO, @RequestParam("tag") String tag, RedirectAttributes rttr)
			throws JsonParseException, JsonMappingException, IOException {

		// log.info("ModifyboardDTO >>>>>>>>>>>>>>> " + boardDTO);

		ObjectMapper mapper = new ObjectMapper();
		List<Map<String, String>> paramList = mapper.readValue(tag, new TypeReference<List<Map<String, String>>>() {
		});
		// log.info("paramList >>>>>>>>>>>>>>> " + paramList);
		List<String> tagList = new ArrayList<String>();
		for (Map<String, String> map : paramList) {
			tagList.add(map.get("value"));
		}
		// log.info("tagList >>>>>>>>>>>>>> " + tagList);

		int result = boardService.modify(boardDTO, tagList);
		if (result > 0) {
			rttr.addFlashAttribute("SuccessModify", "success");
		}

		return "redirect:/board/questionsView?Bno=" + boardDTO.getBno();
	}

	// 게시글 삭제
	@GetMapping("/questionsDelete")
	public String questionsDelete(RedirectAttributes rttr, @RequestParam("Bno") long Bno) {
		int deleteResult = boardService.delete(Bno);
		if (deleteResult > 0) {
			rttr.addFlashAttribute("Success", "삭제성공");
		}
		return "redirect:/board/questions";

	}

	// 좋아요(쿠키로 다중 좋아요 방지)
	@GetMapping("/like")
	@ResponseBody
	public ResponseEntity<String> likeUpdate(@RequestParam long bno, HttpServletRequest request,
			HttpServletResponse response) {
		// log.info("여기아니야?" + bno);
		int result = 0;
		// 쿠키 이름과 값 설정
		String cookieName = "board_like_" + bno;
		String cookieValue = "";
		// 요청된 게시물에 대한 쿠키를 검사
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					cookieValue = cookie.getValue();
					break;
				}
			}
		}

		// 쿠키가 존재하지 않으면 좋아요 업데이트
		if (cookieValue.equals("")) {
			result = boardService.likesUp(bno);
			// 조회수 증가 후, 클라이언트에게 쿠키 전송
			Cookie viewCookie = new Cookie(cookieName, "uselikes");
			viewCookie.setMaxAge(3600); // 쿠키 유효 기간 설정 (예: 1시간)
			response.addCookie(viewCookie);
		}
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	// 게시물 상세보기 시 등록 된 첨부파일 가져오기
	@GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachDTO>> getAttachList(long bno) {

		// log.info("getAttachList " + bno);

		List<AttachDTO> attachList = boardService.getAttachList(bno);

		return new ResponseEntity<>(attachList, HttpStatus.OK);

	}

	// 해시태그 클릭시 해당 해시태그 리스트 반환
	@PostMapping("/questionsHashTag/{tagName}")
	@ResponseBody
	public ResponseEntity<List<QuestionDTO>> searchHashTag(@PathVariable("tagName") String tagName) {
		// log.info("tagName >>>> " + tagName);
		List<QuestionDTO> list = boardService.searchHashTag(tagName);
		// log.info("tagNamelist >>>> " + list);
		return new ResponseEntity<>(list, HttpStatus.OK);

	}

	// 스크랩
	@PostMapping("/scrap/{bno}/{memberId}")
	@ResponseBody
	public int scrap(@PathVariable("bno") Long bno, @PathVariable("memberId") String memberId) {
		// log.info("scrap >>> " + bno);
		// log.info("scrap >>> " + memberId);
		ScrapDTO scrapDTO = new ScrapDTO();
		scrapDTO.setBno(bno);
		scrapDTO.setMemberId(memberId);
		int scrap = boardService.scrapCheck(scrapDTO);
		// log.info(scrap);
		if (scrap == 0) {
			boardService.scrapInsert(scrapDTO);
		} else {
			boardService.scrapCancel(scrapDTO);
		}
		return scrap;

	}

	// 스크랩 리스트 뿌리기
	@PostMapping("/scrapList")
	public ResponseEntity<List<ScrapDTO>> scrapList(@RequestBody JsonNode jsonData) {
		log.info("scrapList >>> " + jsonData);
		// JsonNode를 사용하여 memberId 값을 추출하여 asText() 문자열로 변환
		String memberId = jsonData.get("memberId").asText();
		List<ScrapDTO> scrapList = boardService.scrapList(memberId);
		log.info("scrapList >>> " + scrapList);
		return new ResponseEntity<>(scrapList, HttpStatus.OK);

	}
}
