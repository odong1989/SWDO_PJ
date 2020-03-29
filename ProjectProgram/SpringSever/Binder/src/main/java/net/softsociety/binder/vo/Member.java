package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Member {
	/*
	 	create table member(
		member_id			varchar2(30)  primary key
		,member_pw			varchar2(30)  Not Null
		,member_name		varchar2(30)  Not Null
		,member_mail		varchar2(30)  Not Null
		,member_photo		varchar2(40)
		,member_phone		varchar2(13)
		,member_birthday	date          Not Null
		,member_married		number(1)     default 0
		,member_weddingday	date
		,member_regdate		date          default sysdate
		,member_lastlogin	date
		,member_wdraw		number(1)     default 0
		);
	 */
	private String 	member_id;		
	private String 	member_pw;		
	private String 	member_name;
	private String 	member_mail;
	private String 	member_photo;	
	private String 	member_phone;		
	private String 	member_birthday;	
	private String 	member_married;	
	private String 	member_weddingday;	
	private String 	member_regdate;
	private String 	member_lastlogin;
	private int 	member_wdraw;

}
