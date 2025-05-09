package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import gdu.mskim.MSLogin;
import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.member.Member;
import model.member.MemberDao;

// localhost:8080/model2Study/member
@WebServlet(urlPatterns= {"/member/*"},
initParams = {@WebInitParam(name="view", value="/view/")})
public class MemberController extends MskimRequestMapping {
	private MemberDao dao = new MemberDao();
	/*
	http://localhost:8080/model2Study/member/joinForm
	 => @RequestMapping("joinForm") 필요
		구현되어 있지 않은 경우
		/member/joinForm URL정보를 이용하여 /webapp/view/member/joinForm.jsp 페이지
		View 로 설정되게 구현
	*/
	
	/*
	 * 1. 파라미터 정보를 Member 객체에 저장. 인코딩 필요
	 * 2. Member 객체를 이용하여 db에 insert (member 테이블) 저장
	 * 3. 가입성공 : 메세지 => loginForm
	 * 		실패 : 메세지 => joinForm
	 */	
	@RequestMapping("join") // localhost:8080/model2Study/member/join
	public String join(HttpServletRequest request,
			HttpServletResponse response) {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setTel(request.getParameter("tel"));
		mem.setEmail(request.getParameter("email"));
		mem.setPicture(request.getParameter("picture"));
		if(dao.insert(mem)) {
			request.setAttribute("msg", mem.getName() + "님 ㅎㅇ");
			request.setAttribute("url", "loginForm");
		} else {
			request.setAttribute("msg", mem.getName() + "님 가입 오류");
			request.setAttribute("url", "joinForm");
		}
		return "alert";
	}
	@RequestMapping("login") // http://localhost:8080/model2Study/member/login
	public String login(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		Member mem = dao.selectOne(id);
		String msg = null;
		String url = null;
		if(mem == null) {
			msg = "아이디 확인하셈";
			url = "loginForm";
		} else if(!pass.equals(mem.getPass())) {
			msg = "비번 확인해";
			url = "loginForm";
		} else {
			msg = mem.getName() + "님 ㅎㅇ";
			url = "main";
			request.getSession().setAttribute("login", id);
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	@RequestMapping("main") // http://localhost:8080/model2Study/member/main
	public String main(HttpServletRequest request,
			HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		if(login == null || login.trim().equals("")) {
			request.setAttribute("msg", "로그인하셈");
			request.setAttribute("url", "loginForm");
			return "alert";
		}
		return "member/main"; // forward
	}
	@RequestMapping("logout")
	public String logout(HttpServletRequest request,
			HttpServletResponse response) {
		request.getSession().invalidate();
		return "redirect:loginForm"; // redirect 하도록 설정
		
//		request.setAttribute("msg", "로그아웃했다");
//		request.setAttribute("url", "loginForm");
//		return "alert";
	}
	/*
	   1. 로그인 상태 검증 => @MSLogin("loginIdCheck")
	   		loginIdCheck() 함수를 호출하여 검증 실행
	   		리턴값이 null인 경우 info() 호출
	      로그아웃상태 : 로그인하세요 메세지, loginForm.jsp 페이지로 이동
	      로그인 상태 :
	         - 다른 id를 조회할 수 없음. 단 관리자는 다른 id 조회가능함
	           내정보만 조회 가능합니다. 메세지 출력. main.jsp 페이지 이동
	   2. id 파라미터 조회
	   3. id에 해당하는 레코드를 조회하여 Member 객체에 저장(mem)
	 */
	@RequestMapping("info") // http://localhost:8080/model2Study/member/info
	@MSLogin("loginIdCheck")
	public String info(HttpServletRequest request,
			HttpServletResponse reponse) {
		String id = request.getParameter("id");
		Member mem = dao.selectOne(id);
		request.setAttribute("mem", mem);
		return "member/info";
	}
	/*
	  1. id 파라미터 조회
	  2. 로그인 상태 검증
	     - 로그아웃 : 로그인하세요 메세지 출력. loginForm.jsp 페이지 이동
	     - 로그인 상태
	        - 다른 아이디 정보 변경불가(관리자는 가능)
	          => 내정보만 수정 가능. main.jsp 페이지 이동 
	   3. db에서 id의 레코드를 조회. Member 객체로 리턴
	   4. 조회된 내용을 화면에 출력하기.        
	*/
	@RequestMapping("updateForm")
	@MSLogin("loginIdCheck")
	public String updateForm(HttpServletRequest request,
			HttpServletResponse reponse) {
		String id = request.getParameter("id");
		Member mem = dao.selectOne(id);
		request.setAttribute("mem", mem);
		return "member/updateForm";
	}
	/*
	   1. 모든 파라미터를 Member 객체에 저장하기
	   2. 입력된 비밀번호와 db에 저장된 비밀번호 비교.
	       관리자인 경우 관리자비밀번호로 비교
	       불일치 : '비밀번호 오류' 메세지 출력후 updateForm.jsp 페이지 이동 
	   3. Member 객체의 내용으로 db를 수정하기 : boolean MemberDao.update(Member)
	       - 성공 : 회원정보 수정 완료 메세지 출력후 info.jsp로 페이지 이동
	       - 실패 : 회원정보 수정 실패 메세지 출력 후 updateForm.jsp 페이지 이동
	 */
	@RequestMapping("update")
	@MSLogin("loginIdCheck")
	public String update(HttpServletRequest request,
			HttpServletResponse reponse) {
		Member mem = new Member();
		mem.setId(request.getParameter("id"));
		mem.setPass(request.getParameter("pass"));
		mem.setName(request.getParameter("name"));
		mem.setGender(Integer.parseInt(request.getParameter("gender")));
		mem.setTel(request.getParameter("tel"));
		mem.setEmail(request.getParameter("email"));
		mem.setPicture(request.getParameter("picture"));
		
		String login = (String)request.getSession().getAttribute("login");
		Member dbMem = dao.selectOne(login);
		String msg = "비번 틀림";
		String url = "updateForm?id=" + mem.getId();
		if( mem.getPass().equals(dbMem.getPass()) ) {
			if(dao.update(mem)) {
				msg = "정보 수정 완료";
				url = "info?id=" + mem.getId();
			} else {
				msg = "정보 수정 실패";
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";
	}
	@RequestMapping("deleteForm")
	@MSLogin("loginIdCheck")
	public String deleteForm(HttpServletRequest request,
			HttpServletResponse reponse) {
		String id = request.getParameter("id");
		if ( id.equals("admin")) {
			request.setAttribute("msg", "관리자는 탈퇴 안~~돼");
			request.setAttribute("url", "info?id=" + id);
			return "alert";
		}
		return "member/deleteForm";
	}
	@RequestMapping("delete")
	@MSLogin("loginIdCheck")
	public String delete(HttpServletRequest request,
			HttpServletResponse reponse) {
		String id = request.getParameter("id");
		String pass = request.getParameter("pass");
		String login = (String)request.getSession().getAttribute("login");
		
		if ( id.equals("admin")) {
			request.setAttribute("msg", "관리자는 탈퇴 안~~돼");
			request.setAttribute("url", "info?id=" + id);
			return "alert";
		}
		Member dbMem = dao.selectOne(login);
		String msg = "비번 오류";
		String url = "deleteForm?id=" + id;
		if(pass.equals(dbMem.getPass())) {
			if(login.equals("admin")) { url = "list"; }
			if(dao.delete(id)) {
				msg = id + " 탈퇴 성공";
				if(!login.equals("admin")) {
					request.getSession().invalidate();
					url = "loginForm";
				}
			} else {
				msg = id + " 탈퇴 실패";
				if(!login.equals("admin")) { url = "main"; }
			}
		}
		request.setAttribute("msg", msg);
		request.setAttribute("url", url);
		return "alert";			
	}

	@RequestMapping("list")
	@MSLogin("loginAdminCheck")
	public String list(HttpServletRequest request,
			HttpServletResponse reponse) {
		// 관리자로 로그인한 경우만 실행
		List<Member> list = dao.list();
		request.setAttribute("list", list);
		return "member/list";
	}
	
	@RequestMapping("findId")
	public String findId(HttpServletRequest request,
			HttpServletResponse reponse) {
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		System.out.println(email + "," + tel);
		String findId = dao.idSearch(email, tel);
		request.setAttribute("findId", findId);
		return findId;
	}
	/*
	 * 구글 smtp 서버를 이용해 메일 전송
	 * 1. 구글 접속해 2단계 인증 설정
	 * 2. 앱 비밀번호 생성
	 * 3. 생성된 앱 비밀번호 저장
	 * 4. mail-1.4.7.jar, activation-1.1.1.jar 파일 /WEB-INF/lib/ 에 복사
	 * 5. mail.properties 파일 /WEB-INF/ 생성
	 */
	@RequestMapping("mailForm")
	@MSLogin("loginAdminCheck")
	public String mailForm(HttpServletRequest request, HttpServletResponse response) {
		// ids : 메일 전송을 위한 아이디 목록
		String ids[] = request.getParameterValues("idchks");
		// list : 
		List<Member> list = dao.emailList(ids);
		request.setAttribute("list", list);
		return "member/mailForm";
	}
	@RequestMapping("mailSend")
	@MSLogin("loginAdminCheck")
	public String mailSend(HttpServletRequest request, HttpServletResponse response) {
		String sender = request.getParameter("googleid") + "@gmail.com";
		String passwd = request.getParameter("googlepw"); // 앱 비밀번호
		String recipient = request.getParameter("recipient");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String mtype = request.getParameter("mtype");
		String result = "메일 전송 중 오류 발생";
		Properties prop = new Properties(); // 이메일 전송을 위한 환경설정값
		try {
			String path = request.getServletContext().getRealPath("/")
					+ "WEB-INF/mail.properties";
			FileInputStream fis = new FileInputStream(path);
			prop.load(fis); // fis가 참조하고 있는 파일의 내용을 prop로 저장
			prop.put("mail.smtp.user", sender); // 전송 이메일 주소
		} catch(IOException e) {
			e.printStackTrace();
		}
		// 메일 전송을 위한 인증 객체
		MyAuthenticator auth = new MyAuthenticator(sender, passwd);
		// prop : 메일 전송을 위한 시스템 환경 설정
		// auth : 인증 객체
		// mailSession :  메일 전송을 위한 연결 객체
		Session mailSession = Session.getInstance(prop, auth);
		// msg : 메일 전송되는 데이터 객체
		MimeMessage msg = new MimeMessage(mailSession);
		List<InternetAddress> addrs = new ArrayList<InternetAddress>();
		try {
			String[] emails = recipient.split(",");
			for(String email : emails) {
				try {
					// new String(이메일 주소, 인코딩코드)
					// email.getBytes("UTF-8") : bytes[] 배열
					// 8859_1 : 웹의 기본인코딩방식
					addrs.add(new InternetAddress(
							new String(
									email.getBytes("UTF-8"), "8859_1")
							)
					);	
				} catch(UnsupportedEncodingException e) {
					e.printStackTrace();
				}
			}
			InternetAddress[] address = new InternetAddress[emails.length];
			for(int i = 0; i < addrs.size(); i++) {
				address[i] = addrs.get(i);
			}
			InternetAddress from = new InternetAddress(sender);
			msg.setFrom(from); // 보내는 이 메일주소
			// Message.RecipientType.TO : 수신
			// Message.RecipientType.CC : 참조
			// Message.RecipientType.BCC : 숨은 참조
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(title); // 제목
			msg.setSentDate(new Date()); // 전송일자
			msg.setText(content); // 내용
			// multipart : 내용, 첨부파일들... 
			MimeMultipart multipart = new MimeMultipart();
			MimeBodyPart body = new MimeBodyPart();
			body.setContent(content,mtype); // 내용
			multipart.addBodyPart(body);
			msg.setContent(multipart);
			Transport.send(msg); // 메일 전송
			result = "메일 전송 완료";
		} catch(MessagingException e) {
			e.printStackTrace();
		}
		// mailForm.jsp 에 구글 ID, 구글 비밀번호 value 값으로 입력
		request.setAttribute("msg", result);
		request.setAttribute("url", "list");
		return "alert";
	}
	
	@RequestMapping("passwordForm")
	@MSLogin("passwordLoginCheck")
	public String passwordForm(HttpServletRequest request, HttpServletResponse response) {
		return "member/passwordForm";
	}
	
	@RequestMapping("password")
	@MSLogin("passwordLoginCheck") // 1
	public String password(HttpServletRequest request,
			HttpServletResponse response) {
		// 2
		String pass = request.getParameter("pass");
		String chgpass = request.getParameter("chgpass");
		// 3
		String login = (String)request.getSession().getAttribute("login");
		Member dbMem = dao.selectOne(login);
		if(pass.equals(dbMem.getPass())) { // 비번 맞는 경우
			if(dao.updatePass(login, chgpass)) { // 비번 수정 완료
				request.setAttribute("msg", "비번 수정 완료");
				request.setAttribute("url", "info?id=" + login);
				return "openeralert";
			} else { // 비번 수정 실패
				StringBuilder sb = new StringBuilder();
				sb.append("alert('비번 수정시 오류 발생');\n");
				sb.append("self.close()");
				request.setAttribute("script", sb.toString());
				return "dummy";
			}
		} else { // 비번 틀림
			request.setAttribute("msg", "비번이 틀리다");
			request.setAttribute("url", "passwordForm");
			return "alert";
		}
	}
	/*
	1. 로그인한 사용자의 비밀번호 변경만 가능 => 로그인 검증
		로그아웃상태 : 로그인해라
		 => opener 창을 loginForm, 현재 창 닫기
	2. 파라미터 저장 pass, chgpass
	3. 비번 검증 : 현재 비번과 비교
			현재 비번과 다름 : 비번 오류 메세지
			 => 현재 페이지 passwordForm.jsp
	4. db에 비번 수정 boolean MemberDao.updatePass(id, chgpass)
		- 수정 성공 : (로그아웃, 재로그인해)
				=> opener 페이지는 info.jsp로 이동. 현재 닫기
		- 수정 실패 : 메세지 => 현재 닫기 
	*/
	@RequestMapping("id")
	public String id(HttpServletRequest request,
			HttpServletResponse response) {
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String id = dao.idSearch(email, tel);
		if(id == null) {
			request.setAttribute("msg", "해당하는 ID가 없다");
			request.setAttribute("url", "idForm");
			return "alert";
		} else {
			String printId = id.substring(0, id.length()-2);
			request.setAttribute("id", printId);
			return "member/id";
		}
	}
	/* 아디 찾기
	1. 파라미터 값 email, tel 저장
	2. db에서 두개의 파라미터를 이용해 id 값 리턴 함수 필요
		String MemberDao.idSearch(email, tel)
	3. id 존재 : 뒤 2자 **로 출력
							아이디 전송 버튼 누르면 opener 창에 id 입력칸에 전달
							id 닫기
		미존재 : id없다 => idForm 이동
	*/
	
	@RequestMapping("pw")
	public String pw(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		String email = request.getParameter("email");
		String tel = request.getParameter("tel");
		String pass = dao.pwSearch(id, email, tel);
		if(pass == null) {
			request.setAttribute("msg", "정보에 맞는 비번 없다");
			request.setAttribute("url", "pwForm");
			return "alert";
		} else {
			request.setAttribute("pass", pass);
			return "member/pw";
		}
	}
	/* 비번찾기
	  1. 파라미터 저장.
	  2. db에서 id,email과 tel 을 이용하여 pass값을 리턴
	       pass = MemberDao.pwSearch(id,email,tel)
	  3. 비밀번호 검증 
	     비밀번호 찾은 경우 :화면에 앞 두자리는 **로 표시하여 화면에 출력. 닫기버튼 클릭시 
	                     현재 화면 닫기
	     비밀번호 못찾은 경우: 정보에 맞는 비밀번호를 찾을 수 없습니다.  메세지 출력후
         현재 페이지를 pwForm.jsp로 페이지 이동. 
	*/
	@RequestMapping("idchk")
	public String idchk(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		Member mem = dao.selectOne(id);
		String msg = null;
		boolean able = true;
		if(mem == null) {
			msg = "사용 가능한 id입니다.";
		} else {
			msg = "사용 중인 id입니다.";
			able = false;
		}
		request.setAttribute("msg", msg);
		request.setAttribute("able", able);
		return "member/idchk";
	}
	/*
	1. id 파라미터
	2. id를 db에서 조회
	3. db에 미 존재 : 사용 가능  출력 green
		db에 존재 : 사용 불가 출력 red	
	*/
	@RequestMapping("picture")
	public String picture(HttpServletRequest request,
			HttpServletResponse response) {
		String path = request.getServletContext().getRealPath("") + "picture/";
		String fname = null;
		File f = new File(path);
		if(!f.exists()) f.mkdirs();
		MultipartRequest multi = null;
		try {
			multi = new MultipartRequest(request, path, 10*1024*1024, "utf-8");
		} catch (IOException e) {
			e.printStackTrace();
		}
		fname = multi.getFilesystemName("picture");
		request.setAttribute("fname", fname);
		return "member/picture";
	}
/*
	1. request 객체로 이미지 업로드 불가 => cos.jar
	2. 이미지 업로드 폴더 : 현재폴더/picture 설정
	3. opener 화면에 이미지 볼 수 있도록 결과 전달  >> JS
	4. 현재 화면 close								>> JS
*/
//	=========================
	public String passwordLoginCheck(HttpServletRequest request,
			HttpServletResponse response) {
		String login = (String)request.getSession().getAttribute("login");
		if(login == null || login.trim().equals("")) {
			request.setAttribute("msg", "로긴해라(passwordLoginCheck)");
			request.setAttribute("url", "loginForm");
			return "openeralert";
		}
		return null;
	}
	// 내부 클래스
	// final 클래스 : 다른 클래스의 부모 클래스가 될 수 없다.
	public final class MyAuthenticator extends Authenticator {
		private String id;
		private String pw;
		public MyAuthenticator(String id, String pw) {
			this.id = id;
			this.pw = pw;
		}
		protected PasswordAuthentication getPasswordAuthentication() {
			return new PasswordAuthentication(id, pw);
		}
	}
	
	public String loginAdminCheck(HttpServletRequest request,
			HttpServletResponse reponse) {
		String login=(String)request.getSession().getAttribute("login");
		if(login == null) {
			request.setAttribute("msg", "로긴하셈");
			request.setAttribute("url", "loginForm");
			return "alert";
		} else if(!login.equals("admin")) {
			request.setAttribute("msg", "관리자만 가능");
			request.setAttribute("url", "main");
			return "alert";
		}
		return null;
	}
	public String loginIdCheck(HttpServletRequest request,
			HttpServletResponse reponse) {
		String id = request.getParameter("id");
		String login = (String)request.getSession().getAttribute("login");
		if(login == null) {
			request.setAttribute("msg", "로그인ㄱ");
			request.setAttribute("url", "loginForm");
			return "alert";
		} else if ( !login.equals("admin") && !id.equals(login)) {
			request.setAttribute("msg", "본인만 거래 가능");
			request.setAttribute("url", "main");
			return "alert";
		}
		return null; // 정상적인 접근
	}
}