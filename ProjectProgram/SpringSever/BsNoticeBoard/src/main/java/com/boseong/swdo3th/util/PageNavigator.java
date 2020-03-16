package com.boseong.swdo3th.util;

/**
 * 게시판 페이징 처리 클래스
 * 페이스북의 무한스크롤도 따져보면 이렇게 페이징 처리를 실시하였기에 무한인것처럼 자동로드하듯이 하는것이다.
 */
public class PageNavigator {
	//페이지 관련 정보 
	private int countPerPage;		//페이지당 글목록 수(#몇페이지씩 보여줄거냐?)
	private int pagePerGroup;		//그룹당 페이지 수 (#몇 페이지씪 넘길거냐?)
	private int currentPage;		//현재 페이지 (최근 글이 1부터 시작)
	private int totalRecordsCount;	//전체 글 수
	private int totalPageCount;		//전체 페이지 수
	private int currentGroup;		//현재 그룹 (최근 그룹이 0부터 시작)
	private int startPageGroup;		//현재 그룹의 첫 페이지
	private int endPageGroup;		//현재 그룹의 마지막 페이지
	private int startRecord;		//전체 레코드 중 현재 페이지 첫 글의 위치 (0부터 시작)
	//핵심은 계산은 쉽게 하려고 0으로 하고, -1을 실시하였다는 점이다.
	
	/*
	 * 생성자
	 */
	public PageNavigator(int countPerPage, int pagePerGroup, int currentPage, int totalRecordsCount) {
		//페이지당 글 수, 그룹당 페이지 수, 현재 페이지, 전체 글 수를 전달받음
		this.countPerPage = countPerPage;			
		this.pagePerGroup = pagePerGroup;
		this.totalRecordsCount = totalRecordsCount;
		//위의 3개는 사용자가 입력한 값을 그대로 받아들인다.
		
		//전체 페이지 수
		totalPageCount = (totalRecordsCount + countPerPage - 1) / countPerPage;
											//countPerPage : 몇페이지씩 보여줄거냐?
		//-1을 하는 이유 :100페이지처럼 딱 떨어지는 경우 쓸데없이 11번쨰 페이지가 생성된다.
		// 이러한 null값처럼 텅빈, 쓸데없는 페이지가 생성되지 않도록 하기위해 -1을 실시한다.
		
		//전달된 현재 페이지가 1보다 작으면 현재페이지를 1페이지로 지정
		//게시판의 왼쪽화살표를 클릭하면 0이하의 값이 입력됩니다.
		if (currentPage < 1)	currentPage = 1;
		//전달된 현재 페이지가 마지막 페이지보다 크면 현재페이지를 마지막 페이지로 지정
		if (currentPage > totalPageCount)	currentPage = totalPageCount;
		
		//바뀐페이지를 지금의 현재페이지에게 넣음으로서 페이지를 업데이트합니다.
		this.currentPage = currentPage;

		//현재 그룹
		currentGroup = (currentPage - 1) / pagePerGroup;
		//- 1의 이유는 소수점
		
		//현재 그룹의 첫 페이지
		//첫페이지는 0그룹에 해당하고 그래서 +1을 하여 페이지1라고 처리한다.
		startPageGroup = currentGroup * pagePerGroup + 1;
		
		//현재 그룹의 첫 페이지가 1보다 작으면 1로 처리
		startPageGroup = startPageGroup < 1 ? 1 : startPageGroup;

		//현재 그룹의 마지막 페이지
		endPageGroup = startPageGroup + pagePerGroup - 1;
		
		//현재 그룹의 마지막 페이지가 전체 페이지 수보다 작으면 전체페이지 수를 마지막으로.(#맨끝페이지가 11이면 그 이상을 넘어가지 못하게 한다.)
		endPageGroup = endPageGroup < totalPageCount ? endPageGroup : totalPageCount;

		//전체 레코드 중 현재 페이지 첫 글의 위치
		startRecord = (currentPage - 1) * countPerPage;	
		//현재페이지에서 -1하고 보여주고자 할 페이지
	}

	/*
	 * Getters and Setters
	 */
	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getPagePerGroup() {
		return pagePerGroup;
	}

	public void setPagePerGroup(int pagePerGroup) {
		this.pagePerGroup = pagePerGroup;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalRecordsCount() {
		return totalRecordsCount;
	}

	public void setTotalRecordsCount(int totalRecordsCount) {
		this.totalRecordsCount = totalRecordsCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getCurrentGroup() {
		return currentGroup;
	}

	public void setCurrentGroup(int currentGroup) {
		this.currentGroup = currentGroup;
	}

	public int getStartPageGroup() {
		return startPageGroup;
	}

	public void setStartPageGroup(int startPageGroup) {
		this.startPageGroup = startPageGroup;
	}

	public int getEndPageGroup() {
		return endPageGroup;
	}

	public void setEndPageGroup(int endPageGroup) {
		this.endPageGroup = endPageGroup;
	}

	public int getStartRecord() {
		return startRecord;
	}

	public void setStartRecord(int startRecord) {
		this.startRecord = startRecord;
	}

	@Override
	public String toString() {
		return "PageNavigator [countPerPage=" + countPerPage + ", pagePerGroup=" + pagePerGroup + ", currentPage="
				+ currentPage + ", totalRecordsCount=" + totalRecordsCount + ", totalPageCount=" + totalPageCount
				+ ", currentGroup=" + currentGroup + ", startPageGroup=" + startPageGroup + ", endPageGroup="
				+ endPageGroup + ", startRecord=" + startRecord + "]";
	}
	
}
