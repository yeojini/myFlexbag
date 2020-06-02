package com.vo;

import org.springframework.web.util.UriComponentsBuilder;

public class PageVO {
	private int totalCount; //전체 게시글 갯수
	private int startPage; //시작 페이지 번호
	private int endPage; //끝 페이지 번호
	private boolean prev; //이전 페이지 링크 : 시작 페이지 번호가 1이 아니라면 이전 페이지 조회 가능
	private boolean next; //다음 페이지 링크 :끝 페이지 번호 이후 더 많은 게시글이 존재한다면 다음 페이지 조회 가능
	private String tablename;
	private String userid;
	
	private int displayPageNum = 10;  //하단의 페이지 번호의 개수
	//화면 하단 페이지 수
	
	private int page=1;
	private int perPageNum=15;//한 페이지당 상품수
	
	//게시글의 전체 갯수 설정되는 시점에 호출하여 데이터 계산
	//끝 페이지 번호 = Math.ceil(현재페이지 / 페이지 번호의 갯수) * 페이지 번호의 개수
	//시작 페이지 번호 = (끝 페이지 번호 - 페이지 번호의 갯수 +1)
	public void calcData(int page) {
		this.page = page;
		endPage = (int) (Math.ceil( page / (double) displayPageNum) *displayPageNum );
		startPage = (endPage - displayPageNum) + 1;
		
		//끝 페이지 번호 보정 계산식 
		//끝 페이지 번호 = Math.ceil(전체 개시글 갯수 / 페이지 당 출력할 게시글의 갯수)
		int tempEndPage = (int) (Math.ceil(totalCount / (double) perPageNum ));
		
		//이전 결과 값과 보정 결과 값을 비교해 보정한 결과 값을 페이지 끝 번호 변수에 저장
		if (endPage > tempEndPage) {
			endPage = tempEndPage;
		}
		
		//이전 링크 : 시작페이지 번호가 1인지 아닌지 검사
		prev = startPage ==1 ? false : true;
		
		//다음 링크 = 끝페이지 * 페이지 당 출력할 게시글의 갯수 >= 전체 게시글의 갯수 이면 false, 아니면 true
		next = endPage * perPageNum >= totalCount ? false : true;
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPerPageNum() {
		return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
		this.perPageNum = perPageNum;
	}
	public String getTablename() {
		return tablename;
	}
	public void setTablename(String tablename) {
		this.tablename = tablename;
	}
	
	
	@Override
	public String toString() {
		return "PageVO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", tablename=" + tablename + "]";
	}
	
	private String cateid;
	private String sizeid;
	private String colorid;
	private String brandid;
	private String matid;
	
	private String sortcon;
	private String sortorder; //ASC, DESC
	private String searchcon;
	private String searchkwd;

	public String getCateid() {
		return cateid;
	}
	public void setCateid(String cateid) {
		this.cateid = cateid;
	}
	public String getSizeid() {
		return sizeid;
	}
	public void setSizeid(String sizeid) {
		this.sizeid = sizeid;
	}
	public String getColorid() {
		return colorid;
	}
	public void setColorid(String colorid) {
		this.colorid = colorid;
	}
	public String getBrandid() {
		return brandid;
	}
	public void setBrandid(String brandid) {
		this.brandid = brandid;
	}
	public String getMatid() {
		return matid;
	}
	public void setMatid(String matid) {
		this.matid = matid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getSortcon() {
		return sortcon;
	}
	public void setSortcon(String sortcon) {
		this.sortcon = sortcon;
	}
	public String getSortorder() {
		return sortorder;
	}
	public void setSortorder(String sortorder) {
		this.sortorder = sortorder;
	}
	public String getSearchcon() {
		return searchcon;
	}
	public void setSearchcon(String searchcon) {
		this.searchcon = searchcon;
	}
	public String getSearchkwd() {
		return searchkwd;
	}
	public void setSearchkwd(String searchkwd) {
		this.searchkwd = searchkwd;
	}
	
	//이전 화면 페이징 정보 저장을 위한 UriComponetsBuilder
	public String getListLink() {
		UriComponentsBuilder builder= UriComponentsBuilder
			.fromPath("")
			.queryParam("page", this.getPage());
//			.queryParam("perPageNum", this.getPerPageNum());
			if (this.getCateid() != null && this.getCateid() !="") builder = builder.queryParam("cateid", this.getCateid());
			if (this.getBrandid() != null && this.getBrandid() !="") builder = builder.queryParam("brandid", this.getBrandid());
			if (this.getMatid() != null && this.getMatid() !="") builder = builder.queryParam("matid", this.getMatid());
			if (this.getSortcon() != null && this.getSortcon() !="") builder = builder.queryParam("sortcon", this.getSortcon());
//			.queryParam("page", this.getPage())
			
			return builder.build().toString(); 
	}
	
}
