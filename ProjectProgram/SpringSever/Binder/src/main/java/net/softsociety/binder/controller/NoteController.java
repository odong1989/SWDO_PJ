package net.softsociety.binder.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
		ArrayList<HashMap<String,Object>> list = noteDao.selectNote(member_id);
		int cnt = list.size();
		model.addAttribute("nlist", list);
		model.addAttribute("noteCnt", cnt);
		return "note/noteList";
	}
	
	@RequestMapping(value="noteWrite", method=RequestMethod.GET)
	public String noteWrite(@RequestParam(name = "id", defaultValue = "n1o2i3d4") String id, Model model)
	{
		log.info("id값 확인 : {}",id);
		if(id.equals("n1o2i3d4")) {
			log.info("쪽지 작성 폼으로 이동");
		} else {
			log.info("{}에게 답장 폼으로 이동", id);
			model.addAttribute("receiver", id);
		}
		return "note/noteWrite";
	}
	
	@RequestMapping(value="noteSend", method=RequestMethod.POST)
	public String noteSend(HttpSession session, Note note)
	{
		log.info("쪽지 작성 {}", note);
		String member_id = (String)session.getAttribute("loginId");
		note.setMember_id(member_id);
		noteDao.insertNote(note);
		return "redirect:/note/noteList";
	}
	
	@RequestMapping(value="noteRead", method=RequestMethod.GET)
	@ResponseBody
	public Note noteRead(HttpSession session, int no, Model model)
	{
		log.info("쪽지 읽기 {}", no);
		Note note = noteDao.selectNoteOne(no);
		noteDao.noteReadDone(no);
		return note;
	}
	
	//이 메서드를 호출하여 사용할 일은 없지만 쪽지 수신확인을 위한 코드는 여기서 가져갈 것
	@RequestMapping(value="newNoteCheck", method=RequestMethod.GET)
	public String newNoteCheck(HttpSession session, Model model)
	{
		String member_id = (String) session.getAttribute("loginId");
		ArrayList<Note> memoCheck = noteDao.newNoteCheck(member_id);
		
		if (memoCheck == null){
			model.addAttribute("newNoteCheck", "nashi");
		} else {
			model.addAttribute("newNoteCheck", "ari");
		}
		return "note/noteList";
	}
}