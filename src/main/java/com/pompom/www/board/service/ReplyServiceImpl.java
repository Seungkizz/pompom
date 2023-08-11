package com.pompom.www.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pompom.www.board.dto.ReplyDTO;
import com.pompom.www.board.mapper.ReplyMapper;

import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	@Override
	public int insert(ReplyDTO replyDTO) {

		return replyMapper.insert(replyDTO);
	}

	@Override
	public List<ReplyDTO> getList(long bno) {

		return replyMapper.getList(bno);
	}

	@Override
	public int replyModify(long rno, String content) {
		return replyMapper.replyModify(rno, content);
	}

	@Override
	public int replydelete(long rno) {
		return replyMapper.replyDelete(rno);
	}

	@Override
	public int likeUp(long rno) {
		return replyMapper.likeUp(rno);
	}

}
