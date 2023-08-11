package com.pompom.www.member.mapper;

import com.pompom.www.member.dto.MemberDTO;

public interface MemberMapper {

	MemberDTO selectOneById(String memberId);

	void insert(MemberDTO memberDTO);

	void activeScoreUp(String memberId);

	int nameUpdate(MemberDTO memberDTO);

	

}
