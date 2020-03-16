package com.boseong.swdo3th.VO;

import lombok.Data;

@Data
public class Reply {
	private int  	reply_no;		
	private int 	board_no;		
	private String  reply_content;	
	private String	member_id;		
	private String  reply_indate;	
	
}
