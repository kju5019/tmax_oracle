/* update 테이블 */
create table dept_temp2
as
select * from dept;

select * from dept_temp2;

/*UPDATE 테이블명 SET 칼럼=새로운값 */
update dept_temp2
	set loc = 'NEW YORK'
	
select dept_temp2.deptno, dept.loc 
from dept, dept_temp2
where dept.deptno(+) = dept_temp2.deptno
;

update dept_temp2
set loc = 'NEW YORK'
where deptno = 10;

update dept_temp2
set loc = 'DALLAS'
where deptno = 20;

update dept_temp2
set loc = 'CHICAGO'
where deptno = 30;

update dept_temp2
set loc = 'BOSTON'
where deptno = 40;

update dept_temp2
set loc = NULL
where deptno in (70,80);

insert into dept_temp2 values (70,'WEB',NULL);	
insert into dept_temp2 values (80,'MOBILE',NULL);	

select * from dept_temp2;


/* 칼럼 1개 수정 */
update dept_temp2
	set loc = 'SEOUL'
where deptno = 70
;

/* 칼럼 여러개 수정 
 * update 테이블명
 * set 칼럼 1= 값, 칼럼2=값2,...
 * where 조건 */
update DEPT_TEMP2
	set dname = 'INTERNET',
		loc = 'PANGYO'
where deptno = 80
;

update DEPT_TEMP2
	set dname = 'research',
		loc = 'suwon'
where deptno = 40
;



/* 서브쿼리로 데이터 수정 */
/* 한번에 수정 */
update dept_temp2
	set (dname,loc)=(select dname,loc from dept where deptno=40)
where deptno = 40;

/* 개별 쿼리 하나씩 수정 */
update dept_temp2
	set dname = (select dname from dept where deptno=40)
	set loc = (select loc from dept where deptno=40)
where deptno = 40;


/*update 값 직접 입력, select로 수정 */
update dept_temp2
set loc = 'SEOUL',
	dname = (select dname from dept where deptno = 40)
	where deptno = 40;
	
/*where 조건에 sub 쿼리 사용 */
update dept_temp2
	set loc = 'PANGYO'
	where deptno = (select deptno from dept_temp2 where dname = 'RESEARCH');
	
select * from dept_temp2;
	


