package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import main.Student;

/*
 * 인터페이스 방식으로 Mapper 사용하기
 * 1. mybatis-config.xml 의 Mapper에 package로 설정
 * 2. namespace : mapper.StudentMapper 인터페이스의 전체 이름
 * 3. 메서드 이름이 sql 문장의 key값 => Mapper 인터페이스는 오버로딩 X
 */
public interface StudentMapper {
	
	@Select("select * from student")
	List<Student> select();
	
	@Select("select * from student where grade=#{v}")
	List<Student> selectGrade(int i);
	
	@Select("select * from student where studno=#{v}")
	List<Student> selectStudno(int i);
	
	@Select("select * from student where name = #{name}")
	List<Student> selectName(String name);
	
	@Select("select * from student where grade=#{grade} and height>=#{height}")
	List<Student> selectGradeHeight(Map<String, Object> map);
	
	@Select("select * from student where grade=#{grade} and height>=#{height}")
	List<Student> selectGradeHeight2
		(@Param("grade")int a, @Param("height")int b);
	// @Param("grade")int a : 변수 a를 grade(key값)으로 설정
	
	@Insert("insert into student (studno, name, jumin, id) "
			+ " values (#{studno}, #{name}, #{jumin}, #{id})")
	int insert(Student st);
	
	@Update("update student set grade=#{grade}, height=#{height}, "
			+ " weight=#{weight} where name=#{name}")
	int update(Student st);

	@Delete("delete from student where name=#{v}")
	int deleteName(String name);
	
	
}