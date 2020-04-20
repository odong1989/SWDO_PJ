package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Document {
/*
create table bnd_document(
    group_no           	 	number          not null
    , document_no      		number          primary key
    , member_id        		varchar2(30)    not null
    , document_content  	varchar2(600)   not null
    , document_regdate  	date            default sysdate
    , document_finalday 	date            default sysdate
    , document_destination  varchar2(300)
    
    , constraint document_group_no_fk foreign key (group_no)
    references bnd_group(group_no) on delete cascade
    , constraint document_member_id_fk foreign key (member_id)
    references bnd_member(member_id) on delete cascade
);

create sequence bnd_document_no_seq;
*/
	private int group_no;
	private int document_no;
	private String member_id;
	private String document_content;
	private String document_regdate;
	private String document_finalday;
	private String document_destination;
	private int document_notice;
}
