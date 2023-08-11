package com.pompom.www.board.service;

import java.util.List;

import com.pompom.www.board.dto.BoardDTO;
import com.pompom.www.board.dto.BoardTagCountDTO;
import com.pompom.www.board.dto.BoardTagDTO;
import com.pompom.www.board.dto.BoardTopWritersDTO;
import com.pompom.www.board.dto.PagingVO;
import com.pompom.www.board.dto.QuestionDTO;
import com.pompom.www.board.dto.ScrapDTO;
import com.pompom.www.upload.dto.AttachDTO;

public interface BoardService {

	int write(BoardDTO boardDTO, List<String> tagList);

	List<BoardDTO> questionsList(PagingVO vo);
	
	List<String> getTagList(String param);

	int getTotalQuestions();

	void viewsUp(long bno);

	List<BoardDTO> questionsGet(long bno);

	List<BoardTagCountDTO> tagCountList();

	List<BoardTopWritersDTO> topWriterList();

	List<BoardTagDTO> BoardTagList();

	int delete(long bno);

	List<BoardDTO> mainQuestionsList();

	int modify(BoardDTO boardDTO, List<String> tagList);

	int likesUp(long bno);

	List<AttachDTO> getAttachList(long bno);

	List<QuestionDTO> searchHashTag(String tagName);

	void scrapInsert(ScrapDTO scrapDTO);

	int scrapCheck(ScrapDTO scrapDTO);

	void scrapCancel(ScrapDTO scrapDTO);

	List<ScrapDTO> scrapList(String memberId);



	



}
