package com.pompom.www.upload.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pompom.www.member.dto.MemberDTO;
import com.pompom.www.member.mapper.MemberMapper;
import com.pompom.www.upload.dto.AttachDTO;
import com.pompom.www.upload.mapper.UploadMapper;

import lombok.extern.log4j.Log4j;

@Transactional
@Service
@Log4j
public class UploadServiceImpl implements UploadService {

	@Autowired
	private UploadMapper uploadMapper;

	@Override
	public void insertMemberImg(AttachDTO attachDTO) {
		log.info("attachDTO >>> memberid " + attachDTO.getMemberId());
		String memberId = attachDTO.getMemberId();
		AttachDTO attach = uploadMapper.selectOne(memberId);

		if (attach != null) {
			uploadMapper.delete(attachDTO.getMemberId());
		}
		uploadMapper.insertMemberImg(attachDTO);
	}

	@Override
	public AttachDTO selectAttach(String memberId) {
		return uploadMapper.selectOne(memberId);
	}

	@Override
	public List<AttachDTO> selectAll() {
		return uploadMapper.selectAll();
	}

	@Override
	public int delete(String memberId) {
		return uploadMapper.delete(memberId);
		
	}


}
