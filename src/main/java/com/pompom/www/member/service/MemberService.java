package com.pompom.www.member.service;

import com.pompom.www.member.dto.MemberDTO;

public interface MemberService {

	MemberDTO idCheck(String memberId);

	void regist(MemberDTO memberDTO);

	MemberDTO findOneById(String memberId);

	void activeScoreUp(String memberId);

	int nameUpdate(MemberDTO memberDTO);


}
