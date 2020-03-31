package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class HashTag {
/*
create table bnd_hashtag(
    hash_no             number          primary key
    , hash_tag          varchar2(100)   not null
    , document_no       number          not null
    , constraint hashtag_document_no_fk foreign key (document_no)
    references bnd_document(document_no) on delete cascade
);

create sequence bnd_hash_no_seq;
*/
	
	private int hash_no;
	private String hash_tag;
	private int document_no;

}
