package com.pompom.www.board.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ScrapDTO {
	
	/* 스크랩번호 */
	private Long sno;
	/* 게시글번호 */
	private Long bno;
	/* ID */
	private String memberId;
	/* 스크랩날짜 */
	private Date createDate;

	private String title;
	private String topikname;
}
