package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Select;

import main.Student;

public interface StudentMapper2 {
	
	@Select({"<script>", 
		"select * from student ",
		"<where>",
		"<if test='grade != null'>grade = #{grade}</if>",
		"<if test='height != null'>height &gt;= #{height}</if>",
		"<if test='weight != null'>weight &lt;= #{weight}</if>",
		"</where>",
		"</script>"})
	List<Student> select(Map<String, Object> map);

	@Select({
		"<script>",
		"select * from student",
		"<trim prefix='where' prefixOverrides='and || or'>",
		"<if test='grade != null'>and grade = #{grade}</if>",
		"<if test='height != null'>and height &gt;= #{height}</if>",
		"</trim>",
		"</script>"
	})
	List<Student> select2(Map<String, Object> map);
	
}