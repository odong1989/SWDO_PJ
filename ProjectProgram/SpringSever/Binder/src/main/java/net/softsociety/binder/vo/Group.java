package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Group {
/*
create table bnd_group(
    group_no            number          primary key
    , group_category    varchar2(30)    not null
    , group_subcategory varchar2(50)    
    , group_name        varchar2(100)   not null
    , group_regdate     date            default sysdate
    , group_code        varchar2(5)
    , group_codedate    date            default sysdate
);

create sequence bnd_group_no_seq;
*/
	private int group_no;
	private String group_category;
	private String  group_subcategory;    
	private String  group_name;
	private String  group_regdate;
	private String  group_code;
	private String  group_codedate;
}
