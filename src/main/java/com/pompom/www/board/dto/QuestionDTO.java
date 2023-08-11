package com.pompom.www.board.dto;

import java.util.Date;

import lombok.Data;

@Data
public class QuestionDTO {
	/* 게시글번호 */
	private long Bno;
	/* 게시글 타입 */
	private long boardId;
	/* 주제 */
	private long topikId;
	/* 제목 */
	private String title;
	/* 내용 */
	private String content;
	/* 게시글작성일 */
	private Date createDate;
	/* 게시글수정일 */
	private Date modifyDate;
	/* 좋아요수 */
	private long likes;
	/* 조회수 */
	private long views;
	/* 작성아이디 */
	private String memberId;
	/* 댓글 개수 */
	private int replyCnt;

	/* 해쉬태그 이름 */
	private String hashtag;

	/* uuid */
	private String uuid;
	/* 경로 */
	private String uploadpath;
	/* 파일이름 */
	private String filename;
	/* 파일타입 */
	private boolean filetype;
}
