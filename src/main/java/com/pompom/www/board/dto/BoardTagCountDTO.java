package com.pompom.www.board.dto;

import lombok.Data;

@Data
public class BoardTagCountDTO {
	
	private long tagId;
	private String name;
	private long usage_count;
	
}
