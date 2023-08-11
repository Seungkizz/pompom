package com.pompom.www.board.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pompom.www.board.dto.BoardDTO;
import com.pompom.www.board.dto.BoardTagCountDTO;
import com.pompom.www.board.dto.BoardTagDTO;
import com.pompom.www.board.dto.BoardTopWritersDTO;
import com.pompom.www.board.dto.PagingVO;
import com.pompom.www.board.dto.QuestionDTO;
import com.pompom.www.board.dto.ScrapDTO;
import com.pompom.www.board.dto.TagDTO;
import com.pompom.www.board.mapper.BoardMapper;
import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.mapper.UploadMapper;

import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@Slf4j
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private UploadMapper uploadMapper;

	@Override
	public int write(BoardDTO boardDTO, List<String> tagList) {
		// boardMapper를 통해 board table에 insert
		int result = boardMapper.write(boardDTO);

		// 게시글에 사진이 있으면
		if (boardDTO.getAttachList() != null && !boardDTO.getAttachList().isEmpty()) {
			boardDTO.getAttachList().forEach(attach -> {
				attach.setBno(boardDTO.getBno());
				uploadMapper.insertBoardImg(attach);
			});
		}
		// Map 타입의 리스트 생성
		List<Map> tagIdList = new ArrayList<>();
		if (result > 0) {
			for (String tag : tagList) {
				// 가지고온 tagList를 tag table에 있는지 찾아봄
				TagDTO tagDTO = boardMapper.searchTag(tag);
				log.info("tagDTO >>>>>>>>>> " + tagDTO);
				// 기존에 등록되어 있는 태그라면
				if (tagDTO != null) {
					Map tagMap = new HashMap();
					tagMap.put("bno", boardDTO.getBno());
					tagMap.put("tagId", tagDTO.getTagId());
					tagIdList.add(tagMap);
					// 처음 등록되는 태그라면
				} else {
					tagDTO = new TagDTO();
					tagDTO.setName(tag);
					// tag table에 insert
					boardMapper.writeTag(tagDTO);
					Map tagMap = new HashMap();
					tagMap.put("bno", boardDTO.getBno());
					tagMap.put("tagId", tagDTO.getTagId());
					tagIdList.add(tagMap);
				}
			}
		}
		log.info("tagIdList >>>>>>>>>> " + tagIdList);
		// board_tag table에 insert
		boardMapper.writeBoardTag(tagIdList);
		return result;
	}

	@Override
	public List<String> getTagList(String param) {

		return boardMapper.selectTagList(param);
	}

	@Override
	public int getTotalQuestions() {
		return boardMapper.getTotalQuestions();
	}

	@Override
	public void viewsUp(long bno) {
		boardMapper.viewsUp(bno);

	}

	@Override
	public List<BoardDTO> questionsGet(long bno) {
		return boardMapper.questionsGet(bno);
	}

	@Override
	public List<BoardTagCountDTO> tagCountList() {
		return boardMapper.tagCountList();
	}

	@Override
	public List<BoardTopWritersDTO> topWriterList() {
		return boardMapper.topWriterList();
	}

	@Override
	public List<BoardTagDTO> BoardTagList() {
		return boardMapper.BoardTagList();
	}

	@Override
	public List<BoardDTO> questionsList(PagingVO vo) {
		return boardMapper.questionsList(vo);
	}

	@Override
	public int delete(long bno) {
		uploadMapper.deleteAll(bno);
		int btDeleteResult = boardMapper.boardTagDelete(bno);
		int success = 0;
		if (btDeleteResult > 0) {
			int result = boardMapper.delete(bno);
			if (result > 0) {
				success = 1;
				return success;
			}
		}
		return 0;

	}

	@Override
	public List<BoardDTO> mainQuestionsList() {
		return boardMapper.mainQuestionsList();
	}

	// 게시글 수정 시
	@Override
	public int modify(BoardDTO boardDTO, List<String> tagList) {
		// 기존에 올려진 업로드 파일을 삭제
		uploadMapper.deleteAll(boardDTO.getBno());
		// 수정 시 사진 리스트가 null 아니고 리스트가 존재 한다면 해당 게시글 번호에 다시 사진을 insert
		if (boardDTO.getAttachList() != null && !boardDTO.getAttachList().isEmpty()) {
			boardDTO.getAttachList().forEach(attach -> {
				attach.setBno(boardDTO.getBno());
				uploadMapper.insertBoardImg(attach);
			});
		}
		// 게시글 update
		int result = boardMapper.modify(boardDTO);
		// 기존에 board_tag에 달린 해시태그 삭제
		boardMapper.boardTagDelete(boardDTO.getBno());
		log.info("tagList >>>>>>>>>> " + tagList);

		List<Map> tagIdList = new ArrayList<>();
		// 게시글이 update가 되었다면
		if (result > 0) {
			for (String tag : tagList) {
				// 넘어온 해시태그를 tag table에서 찾아봄
				TagDTO tagDTO = boardMapper.searchTag(tag);
				log.info("tagDTO >>>>>>>>>> " + tagDTO);
				// 만약에 기존에 등록 되 있던 해시태그면 tagMap에 put 해주고 그 tagMap을 tagIdList에 add
				if (tagDTO != null) {
					Map tagMap = new HashMap();
					tagMap.put("bno", boardDTO.getBno());
					tagMap.put("tagId", tagDTO.getTagId());
					tagIdList.add(tagMap);
					// 새로 추가된 해시태그면
				} else {
					tagDTO = new TagDTO();
					tagDTO.setName(tag);
					// tag table에 insert
					boardMapper.writeTag(tagDTO);
					Map tagMap = new HashMap();
					tagMap.put("bno", boardDTO.getBno());
					tagMap.put("tagId", tagDTO.getTagId());
					tagIdList.add(tagMap);
				}
			}
		}
		log.info("tagIdList >>>>>>>>>> " + tagIdList);
		// ex tagIdList >>>>>>>>>> [{bno=266, tagId=1}, {bno=266, tagId=186}, {bno=266,
		// tagId=187}]
		// board_tag table에 insert
		boardMapper.writeBoardTag(tagIdList);

		return result;
	}

	@Override
	public int likesUp(long bno) {
		return boardMapper.likesUp(bno);

	}

	@Override
	public List<AttachDTO> getAttachList(long bno) {
		return uploadMapper.selectByBno(bno);
	}

	@Override
	public List<QuestionDTO> searchHashTag(String tagName) {
		return boardMapper.searchHashTag(tagName);
	}

	@Override
	public void scrapInsert(ScrapDTO scrapDTO) {
		boardMapper.scrapInsert(scrapDTO);
	}

	@Override
	public int scrapCheck(ScrapDTO scrapDTO) {
		return boardMapper.scrapCheck(scrapDTO);
	}

	@Override
	public void scrapCancel(ScrapDTO scrapDTO) {
		boardMapper.scrapCancel(scrapDTO);

	}

	@Override
	public List<ScrapDTO> scrapList(String memberId) {
		return boardMapper.scrapList(memberId);
	}

}
