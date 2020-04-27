package net.softsociety.binder.util;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import net.softsociety.binder.vo.Reply;

@Data
@AllArgsConstructor
@Getter
public class ReplyPage {
	private int totalCount;
	private ArrayList<Reply> list;
	private PageNavigator page;
}
