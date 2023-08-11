package com.pompom.www.board.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReplyDTO {

	private long rno;
	private long bno;
	private String content;
	private Date createDate;
	private Date modifyDate;
	private long likes;
	private String memberId;

}
