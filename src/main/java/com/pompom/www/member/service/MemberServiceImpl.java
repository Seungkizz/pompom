package com.pompom.www.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.member.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberMapper memberMapper;

	@Override
	public MemberDTO idCheck(String memberId) {
		MemberDTO memberDTO = memberMapper.selectOneById(memberId);
		return memberDTO;
	}

	@Override
	public void regist(MemberDTO memberDTO) {
		memberMapper.insert(memberDTO);
		
	}

	@Override
	public MemberDTO findOneById(String memberId) {

		return memberMapper.selectOneById(memberId);
	}

	@Override
	public void activeScoreUp(String memberId) {
		memberMapper.activeScoreUp(memberId);
		
	}

	@Override
	public int nameUpdate(MemberDTO memberDTO) {
		return memberMapper.nameUpdate(memberDTO);
	}

}
