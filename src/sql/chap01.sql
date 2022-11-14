/* 계정 리스트 */
select*from dba_users;
/*물리적 공간 확인*/
select*from dba_data_files;
/*논리적 공간 확인*/
select*from dba_tablespaces;

/*사용자 인덱스 정보
primary key는 주키로 사용, 인덱스(빠른검색)로도 사용*/
select*from user_indexes;

/* index 생성  create index 인덱스명 on 테이블(칼럼)*/
create index ind_dept
on dept(dname);

/*생성된 인덱스에 해당하는 칼럼을 기준으로 조회*/
select *from dept;
select *from dept where dname = 'SALES';


select*from emp;
select*from dept;
select*from salgrade;

/* view 생성 */
create view emp_dept_salInfo as
select empno, ename, job, sal, dname, loc, grade
	from emp, dept, salgrade
	where emp.deptno = dept.deptno
	and emp.sal between salgrade.losal and salgrade.hisal
	;
	
/*생성된 view 확인*/
select*from user_views;
/*view로부터 조회*/
select*from emp_dept_salInfo;



create view emp_info
as
select empno, ename, job, deptno
from emp;
/*view로부터 공개된 정보 조회*/
select*from emp_info;




/*시퀀스 생성*/
create sequence seq_no;
/* 접속한 유저가 생성한 모든 오브젝트 정보 조회*/
select*from user_objects order by object_type;

/*시퀀스로부터 값 조회*/
/* select 값(식|함수) from 테이블; */
select 'hello' from dual;
select sysdate from dual;
select seq_no.nextval, seq_no.currval from dual;



/* 시노님 생성*/
create synonym myEmp
for scott.emp;

select*from myEmp;



/*프로시저 생성*/
create or replace procedure pro_noparam
is
v_empno number(4):=7788;
v_ename varchar2(10);
begin 
	v_ename := 'SCOTT';
	dbms_output.put_line('v_empno : '||v_empno);
	dbms_output.put_line('v_ename : '||v_ename);
end;
/* cmd
 * SQL> set serveroutput on
 * SQL> exec pro_noparam
 */


/*함수 생성*/
create or replace function func_aftertax(
sal in number) /*입력되는 매개변수 선언*/
return number /* 리턴할 타입 선언*/
is
tax number := 0.05;
begin
		return (round(sal - (sal*tax)));
end func_aftertax;

select func_aftertax(10000) from dual;



create table a(col1 varchar2(10));
create table b(col1 varchar2(10));
insert into a values('hello');
insert into b values('hello');
select*from a;
select*from b;

/*a테이블에 값이 insert 되면 b에도 자동 insert 되도록 tirgger 작성*/
/* :old.col1 <- null , :new.col1 <- 'hello'   이전값과 이후값의 존재
 * 삭제일 경우
 * :old.col1 <- 'hello', :new.col1 <- null
 * 수정일 경우 'hello' -> 'hi'
 * :old.col1 <- 'hello' , new.col1 <- 'hi'
 */
create or replace trigger trg_insrt_a
after /* 트리거 발생 시점 입력 직후*/
insert on a /* insert <= 이벤트(입력), a <= 테이블명*/
for each row
begin
	insert into b(col1) values (:new.col1);
end;

select*from user_triggers;

insert into a(col1) values ('hello kim');
insert into a(col1) values ('hi kim');
insert into a(col1) values ('bye kim');
insert into a(col1) values ('kkk');
select*from a;
select*from b;

alter trigger trg_insrt_a disable;
alter trigger trg_insrt_a enable;






