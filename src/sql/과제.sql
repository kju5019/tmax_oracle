/* 6-1번.*/
select EMPNO,
	rpad(substr(empno,1,2),length(empno),'*') as MASKING_EMPNO,
	ENAME,
	rpad(substr(ename,1,1),length(ename),'*') as MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) <6;

-------------------------------------------------------------------------

/* 6-2번.*/
select EMPNO,ENAME,SAL,
	trunc(SAL/21.5,2) as DAY_PAY,
	round(SAL/21.5/8,1) as TIME_PAY
from emp;
 
-------------------------------------------------------------------------

/* 6-3번.*/
select EMPNO, ENAME, to_char(HIREDATE, 'yyyy/mm/dd') as HIREDATE,
 	to_char(next_day(add_months(hiredate,3), '월요일'), 'yyyy-mm-dd') as R_JOB,
	nvl2(comm,to_char(comm),'N/A') as COMM,
	nvl(to_char(comm),'N/A') as COMM
from emp;
 
-------------------------------------------------------------------------

/* 6-4번.*/
select EMPNO, ENAME, mgr,
	nvl2(mgr, to_char(mgr),' ') as MGR, 
	case 
	when substr(mgr,1,2) = '75' then '5555'
	when substr(mgr,1,2) = '76' then '6666'
	when substr(mgr,1,2) = '77' then '7777'
	when substr(mgr,1,2) = '78' then '8888'
	else nvl(to_char(mgr),'0000')
	end as CHG_MGR,
	decode(substr(mgr,1,2),'75','5555','76','6666','77','7777','78','8888',nvl(to_char(mgr),'0000'))
from emp;


/* 7-1 */
select deptno, trunc(avg(sal)) as avg_sal, max(sal) as max_sal, min(sal) as min_sal, count(*) as CNT
	from emp
	group by deptno;
		
/* 7-2 */
select job, count(*) from EMP
	group by job
	having count(*) >= 3;
		
/* 7-3 */
	
select to_char(hiredate,'yyyy') as hire_year, deptno, count(*) as cnt
from emp
group by to_char(hiredate,'yyyy'),deptno
order by to_char(hiredate,'yyyy') desc, deptno;


/* 7-4 */
select  nvl2(comm,'O','X') as exist_comm, count(*) as cnt
from emp
group by  nvl2(comm,'O','X');


/* 7-5 */
select deptno, 
		nvl(to_char(hiredate,'yyyy'),' '), 
		count(*) as cnt, 
		max(sal), sum(sal), avg(sal) 
from emp
group by rollup(deptno,to_char(hiredate,'yyyy'));

 

/* 8-1 */
select d.deptno, d.dname, e.empno, e.ename, sal			/* SQL-99 이전 */
	from emp e, dept d
	 WHERE e.deptno = d.deptno
	 and sal > 2000
	order by d.deptno, d.dname, e.empno, e.ename, sal;
 

select deptno, d.dname, e.empno, e.ename, e.sal			/* SQL-99 이후 */
	from emp e natural join dept d
	where e.sal > 2000
	order by deptno, d.dname, e.empno, e.ename, sal;

	 
/* 8-2 */
	
select	e.deptno, dname, 									/* SQL-99 이전 */
	trunc(avg(sal)) as avg_sal, 
	max(sal) as max_sal, min(sal) as min_sal, 
	count(*) as cnt
	from emp e, dept d
	WHERE e.deptno = d.deptno
	group by e.deptno, d.dname;
	

select	deptno, max(dname), 								/* SQL-99 이후 */
	trunc(avg(sal)) as avg_sal, 
	max(sal) as max_sal, min(sal) as min_sal, 
	count(*) as cnt
	from emp e natural join dept d
	group by deptno
	order by deptno;
	
	from emp e join dept d using (deptno)
	group by deptno, d.dname;

	

/* 8-3 */
select d.deptno, d.dname, e.empno, e.ename, job, sal				/* SQL-99 이전 */
	from emp e, dept d
	where e.deptno(+) = d.deptno		/*emp쪽이 부족하기 때문에 emp쪽에 + */
	order by d.deptno;

	
select d.deptno, d.dname, e.empno, e.ename, job, sal				/* SQL-99 이후 */
	from emp e right outer join dept d on (e.deptno = d.deptno)		/* 왼쪽이 + 가 있으니 오른쪽 조인 -> ?????????????????? */
	order by d.deptno;

	
	
/* 8-4 */
select d.deptno, d.dname, 											/* SQL-99 이전 */
		e1.empno, e1.ename, e1.mgr, e1.sal, e1.deptno,
		s.losal, s.hisal, s.grade,
		e2.empno as mgr_empno, e2.ename as mgr_ename
	from emp e1, dept d, emp e2, salgrade s
	where e1.deptno(+) = d.deptno
	and e1.mgr = e2.empno(+)
	and e1.sal between s.losal(+) and s.hisal(+)
	order by e1.deptno;
	
select d.deptno, dname, e.empno, e.ename, e.mgr, e.sal,
		e.deptno, losal, hisal,	s.grade, 
		e2.empno as mgr_empno, e2.ename as mgr_ename	
from emp e, dept d, salgrade s, emp e2
where e.deptno(+) = d.deptno
	and e. sal between s.losal(+) and s.hisal(+)
	and e.mgr = e2.empno(+)
	order by e.deptno
	;

select * from salgrade;
	
	
select d.deptno, dname, e.empno, e.ename, e.mgr, e.sal,				/* SQL-99 이후 */
		e.deptno, losal, hisal,	s.grade, 
		e2.empno as mgr_empno, e2.ename as mgr_ename	
