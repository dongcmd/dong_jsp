package model.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import model.DBConnection;
import model.MybatisConnection;
import model.mapper.MemberMapper;

public class MemberDao {
	private Class<MemberMapper> cls = MemberMapper.class;
	private Map<String, Object> map = new HashMap<>();
	
	 public boolean insert(Member mem) {
		 SqlSession session = MybatisConnection.getConnection();

		 try {
			 if(session.getMapper(cls).insert(mem) > 0) return true;
			 else return false;
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return false;
	 }
	 
	 public Member selectOne(String id) {
		 SqlSession session = MybatisConnection.getConnection();
		 try {
			 return session.getMapper(cls).selectOne(id);
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return null;		 
	 }
	 
	 public List<Member> list() {
		 SqlSession session = MybatisConnection.getConnection();
		 try {
			 return session.getMapper(cls).selectList();
		 } catch (Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return null;
	 }
	 
	 public boolean update(Member mem) {
		 SqlSession session = MybatisConnection.getConnection();
		 try {
			 return session.getMapper(cls).update(mem) > 0;		 
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return false;
	 }
	 
	 public boolean delete(String id) {
		 SqlSession session = MybatisConnection.getConnection();
		 try {
			 return session.getMapper(cls).delete(id) > 0;
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return false;
	 }
	 
	 public String idSearch(String email, String tel) {
		 SqlSession session = MybatisConnection.getConnection();
		 map.clear();
		 map.put("email", email);
		 map.put("tel", tel);
		 try {
			 return session.getMapper(cls).idSearch(map);
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return null;
	 }
	 
	 public String pwSearch(String id, String email, String tel) {
		 SqlSession session = MybatisConnection.getConnection();
		 map.clear();
		 map.put("id", id);
		 map.put("email", email);
		 map.put("tel", tel);
		 try {
			 return session.getMapper(cls).pwSearch(map);
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return null;		 
	 }
	 
	 public boolean updatePass(String id, String chgpass) {
		 SqlSession session = MybatisConnection.getConnection();
		 map.clear();
		 map.put("id", id);
		 map.put("chgpass", chgpass);
		 try {
			 return session.getMapper(cls).updatePass(map) > 0;
		 } catch(Exception e) {
			 e.printStackTrace();
		 } finally {
			 MybatisConnection.close(session);
		 }
		 return false;
	 }
	 
	 public List<Member> emailList(String[] ids) {
		SqlSession session = MybatisConnection.getConnection();
		map.clear();
		map.put("ids", ids);
		List<Member> list = session.getMapper(cls).emailList(map);
		try {
			if (list.size() > 0) return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			MybatisConnection.close(session);
		}
		return null;
	 }
}
