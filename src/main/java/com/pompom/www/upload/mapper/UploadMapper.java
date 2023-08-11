package com.pompom.www.upload.mapper;

import java.util.List;

import com.pompom.www.upload.dto.AttachDTO;

public interface UploadMapper {

	void insertMemberImg(AttachDTO attachDTO);

	AttachDTO selectOne(String memberId);

	int delete(String memberId);

	List<AttachDTO> selectAll();

	List<AttachDTO> getOldFiles();

	void insertBoardImg(AttachDTO attach);

	List<AttachDTO> selectByBno(long bno);

	void deleteAll(long bno);


}