from emp e right outer join dept d on (e.deptno = d.deptno) 						/* (+)가 왼쪽  => right */
			left outer join salgrade s on (e. sal between s.losal and s.hisal)		/* (+)가 오른쪽 => left */
			left outer join emp e2 on (e.mgr = e2.empno)							/* (+)가 오른쪽 => left */
	order by e.deptno
	;	
	

	
	
	
/* 9-1 */
select job, empno, e.ename, sal, d.deptno, dname
from emp e, dept d
where e.deptno = d.deptno
	and job = (select job from emp where ename = 'ALLEN');
	

	

/* 9-2 */
select empno, ename, dname, hiredate, loc, sal, grade
from emp e, dept d, salgrade s
where e.deptno = d.deptno
	and sal between losal and hisal
	and sal > (select avg(sal) from emp)
order by sal desc;

  

/* 9-3 */
select e.empno, e.ename, e.job, d.deptno, d.dname, d.loc
from emp e, dept d
where e.deptno = d.deptno
	and e.deptno = 10
	and job not in (select job from emp where deptno =30);



/* 9-4 */
select empno, ename, sal, grade										/* 다중행 함수 미사용 */
from emp e, salgrade s
where sal between losal and hisal
and sal > (select max(sal) from emp where job = 'SALESMAN');


select empno, ename, sal, grade 									/* 다중행 함수 사용 */
from emp e, salgrade s
where sal between losal and hisal
and sal > all (select sal from emp where job = 'SALESMAN');



/* 10장 */
create table CHAP10HW_EMP as select * from EMP;
create table CHAP10HW_DEPT as select * from DEPT;
create table CHAP10HW_SALGRADE as select * from SALGRADE;
select * from CHAP10HW_EMP;

/* 10-1 */
insert into CHAP10HW_DEPT(deptno, dname, loc) values(50, 'ORACLE', 'BUSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(60, 'SQL', 'ILSAN');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(70, 'SELECT', 'INCHEON');
insert into CHAP10HW_DEPT(deptno, dname, loc) values(80, 'DML', 'BUNDANG');
select * from CHAP10HW_DEPT;


/* 10-2 */
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7201, 'TEST_USER1','MANAGER', 7788, to_date('2016-01-02','yyyy-mm-dd'), 4500, NULL, 50);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7202, 'TEST_USER2','CLERK', 7201, to_date('2016-02-21','yyyy-mm-dd'), 1800, NULL, 50);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7203, 'TEST_USER3','ANALYST', 7201, to_date('2016-04-11','yyyy-mm-dd'), 3400, NULL, 60);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7204, 'TEST_USER4','SALESMAN', 7201, to_date('2016-05-31','yyyy-mm-dd'), 2700, 300, 60);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7205, 'TEST_USER5','CLERK', 7201, to_date('2016-07-20','yyyy-mm-dd'), 2600, NULL, 70);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7206, 'TEST_USER6','CLERK', 7201, to_date('2016-09-08','yyyy-mm-dd'), 2600, NULL, 70);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7207, 'TEST_USER7','LECTURER', 7201, to_date('2016-10-28','yyyy-mm-dd'), 2300, NULL, 80);
insert into CHAP10HW_EMP(empno, ename, job, mgr, hiredate, sal, comm, deptno)
		values (7208, 'TEST_USER8','STUDENT', 7201, to_date('2018-03-09','yyyy-mm-dd'), 1200, NULL, 80);
		
select * from CHAP10HW_EMP;

/* 10-3 */


/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/*  */
/* 13-1 */
/*(1)*/
create table empidx
as
select * from emp where 1=0; /*false 조건으로 만들기(안에가 비어있음) */
select * from empidx;

/*(2)*/
create index idx_empidx_empno on empidx(empno); /*create index 인덱스명 on 테이블명(칼럼명)*/

/*(3)*/
select * from user_indexes; /*index 정보 조회 */
select * from user_ind_columns;


/* 13-2 */
insert into empidx 
select * from emp;
commit
select * from empidx;

/*or replace 옵션은 같은이름으로 내용변경시 사용
 * -view, procedure, function, trigger */
create or replace view empidx_over15k
as
select empno, ename, job, deptno, sal, nvl2(comm,'O','X') as comm
	from empidx
	where sal > 1500
	order by empno;

select * from empidx_over15k;


/* 13-2 */
create sequence deptseq
start with 1
increment by 1
maxvalue 99
minvalue 1
nocycle
nocache  /* cycle이면 cache 필요 */
;



/* 16-1 */
begin
for i in 2..9 loop
  for j in 1..9 loop
	dbms_output.put(i||'x'||j||'='||(i*j)||'    ');
end loop;
dbms_output.put_line (' ');
end loop;
end;
/

/* 16-2 */





/* 19-2 */

create or replace function func_date_kor(
hiredate date
)
return char
is

begin
	return to_char(hiredate,'yyyy년 mm월 dd일');
end func_date_kor;







/* 19-3 */
/* 1번 */
create table dept_trg
as
select * from dept;

select * from dept_trg

/* 2번 */
create table dept_trg_log(
tablename varchar2(10),
dml_type varchar2(10),
deptno number(2),
user_name varchar2(30),
change_date date
);


/* 3번 */
create or replace trigger dept_trg_log
after
insert or update or delete on dept_trg
for each row
begin
	if inserting then
     insert into dept_trg_log
     values('DEPT_TRG', 'INSERT', :new.deptno,
             sys_context('USERENV','SESSION_USER'),sysdate);
             
  elsif updating then
     insert into dept_trg_log
     values('DEPT_TRG', 'UPDATE', :old.deptno,
             sys_context('USERENV','SESSION_USER'),sysdate);
     
  
  elsif deleting then
     insert into dept_trg_log
     values('DEPT_TRG', 'DELETING', :old.deptno,
             sys_context('USERENV','SESSION_USER'),sysdate);
	
  end if;
end ;















