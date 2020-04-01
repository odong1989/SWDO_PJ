package net.softsociety.binder.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;
import net.softsociety.binder.dao.GroupDAO;
import net.softsociety.binder.dao.MemberDAO;
import net.softsociety.binder.dao.NoteDAO;
import net.softsociety.binder.vo.Group;
import net.softsociety.binder.vo.Member;
import net.softsociety.binder.vo.Note;

@Controller
@Slf4j
@RequestMapping(value="note/")
public class NoteController {
	
	@Autowired
	NoteDAO noteDao;
	@Autowired
	GroupDAO groupDao;
	
	@RequestMapping(value="noteList", method=RequestMethod.GET)
	public String noteList(HttpSession session, Model model)
	{	
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Note> list = noteDao.selectNote(member_id);
		model.addAttribute("nlist", list);
		return "note/noteList";
	}
	
	@RequestMapping(value="noteSend", method=RequestMethod.GET)
	public String noteSend(HttpSession session, Note note)
	{	
		log.info("쪽지 작성 {}", note);
		noteDao.insertNote(note);
		return "redirect:note/noteList";
	}
	
	//이 메서드를 불러서 사용할 일은 없지만 쪽지 수신확인을 위한 코드는 여기서 가져갈 것
	@RequestMapping(value="newNoteCheck", method=RequestMethod.GET)
	public String newNoteCheck(HttpSession session, Model model)
	{	
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Note> list = noteDao.newNoteCheck(member_id);
		if (list == null){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		return "note/noteList";
	}

}