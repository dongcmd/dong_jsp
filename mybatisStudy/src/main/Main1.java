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

public class Main1 {
	public static void main(String[] args) {
		SqlSessionFactory sqlMap = null;
		Reader reader = null;
		try { // reader : 입력 스트림
			reader = Resources.getResourceAsReader("mapper/mybatis-config.xml");
			// reader를 읽어 mybatis 환경 설정.
			// sqlMap : sql 구문 저장. id 속성값으로 sql 구문을 저장.
			sqlMap = new SqlSessionFactoryBuilder().build(reader);
		} catch(IOException e) {
			e.printStackTrace();
		}
		int x = 0;
		// session : Connection 객체를 mybatis에서 연결한 객체
		SqlSession session = sqlMap.openSession();

		// selectOne(sql구문의 id값) : 결과레코드가 한 건만.
		x = (Integer)session.selectOne("member.count");
		System.out.println("member 테이블의 레코드 개수 : " + x);
		System.out.println("member 테이블의 전체 레코드 조회 =======");

		// selectList(sql구문의 id값) : 결과 레코드가 여러 건만.
		List<Member> list = session.selectList("member.list");
		for(Member m : list) System.out.println(m);
		
		System.out.println("member 테이블의 admin 레코드 조회 =======");
		Member admin = session.selectOne("member.selectid", "admin");
		System.out.println(admin);

		System.out.println("member 테이블에서 이름 동을 가진 레코드 조회 =======");
		list = session.selectList("member.selectname1", "%동%");
		for(Member m : list) System.out.println(m);
//		System.out.println("member 테이블에서 이름 1을 가진 레코드 조회 =======");
//		list = session.selectList("member.selectname2", "동");
//		for(Member m : list) System.out.println(m);

		System.out.println("member 테이블에서 이름에 동을 가진 남자 조회 =======");
		Map<String, Object> map = new HashMap<>();
		map.put("name", "동");
		map.put("gender", "1");
		list = session.selectList("member.selectNameGender", map);
		for(Member m : list) System.out.println(m);
		
	}
}
