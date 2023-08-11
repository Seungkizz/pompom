package com.pompom.www.board.dto;

import java.util.Date;
import java.util.List;

import com.pompom.www.upload.dto.AttachDTO;

import lombok.Data;

@Data
public class BoardDTO {
	
	 /* 게시글번호 */
	private long Bno;
	/*게시글 타입*/
	private long boardId;
	/* 주제 */
	private long  topikId;
	/* 제목 */
	private String  title;
	/* 내용 */
	private String  content;
	/* 게시글작성일 */
	private Date  createDate;
	/* 게시글수정일 */
	private Date  modifyDate;
	/* 좋아요수 */
	private long likes;
	/* 조회수 */
	private long views;
	/* 작성아이디 */
	private String  memberId;
	/* 댓글 개수*/
	private int replyCnt;
	
	private List<TopikDTO> topikDTO;
	private List<BoardTagDTO> boardTagDTO;
	private List<AttachDTO> attachList;

	
}
