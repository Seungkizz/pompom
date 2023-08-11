package com.pompom.www.board.mapper;

import java.util.List;
import java.util.Map;

import com.pompom.www.board.dto.BoardDTO;
import com.pompom.www.board.dto.BoardTagCountDTO;
import com.pompom.www.board.dto.BoardTagDTO;
import com.pompom.www.board.dto.BoardTopWritersDTO;
import com.pompom.www.board.dto.PagingVO;
import com.pompom.www.board.dto.QuestionDTO;
import com.pompom.www.board.dto.ScrapDTO;
import com.pompom.www.board.dto.TagDTO;

public interface BoardMapper {

	// 글작성
	int write(BoardDTO boardDTO);

	//  questions 게시판 글목록 가져오기
	List<BoardDTO> questionsList(PagingVO vo);
	
	// 태그 리스트 가져오기
	List<String> selectTagList(String param);

	// 태그 작성
	void writeTag(TagDTO tagDTO);

	// 게시판태그 작성
	void writeBoardTag(List<Map> tagIdList);

	// 글 총  개수
	int getTotalQuestions();

	// 조회수 증가
	void viewsUp(long bno);

	// 특정 글 가져오기
	List<BoardDTO> questionsGet(long bno);

	// 태그 가장 많이 쓰인거 가져오기
	List<BoardTagCountDTO> tagCountList();

	// 글 가장 많이 쓴 유저 가져오기
	List<BoardTopWritersDTO> topWriterList();

	// 게시판에 달린 태그 가져오기
	List<BoardTagDTO> BoardTagList();

	// 태그 찾아오기
	TagDTO searchTag(String tag);

	int boardTagDelete(long bno);

	int delete(long bno);

	List<BoardDTO> mainQuestionsList();

	int modify(BoardDTO boardDTO);

	int likesUp(long bno);

	List<QuestionDTO> searchHashTag(String tagName);

	void scrapInsert(ScrapDTO scrapDTO);

	int scrapCheck(ScrapDTO scrapDTO);

	void scrapCancel(ScrapDTO scrapDTO);

	List<ScrapDTO> scrapList(String memberId);




	


	




}
