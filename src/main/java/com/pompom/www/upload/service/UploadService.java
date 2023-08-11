package com.pompom.www.upload.service;

import java.util.List;

import com.pompom.www.upload.dto.AttachDTO;

public interface UploadService {

	void insertMemberImg(AttachDTO attachDTO);

	AttachDTO selectAttach(String memberId);

	List<AttachDTO> selectAll();

	int delete(String memberId);



}
