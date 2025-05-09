package model.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import model.board.Board;

public interface BoardMapper {

	@Select("select ifnull(max(num),0) from board")
	int maxnum();

	String insertSql = "insert into board "
			+ "(num, writer, pass, title, content, file1, regdate, "
			+ " readcnt, grp, grplevel, grpstep, boardid) "
			+ " values (#{num}, #{writer}, #{pass}, #{title}, #{content}, #{file1}, now(), "
			+ " 0,  #{grp}, #{grplevel}, #{grpstep}, #{boardid})";
	@Insert(insertSql)
	int insert(Board board);
	
	String sqlCol = "<if test='column != null'>"
		+ "<if test='col1 != null'> and (${col1} like '%${find}%'</if>"
		+ "<if test='col2 == null'> ) </if>"
		+ "<if test='col2 != null'> or ${col2} like '%${find}%'</if>"
		+ "<if test='col2 != null and col3 == null'> ) </if>"
		+ "<if test='col3 != null'> or ${col3} like '%${find}%')</if>"
		+ "</if>";
	@Select({"<script>",
		"select count(*) from board where boardid = #{boardid} ",
		sqlCol, "</script>"})
	int count(Map<String, Object> map);
	
	@Select({"<script>",
		"select * from board where boardid = #{boardid} ",
		sqlCol,
		" order by grp desc, grpstep asc limit #{start}, #{limit}",
		"</script>"})
	List<Board> list(Map<String, Object> map);
/*
	limit #{start}, #{litmit}
	 num(grp) 컬럼의 역순
*/

	@Select("select * from board where num=#{v}")
	Board selectOne(int num);

	@Update("update board set readcnt=readcnt+1 where num=#{v}")
	void readcntAdd(int num);

	@Update("update board set grpstep=grpstep+1 where"
			+ " grp=#{grp} and grpstep > #{grpstep}")
	void grpstepAdd(@Param("grp")int grp, @Param("grpstep")int grpstep);

	String updateSql = "update board set writer=#{writer} ,"
		+ "title=#{title}, content=#{content}, file1=#{file1} "
		+ "where num=#{num}";
	@Update(updateSql)
	void update(Board b);

	@Select("select count(*) from board where grp=#{grp} and grplevel > 0")
	int hasReply(Board b);

	@Delete("delete from board where num = #{num}")
	int delete(int num);

	@Select("select writer, count(*) cnt from board "
			+ " group by writer order by cnt desc limit 0,5")
	List<Map<String, Object>> graph1();
	
	@Select("select date_format(regdate, '%Y-%m-%d') fmtdate, count(*) cnt from board "
			+ "where regdate >=  now() - interval 7 day "
			+ "group by date_format(regdate, '%Y-%m-%d') "
			+ "order by 1 desc")
	List<Map<String, Object>> graph2();

}