/* DML - insert */
/* 기존테이블로 새로운 테이블생성
 * create table 새로운테이블명 as select문
 * where 거짓 조건 - 빈테이블만 생성 */
create table dept_temp111
	as 
	select * from dept where 1=0; /*조건-거짓*/
select * from dept_temp111;

	
create table dept_temp2
	as 
	select * from dept; /*조건-거짓*/
select * from dept_temp2;


create table dept_10
	as
	select * from dept where deptno = 10;
select*from dept_10;


select * from dept_temp111 order by deptno;

/* insert into 테이블명(칼럼1,칼럼2,칼럼3) values(값1,값2,값3); */
insert into dept_temp111(deptno,dname,loc) 
	values(10,upper('accounting'),upper('new york'));
	
/* insert into 테이블명 values(값1,값2,값3); */
insert into dept_temp111
	values(20,'RESEARCH','DALLAS');
	
/* insert into 테이블명(칼럼3,칼럼1,칼럼2) values(값3,값1,값2); */
insert into dept_temp111(loc, deptno, dname)
	values('CHICAGO',30,'SALES');

alter table dept_temp111 modify loc varchar2(20) default 'BOSTON' not null; /* null값을 넣더라도 'BOSTON'값이 들어가도록 하라*****************************************/

	
/* insert into 테이블명(칼럼1,칼럼2) values(값1,값2); */
insert into dept_temp111(deptno,dname) 
	values(40,'OPERATIONS');
insert into dept_temp111(deptno,dname) 
	values(50,'OPERATIONS');


/* 명시적 NULL값 저장 */
insert into dept_temp111(deptno,dname) values(70,NULL);

create table dept_temp222
as
select * from dept;


select * from dept_temp222;


insert into dept_temp222 values (70,'WEB',NULL);						/* 명시적 null값 입력 ****************************/
insert into dept_temp222(deptno, dname) values (80,'MOBILE');			/* 암시적 null값 입력 ****************************/




/* 날짜 데이터 입력 */
create table emp_temp
as select * from emp
where 1=0;

select * from emp_temp;


/* 직접 문자열로 입력 */
insert into emp_temp(empno, ename, job, mgr, hiredate, sal, comm,deptno )
values(1111,'성춘향','MANAGER',9999, '2001-01-05',4000,NULL,20);

insert into emp_temp
values(9999,'홍길동','PRESIDENT',NULL, '2001/01/01',5000,1000,10);

/* 포맷을 맞춰서 입력 */
insert into emp_temp
values(2111,'이순신','MANAGER',9999, to_date('07/01/2001','dd/mm/yyyy'),4000,NULL,20);

/*sysdate 를 이용한 입력 */
select sysdate from dual;
insert into emp_temp
values(3111,'심청이','MANAGER',9999, sysdate,4000,NULL,30);

/* 1. */
create table emp_temp2
as 
select * from emp where 1=0;
/* 2. */
alter table emp_temp2 add grad number(1);

select * from emp_temp2;

/* 기존 테이블의 쿼리 결과를 테이블에 삽입
 * insert into 테이블명
 * select문 ;  */
insert into emp_temp2
select empno, ename, job, mgr, hiredate, sal, comm, deptno, grade
from emp, salgrade
where emp.sal between losal and hisal;


/* 쿼리문으로 테이블 생성
 * create table 테이블명
 * as
 * select문; */
create table emp_dept_grade
as
select empno, ename, emp.deptno, dname, sal, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno
and sal between losal and hisal
and 1=0;

select * from emp_dept_grade;

/* 기존 데이터를 select해서 테이블에 입력 */
insert into emp_dept_grade
select empno, ename, emp.deptno, dname, sal, grade
from emp, dept, salgrade
where emp.deptno = dept.deptno
	and sal between losal and hisal
	and emp.deptno = 10
	;



	
	
	
	
	
	
	
	
	
	
	
	
	




