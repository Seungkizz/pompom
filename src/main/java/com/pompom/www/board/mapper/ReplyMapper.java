package com.pompom.www.board.mapper;

import java.util.List;

import com.pompom.www.board.dto.ReplyDTO;

public interface ReplyMapper {

	int insert(ReplyDTO replyDTO);

	List<ReplyDTO> getList(long bno);

	int replyModify(long rno, String content);

	int replyDelete(long rno);

	int likeUp(long rno);

}
