package controller;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.board.Board;
import model.board.BoardDao;

@WebServlet(urlPatterns = {"/board/*"},
	initParams = {@WebInitParam(name = "view", value="/view/")})
public class BoardController extends MskimRequestMapping {
	private BoardDao dao = new BoardDao();
	
	public String noticecheck(HttpServletRequest request,
			HttpServletResponse response) {
		String boardid = (String)request.getSession().getAttribute("boardid");
		if(boardid == null) boardid = "1";
		String login = (String)request.getSession().getAttribute("login");
		if(boardid.equals("1")) {
			if(login == null || !login.equals("admin")) {
				request.setAttribute("msg", "공지사항은 관리자만 작성가능");
				request.setAttribute("url", 
						request.getContextPath() +
							"/board/list?boardid=" + boardid);
				return "alert";
			}
		}
		return null;
	}
	
	@RequestMapping("writeForm")
	@MSLogin("noticecheck")
	public String writeForm(HttpServletRequest request,
			HttpServletResponse response) {
		return "board/writeForm";
	}
	@RequestMapping("write")
	@MSLogin("noticecheck")
	public String write(HttpServletRequest request, HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "/upload/board/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		int size = 10 * 1024 * 1024;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, path, size, "UTF-8");
		} catch(IOException e) {
			e.printStackTrace();
		}
		// 파라미터 값 저장
		Board board = new Board();
		board.setWriter(multi.getParameter("writer"));
		board.setPass(multi.getParameter("pass"));
		board.setTitle(multi.getParameter("title"));
		board.setContent(multi.getParameter("content"));
		board.setFile1(multi.getFilesystemName("file1"));
		// 시스템에 필요한 정보 저장
		String boardid = (String)request.getSession().getAttribute("boardid");
		if(boardid == null) boardid = "1";
		board.setBoardid(boardid); // 게시판 종류 1: 공지, 2 : 자유
		if(board.getFile1() == null) board.setFile1("");
		
		int num = dao.maxnum();
		board.setNum(++num); // 키값, 글 번호
		board.setGrp(num); // 그룹번호. 원글인 경우 그룹번호 == 게시글 번호
		String msg = "게시물 등록 실패";
		String url = "writeForm";
		if(dao.insert(board)) { // 글 등록 성공
			return "redirect:list?boardid=" + boardid;
		} // 글 등록 실패
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	
	@RequestMapping("list")
	public String list(HttpServletRequest request,
			HttpServletResponse response) {
		// pageNum 파라미터가 존재하면 파라미터 값을 pageNum에 저장
		// pageNum 파라미터가 없으면 1로 저장
		int pageNum = 1;
		try {
			pageNum = Integer.parseInt(request.getParameter("pageNum"));
		} catch (NumberFormatException e) {}
		// boardid 파라미터 값
		String boardid = request.getParameter("boardid");
		if(boardid == null || boardid.trim().equals("")) {
			boardid = "1";
		}
		// boardid값을 session에 등록
		request.getSession().setAttribute("boardid", boardid);
		boardid = (String)request.getSession().getAttribute("boardid");
		
		String column = request.getParameter("column");
		String find = request.getParameter("find");
		if(column == null || column.trim().equals("") 
			|| find == null || find.trim().equals("")) {
			column = null;
			find = null;
		}
		/*
		 * 검색 관련 파라미터 추가하기 column, find
		 * 두개가 동시 존재해야 함. 하나만 존재하면 둘 다 무시
		 */
		
		int limit = 10;
		int boardcount = dao.boardCount(boardid, column, find); //등록된 게시물 건수
		// pageNum에 해당하는 게시물 목록을 db에서 조회
		List<Board> list = dao.list(boardid,pageNum,limit, column, find);
	    int maxpage = (int)Math.ceil(1.0*boardcount/limit);
	    int startpage=((int)Math.ceil(pageNum/10.0) - 1) * 10 + 1;
	    int endpage = Math.min(startpage + 9, maxpage);
	    if(endpage > maxpage) endpage = maxpage;
	    String boardName = "공지사항";
	    if (boardid.equals("2")) 
			boardName = "자유게시판";
	    request.setAttribute("boardName", boardName); // 게시판명
	    request.setAttribute("boardcount", boardcount); // 게시글 수
	    request.setAttribute("boardid", boardid);		// 게시판코드
	    request.setAttribute("pageNum", pageNum);		// 현재페이지
	    request.setAttribute("list", list);		// 출력할 게시물 목록
	    request.setAttribute("startpage", startpage); // 페이지 시작번호
	    request.setAttribute("endpage", endpage);	// 페이지 마지막번호
	    request.setAttribute("maxpage", maxpage);	// 페이지 최대번호
	    // boardnum 보여주기 위한 번호
	    int boardnum = boardcount - (pageNum-1)*limit;
	    request.setAttribute("boardnum", boardnum);
	    request.setAttribute("today", new Date());
	    return "board/list";
	}
	@RequestMapping("info")
	public String info(HttpServletRequest request,
			HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		dao.readcntAdd(num);
		
		String boardid = b.getBoardid();
		String boardName = "공지사항";
		if(boardid.equals("2")) boardName = "자유게시판";;
		request.setAttribute("b", b);
		request.setAttribute("boardName", boardName);
		return "board/info";
	}
		/*
		 * 1. num 파라미터 저장
		 * 2. num의 게시물을 db에서 조회
		 * 		Board b = dao.selectOne(num)
		 * 3. 게시물의 조회 수 1 증가
		 * 		dao.readcntAdd(num)
		 * 4. 조회된 게시물 화면에 전달
		 */
	
