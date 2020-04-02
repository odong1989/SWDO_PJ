package net.softsociety.binder.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.binder.vo.Note;

@Slf4j
@Repository
public class NoteDAO {
	
	@Autowired
	private SqlSession session;

	public ArrayList<Note> selectNote(String member_id) {
		ArrayList<Note> result = null;
		try {
			log.info("쪽지 불러오기 : {}",member_id);
			NoteMapper mapper = session.getMapper(NoteMapper.class);
			result = mapper.selectNote(member_id);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}	
	
	public int insertNote(Note note) {
		int result = 0;
		try {
			log.info("{쪽지 작성 : }",note);
			NoteMapper mapper = session.getMapper(NoteMapper.class);
			result = mapper.insertNote(note);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public ArrayList<Note> newNoteCheck(String member_id) {
		ArrayList<Note> result = null;
		try {
			log.info("새 쪽지 확인 : {}",member_id);
			NoteMapper mapper = session.getMapper(NoteMapper.class);
			result = mapper.newNoteCheck(member_id);
			log.info("{} 에게 온 쪽지 : {}",member_id,result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public Note selectNoteOne(int note_no) {
		Note result = null;
		try {
			log.info("쪽지 읽기 : {}",note_no);
			NoteMapper mapper = session.getMapper(NoteMapper.class);
			result = mapper.selectNoteOne(note_no);
			log.info("{}번 글 : {}",note_no,result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	public int noteReadDone(int note_no) {
		int result = 0;
		try {
			log.info("쪽지 읽었음 : {}",note_no);
			NoteMapper mapper = session.getMapper(NoteMapper.class);
			result = mapper.noteReadDone(note_no);
			log.info("{}번 글 : {}",note_no,result);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return result;
}
}
