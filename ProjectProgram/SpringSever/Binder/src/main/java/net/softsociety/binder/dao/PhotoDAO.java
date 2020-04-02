package net.softsociety.binder.dao;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

//import com.sun.media.jfxmedia.logging.Logger;
import net.softsociety.binder.vo.Photo;


@Repository
public class PhotoDAO {
	private static final Logger logger = LoggerFactory.getLogger(PhotoDAO.class);	
	
	@Autowired
	private SqlSession session;
	
	
	public int photoInsert(Photo photo){
        int count =0;
        try {
               PhotoMapper mapper = session.getMapper(PhotoMapper.class);
               count = mapper.photoInsert(photo);
        }catch(Exception e) {
               e.printStackTrace();
               //파일을 삭제(물리적) -인셉션이 발생하면 실시.
        }
        return count;
		
	}
}
