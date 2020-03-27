package net.softsociety.binder.vo;

import lombok.Data;

@Data
public class MailVO {

	private String from;
	private String to;
	private String subject;
	private String contents;
	public MailVO(String from, String to, String subject, String contents) {
		super();
		this.from = from;
		this.to = to;
		this.subject = subject;
		this.contents = contents;
	}
	
	
}
