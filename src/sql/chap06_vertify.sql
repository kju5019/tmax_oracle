select EMPNO,
	concat(rpad(empno,2),'**') as MASKING_EMPNO,
	ENAME,
	concat(rpad(ename,1),'****') as MASKING_ENAME
from emp
where length(ename) >=5 and length(ename) <6;



select EMPNO,ENAME,SAL,
		trunc(SAL/21.5,2) as DAY_PAY,
		round(SAL/21.5/8,1) as TIME_PAY
from emp;



select EMPNO, ENAME, HIREDATE,
		to_char(next_day(add_months(hiredate,3), '월요일'),'yyyy/MM/dd'),
		
from emp;