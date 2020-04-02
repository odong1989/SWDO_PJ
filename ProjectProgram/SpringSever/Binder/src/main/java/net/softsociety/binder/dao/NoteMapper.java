package net.softsociety.binder.dao;

import java.util.ArrayList;
import java.util.HashMap;

import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.Note;


public interface NoteMapper {

	public ArrayList<Note> selectNote(String member_id);
	
	public int insertNote(Note note);

	public ArrayList<Note> newNoteCheck(String member_id);
	
	public Note selectNoteOne(int note_no);
	
	public int noteReadDone(int note_no);
}
