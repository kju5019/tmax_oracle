set serveroutput on
 
  /* 데이타 타입 */
  1  declare
  2  v_empno number(4) :=7839;
  3  v_ename varchar2(10);
  4  v_job  varchar2(10);
  5  begin
  6  v_ename :='KING';
  7  v_job :='PRESIDENT';
  8  dbms_output.put_line('v_empno:'||v_empno);
  9  dbms_output.put_line('v_ename:'||v_ename);
 10  dbms_output.put_line('v_job: '||v_job);
 11* end;
SQL> /
v_empno:7839
v_ename:KING
v_job: PRESIDENT
/*-----------------------------------------------------*/
PL/SQL procedure successfully completed.

  1  declare
  2  v_tax constant number(1) :=3;
  3  begin
  4  dbms_output.put_line('v_tex:'||v_tax);
  5* end;
SQL> /
v_tex:3

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
  1  declare
  2  v_tax constant number(1) :=3;
  3  v_sal number(7,2) :=5000;
  4  begin
  5  dbms_output.put_line('v_tex:'||v_sal*(v_tax/100));
  6* end;
SQL> /
v_tex:150

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_deptno number(2) default 10;
  3  begin
  4  dbms_output.put_line('v_deptno:'||v_deptno);
  5  end;
  6  /
v_deptno:10

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_deptno number(2) default 10;
  3  begin
  4  v_deptno :=20;
  5  dbms_output.put_line('v_deptno:'||v_deptno);
  6* end;
SQL> /
v_deptno:20

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_deptno number(2) not null :=10;
  3  begin
  4  dbms_output.put_line('v_deptno:'||v_deptno);
  5* end;
  6  /
v_deptno:10

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/


SQL> ed
Wrote file afiedt.buf

  1  declare
  2  --v_deptno number(2) :=50;
  3* v_deptno dept.deptno%type :=50;
  4  begin
  5  dbms_output.put_line('v_deptno: '||v_deptno);
  6  end;
  7  /
v_deptno: 50

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_dept_row dept%rowtype;
  3  begin
  4  select deptno, dname, loc into v_dept_row
  5    from dept
  6   where deptno = 40;
  7  dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_dept_row.dname);
  9  dbms_output.put_line('loc:'||v_dept_row.loc);
 10  end;
 11  /
deptno:40
dname:OPERATIONS
loc:BOSTON

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_dept_row dept%rowtype;
  3  begin
  4  select deptno, dname, loc into v_dept_row
  5    from dept
  6   where deptno = 40;
  7  dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_dept_row.dname);
  9  dbms_output.put_line('loc:'||v_dept_row.loc);
 10* end;


SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_name dept.dname%type;
  3  begin
  4  select dname into v_name
  5    from dept
  6   where deptno = 40;
  7  --dbms_output.put_line('deptno:'||v_dept_row.deptno);
  8  dbms_output.put_line('dname:'||v_name );
  9  --dbms_output.put_line('loc:'||v_dept_row.loc);
 10* end;
SQL> /
dname:OPERATIONS

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> declare
  2  v_number number :=13;
  3  begin
  4   if mod(v_number,2) =1 then
  5      dbms_output.put_line('v_number는 다.');
  6  end if;
  7  end;
  8  /
v_number는 다.


PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_number number :=13;
  3  begin
  4   if mod(v_number,2) =1 then
  5      dbms_output.put_line('v_number는 홀수입니다.');
  6  end if;
  7* end;
SQL> /
v_number는 홀수입니다.

PL/SQL procedure successfully completed.
/*-----------------------------------------------------*/
SQL> ed
Wrote file afiedt.buf

  1  declare
  2  v_number number :=14;
  3  begin
  4   if mod(v_number,2) =0 then
  5      dbms_output.put_line(v_number||'는 짝수입니다.');
  6  end if;
  7* end;
SQL> /
14는 짝수입니다.

PL/SQL procedure successfully completed.

/*-----------------------------------------------------*/
declare
v_number number :=14;
begin
if mod(v_number,2)=0 then
	dbms_output.put_line(v_number||'는 짝수입니다.');
else
	dbms_output.put_line(v_number||'는 홀수입니다.');
end if;
end;
/
/*-----------------------------------------------------*/

declare
v_score number :=87;
begin
if v_score >=90 then
	dbms_output.put_line('A학점');