	@RequestMapping("replyForm")
	@MSLogin("noticecheck")
	public String replyForm(HttpServletRequest request,
			HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		request.setAttribute("b", b);
		return "board/replyForm";
	}
	
	@RequestMapping("reply")
	@MSLogin("noticecheck")
	public String reply(HttpServletRequest request,
			HttpServletResponse response) {
		Board oB = dao.selectOne(
				Integer.parseInt(request.getParameter("num")));
		Board rB = new Board();
		rB.setWriter(request.getParameter("writer"));
		rB.setPass(request.getParameter("pass"));
		rB.setTitle(request.getParameter("title"));
		rB.setContent(request.getParameter("content"));
		
		dao.grpstepAdd(oB.getGrp(), oB.getGrpstep());
		
		rB.setNum(dao.maxnum() + 1);
		rB.setGrp(oB.getGrp());
		rB.setGrplevel(oB.getGrplevel() + 1);
		rB.setGrpstep(oB.getGrpstep() + 1);
		rB.setBoardid(oB.getBoardid());
		if(dao.insert(rB)) {
			return "redirect:list?boardid=" + rB.getBoardid();
		} else {
			request.setAttribute("msg", "답변 등록 실패");
			request.setAttribute("url", "replyForm?num=" + oB.getNum());
			return "alert";
		}
	}
	/*
	 * 1. 파라미터 값을 Board 객체에 저장
	 * 	원글 정보 : num, grp, grplevel, grpstep, boardid
	 * 	답글 정보 : writer, pass, title, content => 입력한 내용
	 * 2. 같은 grp에 속하는 게시물들의 grpstep 값을 1 증가
	 * 		dao.grpStepAdd(grp, grpstep)? grp만 보내도 됨
	 * 3. Board에 저장된 답글 정보 db에 추가
	 * 		num : maxnum + 1
	 * 		grp : 원글과 동일
	 * 		grplevel : 원글 grplevel + 1
	 * 		grpstep : 원글 grpstep + 1
	 * 		boardid : 원글과 동일
	 * 4. 추가 성공 : list 로 페이지 이동
	 * 			실패 : replyForm 페이지 이동
	 */
	
	@RequestMapping("updateForm")
	@MSLogin("noticecheck")
	public String updateForm(HttpServletRequest request,
			HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		Board b = dao.selectOne(num);
		request.setAttribute("b", b);
		return "board/updateForm";
	}
	
	@RequestMapping("update")
	@MSLogin("noticecheck")
	public String update(HttpServletRequest request,
			HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("/") + "/upload/board/";
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		int size = 10 * 1024 * 1024;
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, path, size, "UTF-8");
		} catch(IOException e) {
			e.printStackTrace();
		}
		Board b = new Board();
		b.setNum(Integer.parseInt(multi.getParameter("num")));
		b.setWriter(multi.getParameter("writer"));
		b.setPass(multi.getParameter("pass"));
		b.setTitle(multi.getParameter("title"));
		b.setContent(multi.getParameter("content"));
		b.setFile1(multi.getFilesystemName("file1"));
		if(b.getFile1() == null || b.getFile1().equals("")) {
			b.setFile1(multi.getParameter("file2"));
		}
		
		Board dbB = dao.selectOne(b.getNum());
		String msg = "비번이 틀렸습니다.";
		String url = "updateForm?num=" + b.getNum();
		if(dbB.getPass().equals(b.getPass())) {
			if(dao.update(b)) {
				return "redirect:info?num=" + b.getNum();
			} else {
				msg = "수정 실패";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	/*
	 * 1. 파라미터 정보를 Board 객체에 저장
	 * 		 => request 객체 사용 불가
	 * 2. 비번 오류시 메세지 출력 => updateForm
	 * 3. 비번 맞음. boolean dao.update(Board b)
	 * 		- 첨부파일 없으면 file2 내용을 다시 저장
	 * 4. 수정 성공 => info
	 * 			실패 => updateForm
	 */
	

	@RequestMapping("delete")
	@MSLogin("noticecheck")
	public String delete(HttpServletRequest request,
			HttpServletResponse response) {
		int num = Integer.parseInt(request.getParameter("num"));
		String pass = request.getParameter("pass");
		Board dbB = dao.selectOne(num);
		String msg = "비번 틀림";
		String url = "deleteForm?num=" + num;;
		if(pass.equals(dbB.getPass())) { // 비번검증
			if(dbB.getGrplevel() == 0
					&& dao.hasReply(dbB)) { // 답글 여부
				msg = "답변이 있는 글은 삭제 불가";
				url = "list?boardid=" + dbB.getBoardid();
			} else if(dao.delete(num)) { // 답글X -> 삭제성공
				return "redirect:list?boardid=" +
						dbB.getBoardid();
			} else { // 삭제 실패
				msg = "삭제 실패";
			}
		} else { }
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	/*
	 * 1. num, pass 파라미터 변수에 저장
	 * 2. 비번 검증
	 * 		틀림 => 비번 틀림 => deleteForm?num=
	 * 3. 답변글이 있는 원글의 경우 삭제 불가. list?boardid=
	 * 		int dao.hasReply(num)
	 * 4. 게시물 삭제
	 * 		boolean dao.delete(num)
	 * 	 	삭제 => list?boardid=
	 * 		실패 => deleteForm?num=
	 */
}