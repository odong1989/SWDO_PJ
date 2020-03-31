package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Photo {
		/*	
 		create table bnd_photo(
		    document_no         number          not null
		    , photo_originfile  varchar2(100)
		    , photo_savedfile   varchar2(100)
		    , photo_no          number          primary key
		    , constraint photo_photo_no_fk foreign key (photo_no)
		    references bnd_photo(photo_no) on delete cascade
		);
		create sequence bnd_photo_no_seq;
		 */
	
    private int 	document_no;
    private String  photo_originfile;
    private String  photo_savedfile;
    private int 	photo_no;	
}