elsif v_score >=80 then
	dbms_output.put_line('B학점');
elsif v_score >=70 then
	dbms_output.put_line('C학점');
else
	dbms_output.put_line('F학점');
end if;
end;
/

/*-----------------------------------------------------*/

declare
v_score number :=87;
begin
	--dbms_output.put_line(trunc(v_score/10));
   case trunc(v_score/10)
	when 10 then dbms_output.put_line('A학점');
	when 9 then dbms_output.put_line('A학점');
	when 8 then dbms_output.put_line('B학점');
	when 7 then dbms_output.put_line('C학점');
	else dbms_output.put_line('F학점');
end case;
end;
/

/*-----------------------------------------------------*/

declare
v_empno emp.empno%type := 7788;
v_ename emp.ename%type;
v_dname dept.dname%type;
v_grade salgrade.grade%type;

begin
   select empno,ename, dname,grade
     into v_empno, v_ename, v_dname,v_grade 
     from emp, dept, salgrade
    where emp.deptno = dept.deptno
      and sal between losal and hisal
      and empno=v_empno;
   dbms_output.put_line('사원번호:'||v_empno);
   dbms_output.put_line('사원명:'||v_ename);
   dbms_output.put_line('부서명:'||v_dname);
   dbms_output.put_line('급여등급:'||v_grade);
    --사원번호,
    --사원명
    --부서명
    --급여등급
end;
/     
/*-------------------------------------------------*/
declare
v_empno emp.empno%type := 7788;
v_ename emp.ename%type;
v_dname dept.dname%type;
v_grade salgrade.grade%type;
v_empinfo emp%rowType;
begin
   select empno,ename, dname,grade,null,null,null,null
     into v_empinfo 
     from emp, dept, salgrade
    where emp.deptno = dept.deptno
      and sal between losal and hisal
      and empno=v_empno;
   dbms_output.put_line('사원번호:'||v_empinfo.empno);
   dbms_output.put_line('사원명:'||v_empinfo.ename);
   dbms_output.put_line('부서명:'||v_empinfo.job);
   dbms_output.put_line('급여등급:'||v_empinfo.mgr);
    --사원번호,
    --사원명
    --부서명
    --급여등급
end;
/


/*---------기본 루프 exit when----------------------------------------*/

declare
v_num number:=0;
begin
loop
	dbms_output.put_line('현재 v_num: '||v_num);
v_num := v_num+1;
exit when v_num > 4;
end loop;
end;
/

/*---------기본 루프 exit if----------------------------------------*/

declare
v_num number:=0;
begin
loop
	dbms_output.put_line('현재 v_num: '||v_num);
v_num := v_num+1;
--exit when v_num > 4;
if v_num > 4 then
	exit;
   end if;
end loop;
end;
/


/*---------while 루프----------------------------------------*/

declare
v_num number := 0;
begin
while v_num < 4 loop
	dbms_output.put_line ('현재 v_num :'||v_num);
v_num := v_num+1;
end loop;
end;
/


/*---------for i in 시작..끝 루프----------------------------------------*/

begin
for i in 0..4 loop		/* 시작과 끝 */
	dbms_output.put_line('현재 i의 값 :'||i);
end loop;
end;
/

begin
for i in reverse 0..4 loop		/* 시작과 끝을 반대로 */
	dbms_output.put_line('현재 i의 값 :'||i);
end loop;
end;
/


/*-----------------for문 안에 continue------------------------------------*/
begin
for i in 0..4 loop
	continue when mod(i,2) = 1;
	dbms_output.put('현재 i의 값: '|| i || ' ');
end loop;
dbms_output.put_line (' ');
end;
/

/*-------------if 조건 then continue-------------------------------*/
begin
for i in 0..4 loop
  if mod(i,2) = 1 then
	--continue when mod(i,2) = 1;
  continue;
  end if;
	dbms_output.put('현재 i의 값: '|| i || ' ');
end loop;
dbms_output.put_line (' ');
end;
/

/*-------------------이중 for문----------------------------------*/
begin
for i in 2..9 loop
  for j in 1..9 loop
	dbms_output.put(i||'x'||j||'='||(i*j)||'    ');
end loop;
dbms_output.put_line (' ');
end loop;
end;
/

/*-----------------------------------------------------*/
























