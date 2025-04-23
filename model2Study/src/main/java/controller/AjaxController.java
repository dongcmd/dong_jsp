package controller;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gdu.mskim.MskimRequestMapping;
import gdu.mskim.RequestMapping;
import model.board.BoardDao;

@WebServlet(urlPatterns = {"/ajax/*"},
	initParams= {@WebInitParam(name="view", value="/view/")})
public class AjaxController extends MskimRequestMapping {
	BoardDao dao = new BoardDao();
	@RequestMapping("select")
	public String select(HttpServletRequest request,
			HttpServletResponse response) {
		BufferedReader fr = null;
		String path = request.getServletContext().getRealPath("/")
				+ "file/sido.txt";
		try {
			fr = new BufferedReader(new FileReader(path));
		} catch(IOException e) { e.printStackTrace(); }
		
		Set<String> set = new LinkedHashSet<String>();
		String data = null;
		String sigu = request.getParameter("sigu");
		String selected = request.getParameter("selected");
		
		if(sigu == null) {
			try {
				while( (data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr.length >= 3) { set.add(arr[0].trim()); }
				}
			} catch(IOException e) { e.printStackTrace(); }
		} else if(sigu.equals("si")) {
			try {
				while( (data = fr.readLine()) != null) {
					String[] arr = data.split("\\s+");
					if(arr.length >= 3 && selected.equals(arr[0].trim()) && !arr[1].contains(arr[0])) {
						set.add(arr[1].trim());
					}
				}
			} catch(IOException e) { e.printStackTrace(); }
		} else if(sigu.equals("gu")) {
		try {
			while( (data = fr.readLine()) != null) {
				String[] arr = data.split("\\s+");
				if(arr.length >= 3 && selected.equals(arr[1].trim()) && !arr[2].contains(arr[1])) {
					if(arr.length > 3) {
						if(arr[3].contains(arr[1])) continue;
						arr[2] += " " + arr[3];
					}
					set.add(arr[2].trim());
				}
			}
		} catch(IOException e) { e.printStackTrace(); }
	}
		request.setAttribute("list", new ArrayList<String>(set));
		request.setAttribute("len", set.size());
		return "ajax/select";
	}
	
	// http://localhost:8080/model2Study/ajax/graph1
	@RequestMapping("graph1")
	public String graph1(HttpServletRequest request,
			HttpServletResponse response) {
		List<Map<String, Object>> list = dao.boardGraph1();
		StringBuilder json = new StringBuilder("[");
		int i = 0;
		for(Map<String, Object> m : list) {
			for(Map.Entry<String, Object> me : m.entrySet()) {
				if(me.getKey().equals("cnt"))
					json.append("{\"cnt\" : " + me.getValue() + ", ");
				if(me.getKey().equals("writer"))
					json.append("\"writer\" : \"" + me.getValue() + "\"}");
			}
			i++;
			if(i < list.size()) json.append(",");
		}
		json.append("]");
		request.setAttribute("json", json.toString().trim());
		return "ajax/graph";
	}
	
	@RequestMapping("graph2")
	public String graph2(HttpServletRequest request,
			HttpServletResponse response) {
		List<Map<String, Object>> list = dao.boardGraph2();
		StringBuilder json = new StringBuilder("[");
		int i = 0;
		for(Map<String, Object> m : list) {
			for(Map.Entry<String, Object> me : m.entrySet()) {
				if(me.getKey().equals("fmtdate"))
					json.append("{\"fmtdate\" : \"" + me.getValue() + "\", ");
				if(me.getKey().equals("cnt"))
					json.append("\"cnt\" : \"" + me.getValue() + "\"}");
			}
			i++;
			if(i < list.size()) json.append(",");
		}
		json.append("]");
		request.setAttribute("json", json.toString().trim());
		return "ajax/graph";
	}
}