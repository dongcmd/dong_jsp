package model.board;

import java.util.Date;

public class Board {
	private int num;               // 글번호. 기본키
	private String writer;         // 작성자
	private String pass;           // 글 비번
	private String title;          // 제목
	private String content;        // 내용
	private String file1;          // 첨부파일
	private String boardid;        // 게시판 종류(1 공지사항, 2 자유)
	private Date regdate;  		   // 글 등록일시
	private int readcnt;           // 조회수
	private int grp;               // 답글 작성시 원글의 게시글 번호
	private int grplevel;          // 답글의 레벨
	private int grpstep;           // 그룹의 출력 순서
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getFile1() {
		return file1;
	}
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public int getReadcnt() {
		return readcnt;
	}
	public void setReadcnt(int readcnt) {
		this.readcnt = readcnt;
	}
	public int getGrp() {
		return grp;
	}
	public void setGrp(int grp) {
		this.grp = grp;
	}
	public int getGrplevel() {
		return grplevel;
	}
	public void setGrplevel(int grplevel) {
		this.grplevel = grplevel;
	}
	public int getGrpstep() {
		return grpstep;
	}
	public void setGrpstep(int grpstep) {
		this.grpstep = grpstep;
	}
	@Override
	public String toString() {
		return "Board [num=" + num + ", writer=" + writer + ", pass=" + pass + ", title=" + title + ", content="
				+ content + ", file1=" + file1 + ", boardid=" + boardid + ", regdate=" + regdate + ", readcnt="
				+ readcnt + ", grp=" + grp + ", grplevel=" + grplevel + ", grpstep=" + grpstep + "]";
	}
	
}
