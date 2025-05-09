package main;

import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class Main3_Dynamic {
	private final static SqlSessionFactory sqlMap;
	static {
		InputStream input = null;
		try {
			input = Resources.getResourceAsStream("mapper/mybatis-config.xml");
		} catch(IOException e) {
			e.printStackTrace();
		}
		sqlMap = new SqlSessionFactoryBuilder().build(input);
	}
	public static void main(String[] args) {
		SqlSession session = sqlMap.openSession();
		List<Student> list = session.selectList("student2.select1");
		System.out.println("	학생 전체 레코드 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("grade", 1);
		list = session.selectList("student2.select1", map);
		System.out.println("	1학년 학생 레코드 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("studno", 220111);
		Student st = session.selectOne("student2.select1", map);
		System.out.println("	학번 220111 조회 : ");
		System.out.println(st);
		
		map.clear();
		map.put("height", 180);
		list = session.selectList("student2.select1", map);
		System.out.println("	키 180 이상 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("height", 180);
		map.put("grade", 1);
		list = session.selectList("student2.select2", map);
		System.out.println("	키 180 이상인 1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		list = session.selectList("student2.select3");
		System.out.println("	전체 학생 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("grade", 1);
		list = session.selectList("student2.select3", map);
		System.out.println("	1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("grade", 1);
		map.put("height", 180);
		list = session.selectList("student2.select3", map);
		System.out.println("	키 180 이상인 1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("grade", 1);
		map.put("height", 180);
		map.put("studno", 240111);
		list = session.selectList("student2.select3", map);
		System.out.println("	학번 240111 키 180 이상인 1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		List<Integer> mlist = Arrays.asList(101, 201, 301);
		map.clear();
		map.put("column", "major1");
		map.put("datas", mlist);
		list = session.selectList("student2.select4", map);
		System.out.println("	101, 201, 301학과 학생 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		map.clear();
		map.put("column", "weight");
		map.put("datas", Arrays.asList(75, 80, 85));
		list = session.selectList("student2.select4", map);
		System.out.println("	몸무게 75 80 85 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		map.clear();
		map.put("column", "height");
		map.put("datas", Arrays.asList(170, 175, 180, 185));
		list = session.selectList("student2.select4", map);
		System.out.println("	키 170 ~185 사이 5단위 : " + list.size());
		for(Student s : list) System.out.println(s);

	}
}