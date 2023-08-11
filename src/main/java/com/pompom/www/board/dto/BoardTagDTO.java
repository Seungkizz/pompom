package com.pompom.www.board.dto;

import java.util.List;

import lombok.Data;

@Data
public class BoardTagDTO {
	
	/* 게시글번호 */
	private long Bno;
	
	private String name;
	
	private List<TagDTO> tagDTO;
}
