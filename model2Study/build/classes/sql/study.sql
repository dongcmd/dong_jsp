-- /java/sql/study.sql
create table board (
  num int auto_increment primary key, -- 글번호. 기본키
  writer varchar(30), -- 작성자
  pass varchar(20), -- 글 비번
  title varchar(100), -- 제목
  content varchar(2000), -- 내용
  file1 varchar(200), -- 첨부파일
  boardid varchar(2), -- 게시판 종류(1 공지사항, 2 자유)
  regdate datetime, -- 글 등록일시
  readcnt int(10), -- 조회수
  grp int,					-- 답글 작성시 원글의 게시글 번호 (스레드방식)
  grplevel int(3), -- 답글의 레벨( 0 원글, 1 원글의 1차 답글, 2 답글의 답글, ...)
  grpstep int(5)		-- 그룹의 출력 순서
)

update board set readcnt = 1 where readcnt = 0

select date_format(regdate, '%Y-%m-%d') fmtdate, count(*) cnt from board
where regdate >=  now() - interval 7 day
group by date_format(regdate, '%Y-%m-%d')
order by cnt desc

select * from board where boardid = 1
	order by grp desc, grpstep asc

update board set pass=1

select * from member

delete from board where grplevel != 0

update member set gender=1 where id='dong'

update member set picture="banana.gif" where id != "admin"
