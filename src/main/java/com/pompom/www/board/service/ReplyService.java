package com.pompom.www.board.service;

import java.util.List;

import com.pompom.www.board.dto.ReplyDTO;

public interface ReplyService {

	int insert(ReplyDTO replyDTO);

	List<ReplyDTO> getList(long bno);

	int replyModify(long rno, String content);

	int replydelete(long rno);

	int likeUp(long rno);



}
