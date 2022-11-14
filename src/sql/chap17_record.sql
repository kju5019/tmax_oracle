/* 레코드(다른 타입의 데이터형을 묶어놓은 자료구조) */
/* type 타입명 is record (타입1,타입2,...) */
declare
	type REC_DEPT is record(
	deptno number(2) not null := 99,
	dname dept.dname%type,
	loc dept.loc%type
	);
	
/* 변수 선언 */
dept_rec REC_DEPT;
begin
	dept_rec.deptno := 99;
	dept_rec.dname := 'DATABASE';
	dept_rec.loc := 'SEOUL';
	dbms_output.put_line('deptno: '||dept_rec.deptno);
	dbms_output.put_line('dname: '||dept_rec.dname);
	dbms_output.put_line('loc: '||dept_rec.loc);
	
end;



/* 레코드 타입을 사용한 insert */
create table dept_record
as 
select * from dept;

select * from dept_record;

declare
	type REC_DEPT is record(
	deptno number(2) not null := 99,
	dname dept.dname%type,
	loc dept.loc%type
	);
	dept_rec REC_DEPT;
begin
	dept_rec.deptno := 99;
	dept_rec.dname := 'DATABASE';
	dept_rec.loc := 'SEOUL';
	
	insert into dept_record
	values dept_rec;
end;

select * from dept_record;

/* 수정 */
declare
	type REC_DEPT is record(
	deptno number(2) not null := 99,
	dname dept.dname%type,
	loc dept.loc%type
	);
	dept_rec REC_DEPT;
begin
	dept_rec.deptno := 50;
	dept_rec.dname := 'DB';
	dept_rec.loc := 'SEOUL';

	update dept_record 
	   set row = dept_rec
	 where deptno = 99;
end;

select * from dept_record;


/* 조회 */
declare
  type REC_DEPT is record(
    deptno dept.deptno%type,
	dname dept.dname%type,
	loc dept.loc%type
  );
  type REC_EMP is record(
  empno emp.empno%type,
  ename emp.ename%type,
  dinfo REC_DEPT	/* 중첩레코드 */
  );
  emp_rec REC_EMP;
begin
	select e.empno, e.ename, d.deptno, d.dname, d.loc
	into emp_rec.empno, emp_rec.ename, emp_rec.dinfo.deptno, 
									   emp_rec.dinfo.dname,
									   emp_rec.dinfo.loc
	from emp e, dept d
	where e.deptno = d.deptno
	and e.empno = 7788;
	
	dbms_output.put_line('EMPNO: '||emp_rec.empno);
	dbms_output.put_line('ENAME: '||emp_rec.ename);
	dbms_output.put_line('DEPTNO: '||emp_rec.dinfo.deptno);
	dbms_output.put_line('DNAME: '||emp_rec.dinfo.dname);
	dbms_output.put_line('LOC: '||emp_rec.dinfo.loc);
end; 













/* 컬렉션 */
declare
  type ITAB_EX is table of varchar2(20) index by PLS_INTEGER;
  
  text_arr ITAB_EX;
  
 begin
	 text_arr(1) := '1st data';
	 text_arr(2) := '2nd data';
	 text_arr(3) := '3rd data';
	 text_arr(4) := '4th data';
	 
	 dbms_output.put_line('text_arr(1): '||text_arr(1));
	 dbms_output.put_line('text_arr(2): '||text_arr(2));
	 dbms_output.put_line('text_arr(3): '||text_arr(3));
	 dbms_output.put_line('text_arr(4): '||text_arr(4));
	 
end;
 
 

/* 레코드와 컬렉션 */
declare
  type REC_DEPT is record(
  deptno dept.deptno%type,
  dname dept.dname%type
  );
  type ITAB_EC is table of REC_DEPT
  index by PLS_INTEGER;
  
dept_arr ITAB_EX;
idx PLS_INTEGER := 0;

begin
	for i in(select deptno, dname from dept) loop
		idx := idx +1
		dept_arr(idx).deptno := i.deptno;
		dept_arr(idx).dname := i.dname;
		
		dbms_output.put_line(dept_arr(i).dpetno||': '||dept_arr(idx).dname);
	end loop;
end;
 
 

declare
type ITAB_EX is table of varchar2(20)
	index by PLS_INTEGER;
	
 text_arr ITAB_EX;
begin
	 text_arr(1) := '1st data';
	 text_arr(2) := '2nd data';
	 text_arr(3) := '3rd data';
	 text_arr(50) := '50th data';
	 
	 dbms_output.put_line('text_arr.COUNT: '||text_arr.COUNT);
	 dbms_output.put_line('text_arr.FIRST: '||text_arr.FIRST);
	 dbms_output.put_line('text_arr.LAST: '||text_arr.LAST);
	 dbms_output.put_line('text_arr.PRIOR(50): '||text_arr.PRIOR(50));
	 dbms_output.put_line('text_arr.NEXT(50): '||text_arr.NEXT(50));
 end;
 