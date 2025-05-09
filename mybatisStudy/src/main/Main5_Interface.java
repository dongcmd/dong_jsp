package main;

import java.io.IOException;
import java.io.Reader;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import mapper.StudentMapper;

public class Main5_Interface {
	private final static SqlSessionFactory sqlMap;
	// cls : Mapper의 클래스 정보
	private final static Class<StudentMapper> cls = StudentMapper.class;
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
		
		System.out.println("이몽룡 학생 추가");
		Student st = new Student();
		st.setStudno(1002);
		st.setName("이몽룡");
		st.setJumin("9710011234567");
		st.setId("leemy97");
		int cnt = session.getMapper(cls).insert(st);
		System.out.println(cnt + "건 추가");
		Student dbst = session.getMapper(cls).selectName("이몽룡").get(0);
		System.out.println(dbst);
		
		st.setGrade(1);
		st.setHeight(175);
		st.setWeight(80);
		cnt = session.getMapper(cls).update(st);
		dbst = session.getMapper(cls).selectName("이몽룡").get(0);
		System.out.println("이몽룡 1학년 175/80 수정 : " + cnt);
		System.out.println(dbst);
		
		cnt = session.getMapper(cls).deleteName("이몽룡");
		System.out.println("이몽룡 삭제 : " + cnt);
		System.out.println(session.getMapper(cls).selectName("이몽룡"));
	}

}
