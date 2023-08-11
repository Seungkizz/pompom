package com.pompom.www.board.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.pompom.www.board.dto.ReplyDTO;
import com.pompom.www.board.service.ReplyService;
import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.member.service.MemberService;

import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/reply/*")
@Log4j
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	
	@Autowired
	private MemberService memberService;

	@PostMapping("/insert")
	public String insert(@RequestBody ReplyDTO replyDTO, HttpSession session, HttpServletRequest request) {

		session = request.getSession();
		MemberDTO memberDTO = (MemberDTO) session.getAttribute("auth");
		String memberId = memberDTO.getMemberId();
		replyDTO.setMemberId(memberId);
		// log.info("replyDTO >>> " + replyDTO);
		int result = replyService.insert(replyDTO);
		if (result > 0) {
			memberService.activeScoreUp(memberId);
			return "success";
		}

		return "fail";

	}

	// 댓글 리스트 가져오기
	@GetMapping("/list")
	public List<ReplyDTO> get(@RequestParam("bno") long bno) {
		// log.info("get >> bno >>> " + bno);
		List<ReplyDTO> replylist = replyService.getList(bno);
		// log.info("get >> replylist >>> " + replylist);
		return replylist;

	}

	// 댓글 수정
	@PostMapping("/modify/{rno}/{content}")
	public ResponseEntity<String> modifiy(@PathVariable long rno, @PathVariable String content) {
		// log.info("rno >>>" + rno);
		// log.info("content >>>" + content);
		int result = replyService.replyModify(rno, content);
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

	// 댓글삭제
	@DeleteMapping("/delete/{rno}")
	public ResponseEntity<String> delete(@PathVariable long rno) {
		log.info("rno >>>" + rno);
		int result = replyService.replydelete(rno);
		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

	// 댓글 좋아요
	@PostMapping("/like/{rno}")
	public ResponseEntity<String> likeUp(@PathVariable long rno, HttpServletRequest request,
			HttpServletResponse response) {
		String cookieName = "reply_like_" + rno;
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
		int result = 0;
		// 쿠키가 존재하지 않으면 좋아요 업데이트
		if (cookieValue.equals("")) {
			result = replyService.likeUp(rno);

			// 조회수 증가 후, 클라이언트에게 쿠키 전송
			Cookie replyCookie = new Cookie(cookieName, "replyuselikes");
			replyCookie.setMaxAge(3600); // 쿠키 유효 기간 설정 (예: 1시간)
			response.addCookie(replyCookie);
		}

		return result == 1 ? new ResponseEntity<>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

	}

}
