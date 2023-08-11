package com.pompom.www.upload.dto;

import lombok.Data;

@Data
public class AttachDTO {

	/* uuid */
	private String uuid;
	/* 경로 */
	private String uploadpath;
	/* 파일이름 */
	private String filename;
	/* 파일타입 */
	private boolean filetype;
	/* 게시글번호 */
	private long bno;
	/* 회원 아이디 */
	private String memberId;

}
