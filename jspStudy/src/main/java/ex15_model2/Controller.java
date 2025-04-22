package ex15_model2;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// http://localhost:8080/jspStudy/hello.do
@WebServlet(urlPatterns = { "*.do" }, // *.do 요청시 Controller 서블릿 호출
		initParams = { @WebInitParam(name = "properties", value="url.properties") })
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private Properties pr = new Properties();
    private Action action = new Action();
    private Class[] paramType = new Class[] {
    			HttpServletRequest.class, HttpServletResponse.class };
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
    }
    @Override
    public void init(ServletConfig config) throws ServletException {
    	// config : properties = url.properties 값 저장
    	FileInputStream f = null;
    	String props = config.getInitParameter("properties");
    	// props : url.properties 저장
    	try {
    		// config.getServletContext().getRealPath("/") : 웹 애플리케이션 폴더
    		// f : url.properties 파일 읽기
    		f = new FileInputStream(
    				config.getServletContext().getRealPath("/") + "WEB-INF/" + props);
    		pr.load(f); // hello.do = hello
    		f.close();
    	} catch(IOException e) {
    		e.printStackTrace();
    	}
    }
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		Object[] paramObjs = new Object[] { request, response };
		ActionForward forward = null;
		String command = null;
		try {
//			request.getRequestURI() : /jspStudy/hello.do
//			request.getContextPath() : /jspStudy
//			command : /hello.do 저장
			command = request.getRequestURI().substring(
						request.getContextPath().length());
//			methodName = hello
			String methodName = pr.getProperty(command);
//			Class getClass() : Object의 멤버 메서드. 클래스 정보 리턴
//			getMethod(메서드이름, 파라미터 타입) 클래스 정보에서 method 정보
			Method method = action.getClass().getMethod(methodName, paramType);
			forward = (ActionForward)method.invoke(action, paramObjs);
//			invoke(호출대상객체, 매개변수값(인자)) : 메서드 호출
//			forward : new ActionForward(false, "ex15_model2/hello.jsp")
		} catch(NullPointerException e) {
			forward = new ActionForward();
		} catch(Exception e) {
			throw new ServletException(e);
		}
		if(forward != null) {
			if(forward.isRedirect()) {
				response.sendRedirect(forward.getView());
			} else {
//				forward.getView() : ex15_model2/hello.jsp
//				disp : 다음 호출할 페이지
				RequestDispatcher disp = request.getRequestDispatcher(forward.getView());
				disp.forward(request, response);
			}
		}
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
