package test0415;

import java.io.IOException;
import java.io.Reader;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import main.Professor;

/*
 * ProfessorMapper.xml 파일을 이용하기
 * Professor.java 파일 이용하기
1. 교수테이블에 등록된 레코드의 건수를 출력하기.
2. 교수테이블에 등록된 모든 정보를 출력하기
3. 교수중 101번 학과의 교수 정보를 출력하기
4. 교수중 성이 김씨인 시간강사 정보를 출력하기 
*/
public class Test2 {
	public static void main(String[] args) {
		SqlSessionFactory sqlMap = null;
		Reader reader = null;
		try {
			reader = Resources.getResourceAsReader("mapper/mybatis-config.xml");
			sqlMap = new SqlSessionFactoryBuilder().build(reader);
		} catch (IOException e) {
			e.printStackTrace();
		}
		SqlSession session = sqlMap.openSession();
		String str = null;
		List<Professor> list = null;
		str = "";
		System.out.println("1. 레코드 건수 : " + str);
		list = session.selectList("prof.inputdata", str);
		System.out.println(list.size());
		str = "";
		System.out.println("2. 모든 정보 : " + str);
		list = session.selectList("prof.inputdata", str);
		for(Professor p : list) System.out.println(p);
		str = "where deptno=101";
		System.out.println("3. 101학과의 교수 정보 : " + str);
		list = session.selectList("prof.inputdata", str);
		for(Professor p : list) System.out.println(p);
		str = "where name like '김%' and position='시간강사'";
		System.out.println("4. 김씨인 시간강사 : " + str);
		list = session.selectList("prof.inputdata", str);
		for(Professor p : list) System.out.println(p);
	}
}
