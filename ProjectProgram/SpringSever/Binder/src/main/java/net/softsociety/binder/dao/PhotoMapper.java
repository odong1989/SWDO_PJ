package net.softsociety.binder.dao;


import net.softsociety.binder.vo.Photo;


public interface PhotoMapper {

	public int photoInsert(Photo photo); //1개의 사진을 DB와 업로드경로에 저장합니다.
	public Photo selectPhotoOne(int	document_no); //1개의 글과 문서번호가 같은 사진을 가져올 때 사용합니다.
	
}
