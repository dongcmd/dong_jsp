package main;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mapper.StudentMapper;

public class Main4_Interface {
	private final static SqlSessionFactory sqlMap;
	// cls : Mapper의 클래스 정보
	private final static Class<StudentMapper> cls = StudentMapper.class;
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
		List<Student> list = session.getMapper(cls).select();
		System.out.println("	모든 학생 정보 조회 : " + list.size());
		for(Student s : list) System.out.println(s);

		list = session.getMapper(cls).selectGrade(1);
		System.out.println("	1학년 정보 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		list = session.getMapper(cls).selectStudno(240111);
		System.out.println("	240111학생 조회 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		list = session.selectList("mapper.StudentMapper.select");
		System.out.println("	인터페이스 형태를 xml 형식으로 호출 : " + list.size());
		for(Student s : list) System.out.println(s);
		
		Student st = session.getMapper(cls).selectName("진영훈").get(0);
		System.out.println("	진영훈 조회 : ");
		System.out.println(st);
		
		Map<String, Object> map = new HashMap<>();
		map.put("grade", 1);
		map.put("height", 180);
		list = session.getMapper(cls).selectGradeHeight(map);
		System.out.println("	1학년 중 키 180 이상 " + list.size());
		for(Student s : list) System.out.println(s);
		
		list = session.getMapper(cls).selectGradeHeight2(1, 180);
		System.out.println("	1학년 중 키 180 이상 " + list.size());
		for(Student s : list) System.out.println(s);
		
		
	}
}