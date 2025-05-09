package test0415;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import main.Student;

/*
 * StudentMapper1.xml 파일을 이용하기
 * 1. 학생테이블의 등록된 레코드의 건수를 출력하기
 * 2. 학생테이블의 등록된 레코드의 정보를 출력하기
 * 3. 학생테이블의 등록된 레코드의 1학년 학생의 정보를 출력하기
 * 4. 학생테이블의 등록된 레코드의 성이 김씨인 학생의 정보를 출력하기
 * 5. 학생테이블의 등록된 레코드의 3학년 학생 중 주민번호 기준 여학생 정보를 출력하기
 */

public class Test1 {
	private static final SqlSessionFactory sqlMap;
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
		int cnt = session.selectOne("student.count");
		System.out.println("1 등록된 레코드 건수 : " + cnt);
		System.out.println("2 모든 학생 레코드 ==========");
		List<Student> list = session.selectList("student.list");
		for(Student s : list) System.out.println(s);
		System.out.println("3 1학년 학생 레코드 ==========");
		list = session.selectList("student.grade 1 list");
		for(Student s : list) System.out.println(s);
		System.out.println("4 김씨 목록 ==========");
		list = session.selectList("student.kims");
		for(Student s : list) System.out.println(s);
		System.out.println("5 3학년 여자 ==========");
		list = session.selectList("student.grade 3 f");
		for(Student s : list) System.out.println(s);
		
		String str = "where grade=3 and substring(jumin, 7, 1)='4'";
		System.out.println("내가 입력한 문자열로 출력 : " + str);
		list = session.selectList("student.inputdata", str);
		for(Student s : list) System.out.println(s);
	}
}