package main;

import java.io.IOException;
import java.io.Reader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mapper.StudentMapper2;

public class Main6_Interface {
	private final static SqlSessionFactory sqlMap;
	private final static Class<StudentMapper2> cls = StudentMapper2.class;
	private static Map<String, Object> map = new HashMap<>();
	static {
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader("mapper/mybatis-config.xml");
		} catch(IOException e) {
			e.printStackTrace();
		}
		sqlMap = new SqlSessionFactoryBuilder().build(reader);
	}
	public static void main(String[] args) {
		SqlSession session = sqlMap.openSession();
		List<Student> list = session.getMapper(cls).select(map);
		System.out.println("	모든 학생 정보 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.put("grade", 1);
		list = session.getMapper(cls).select(map);
		System.out.println("	1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		map.clear();
		map.put("height", 175);
		list = session.getMapper(cls).select(map);
		System.out.println("	키 175 이상 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("weight", 60);
		list = session.getMapper(cls).select(map);
		System.out.println("	몸무게 60 이하 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		// ================= select2
		list = session.getMapper(cls).select2(map);
		System.out.println("	===select2====모든 학생 정보 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.put("grade", 1);
		list = session.getMapper(cls).select2(map);
		System.out.println("	1학년 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		map.clear();
		map.put("height", 175);
		list = session.getMapper(cls).select2(map);
		System.out.println("	키 175 이상 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		map.clear();
		map.put("grade", 1);
		map.put("height", 175);		
		list = session.getMapper(cls).select2(map);
		System.out.println("	1학년 중 키 175 이상 : " + list.size());
		for(Student s : list) System.out.println(s);
	}
}