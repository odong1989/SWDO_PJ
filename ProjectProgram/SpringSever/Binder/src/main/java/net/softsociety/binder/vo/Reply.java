package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Reply {
	private int  	reply_no;		
	private int 	document_no;		
	private String  reply_content;	
	private String	member_id;		
	private String  reply_regdate;	
	
}
