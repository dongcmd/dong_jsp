package controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class UploadServlet
 */
@WebServlet("/uploadImage")
@MultipartConfig // 업로드된 파일을 처리
public class UploadImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UploadImageServlet() {
        super();
    }

    private static final String UPLOAD_DIR = "uploaded_images";
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Part filePart = request.getPart("file");
			System.out.println("filePart : " + filePart);
		
		String fileName = getFileName(filePart);
			System.out.println("fileName : " + fileName);
		
		// File.separator : windows : \, 리눅스, 맥 : /
		String uploadPath = getServletContext().getRealPath("")
				+ File.separator + UPLOAD_DIR;
			System.out.println("uploadPath : " + uploadPath);
		
		File uploadDir = new File(uploadPath);
			System.out.println("uploadDir : " + uploadDir);
		
		if(!uploadDir.exists()) uploadDir.mkdirs();
		
		// 이미지 파일이 업로드된 절대 경로
		String filePath = uploadPath + File.separator + fileName;
		// D:\dong_study\jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps
		// \model2Study\\uploaded_images\flower3.jpg
		filePart.write(filePath); // 파일 업로드. @MultipartConfig 필수
			System.out.println("filePath : " + filePath);
		
		// 톰캣이 접근할 수 있는 url 정보.
		String fileUrl = request.getContextPath() + "/" + UPLOAD_DIR
				+ "/" + fileName; // /model2Study/uploaded_images/flower3.jpg
			System.out.println("fileUrl : " + fileUrl);
		
		response.setContentType("text/plain");
		response.getWriter().write(fileUrl);
	}
	private String getFileName(Part part) {
		System.out.println("content-dispoition : " + part.getHeader("content-disposition"));
		// form-data; name="file"; filename="flower3.jpg"
		for(String content : part.getHeader("content-disposition").split(";")) {
			if(content.trim().startsWith("filename")) {
				return content.substring(content.indexOf("=") + 1)
						.trim().replace("\"", "");
			}
		}
		return "unknown.jpg";
	}

}
