package controller;

import java.util.List;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.book.Book;
import model.book.BookDao;

@WebServlet(urlPatterns = {"/book/*"},
	initParams = {@WebInitParam(name = "view", value="/view/")})
public class BookController extends MskimRequestMapping {
	BookDao dao = new BookDao();
	
	@RequestMapping("bookwrite")
	public String bookwrite(HttpServletRequest request,
			HttpServletResponse response) {
		Book book = new Book();
		book.setWriter(request.getParameter("writer"));
		book.setTitle(request.getParameter("title"));
		book.setContent(request.getParameter("content"));
		String msg = "방명록 작성 실패";
		String url = "bookList";
		if(dao.insert(book)) {
			msg = "방명록 작성 완료";
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	
	@RequestMapping("bookList")
	public String bookList(HttpServletRequest request,
			HttpServletResponse response) {
		List<Book> list = dao.list();
		request.setAttribute("list", list);
		return "book/bookList";
	}
	
	
}
