package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class Photo {
/*	칼럼명				자료형				널값 가능여부
	DOCUMENT_NO			NUMBER				No	
	GROUP_NO			NUMBER				No
	PHOTO_ORIGINFILE	VARCHAR2(100 BYTE)	Yes	
	PHOTO_SAVEDFILE		VARCHAR2(100 BYTE)	Yes	
	PHOTO_NO			NUMBER				No	
*/	
	private int 	document_no;
	private int 	group_no;
	private String 	photo_originfile;
	private String 	photo_savedfile;
	private int 	photo_no;

}
