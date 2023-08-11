package com.pompom.www.member.dto;

import java.util.Date;
import java.util.List;

import com.pompom.www.upload.dto.AttachDTO;

import lombok.Data;

@Data
public class MemberDTO {
	
	/* ID */
	private String memberId;
	/* 비밀번호 */
	private String password;
	/* 이름 */
	private String name;
	/* 이메일 */
	private String email;
	/* 이메일 인증번호 */
	private String emailCheckno;
	/* 회원가입일 */
	private Date createdDate;
	/* 수정날짜 */
	private Date modifyDate;
	/* 활동점수 */
	private long activeScore;
	
}
