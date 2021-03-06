package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Note {
/*
create table bnd_note(
        note_no             number          primary key
    , note_title      varchar2(20)   not null
    , note_content      varchar2(100)   not null
    , member_id         varchar2(30)    not null
    , note_receiver     varchar2(30)    not null
    , note_read     number(1)    default 0
    , constraint note_member_id_fk foreign key (member_id)
    references bnd_member(member_id) on delete cascade
    , constraint note_note_receiver_fk foreign key (note_receiver)
    references bnd_member(member_id) on delete cascade
);

*/
	private int note_no;
	private String note_title;
	private String note_content;
	private String member_id;
	private String note_receiver;
	private int note_read;
	private String note_date;

}
