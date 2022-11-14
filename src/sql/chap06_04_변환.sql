/* 자료형 변환 함수 */
select 'abcd' + empno, empno from emp where ename = 'scott'; /*문자열 + 숫자 연산 오류*/

/* 숫자형 문자열인 경우 +연산 가능*/
select empno, ename, empno+'500' from emp where ename = 'SCOTT'; /* '500'이 숫자형 문자열*/


/* 날짜 -> 문자열로 변환 함수 */
select to_char(sysdate, 'yyyy/MM/dd hh24:MI:SS') as 현재날짜시간
from dual;

select sysdate,
		to_char(sysdate,'MM') as MM,
		to_char(sysdate,'MON') as MON,		/*한글에서는 표가 안남 JUN, JUL*/                 /* 언어별 월 이름 약자*/
		to_char(sysdate,'MONTH') as MONTH,	/* JUNE, JULY 처럼 영어에서 차이있음*/			    /* 언어별 월 이름 전체*/
		to_char(sysdate,'DD') as DD,		/*월의 날짜*/
		to_char(sysdate,'DDD') as DDD,		/*년의 날짜*/
		to_char(sysdate,'DY') as DY,		/*요일	수*/
		to_char(sysdate,'DAY') as DAY,		/*요일	수요일*/
		to_char(sysdate,'WW') as week,		/*년의 몇 번째 주*/
		to_char(sysdate,'w') as week		/*월의 몇 번째 주*/
from dual;		


/*지역화 코드 출력 */
select sysdate,
		to_char(sysdate,'MM') as MM,
		to_char(sysdate,'DD') as DD,
		to_char(sysdate,'DY','NLS_DATE_LANGUAGE=KOREAN') as DY,
		to_char(sysdate,'DY','NLS_DATE_LANGUAGE=JAPANESE') as DY,
		to_char(sysdate,'DY','NLS_DATE_LANGUAGE=ENGLISH') as DY,
		to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=KOREAN') as DAY,
		to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=JAPANESE') as DAY,
		to_char(sysdate,'DAY','NLS_DATE_LANGUAGE=ENGLISH') as DAY
from dual;


/* to_char(날짜시간, 시간포맷) */
select sysdate,
		to_char(sysdate,'HH24:MI:SS'),
		to_char(sysdate,'HH24:MI:SS AM'),
		to_char(sysdate,'HH24:MI:SS PM'),
		to_char(sysdate,'HH24:MI:SS P.M.')
from dual;


/*통화 (currency) */
select sal,
		to_char(sal, '$999,999'),
		to_char(sal, 'L999,999'), 		/*원화*/
		to_char(sal, '999,999.00'),
		to_char(sal, '000,999,999.00'),
		to_char(sal, '000999999.99')
from emp;


/*문자 -> 숫자 변환 함수 */
select 1300 - '1500', '1300'+ 1500 from dual;

select '1,300' - '1,500', from dual;  /* 중간에 , 가 포함되어 있어서 숫자로 변환 불가 오류 */
/*to_number(숫자형 문자열, 검증 포맷) */
select to_number('1,300','999,999') - to_number('1,500','999,999') from dual;



/* 문자 -> 날짜 변환 함수 */
select to_date('2018-07-14','yyyy-mm-dd')
from dual;
select to_date('20180714','yyyy-mm-dd')
from dual;

/*where 절에서 날짜 비교 */
select * from emp where hiredate > '1981/06/01';
select * from emp where hiredate > to_date('1981/06/01','yyyy/mm/dd');

/* 포맷 */
select to_date('49/12/10', 'yy/mm/dd'), 
		to_date('49/12/10', 'RR/mm/dd'), 		/* RR은 50년이 넘으면 1950년, 50년이 안되면 2049년*/
		to_date('50/12/10', 'yy/mm/dd'),
		to_date('51/12/10', 'RR/mm/dd'),
		to_date('50/12/10', 'yy/mm/dd'),
		to_date('51/12/10', 'RR/mm/dd')
from dual;



/* null 처리 함수 nvl()*/
select empno, ename, sal, comm, sal+comm, nvl(comm,0), sal+nvl(comm,0)
from emp;

/* nvl2(값, 정상일 경우 값, null인 경우 값) */                  /*-----------------이거 편하고 좋네-----------------*/
select empno, ename, comm, nvl2(comm,'O','X'),
		nvl2(comm, sal*12+comm, sal*12)
from emp;



/*decode(), case */
/*decode(칼럼, 첫번째조건, 첫번째값, 두번째조건,두번째값,....,default)*/
select empno, ename, job, sal,
		decode(job, 'MANAGER', SAL*1.1, 
					'SALESMAN',SAL*1.05, 
					'ANALYST',SAL,
					SAL*1.03)
from emp;

/* 급여가 1000 미만이면 1, 1000초과 2000미만이면 2, 2000초과 3000미만이면 3, 3000초과는 5 */
select empno, trunc(sal/1000), sal,
		decode(trunc(sal/1000),0,1,1,2,2,3,5)	/* 결과값이 0이면1 , 1이면2, 2면3, 그 뒤론 5 */
from emp order by sal;


/* case 값 when 조건 then 값1 when 조건2 then 값2 else 디폴트값 end as 칼럼명 */
select empno, ename,
		job,sal,
		case job
		when 'MANAGER' then sal*1.1
		when 'SALESMAN' then sal*1.05
		when 'ANALYST' then sal
		else sal*1.03
		end as upsal
from emp;

/*case when 조건1 then 값1 when 조건2 then 값2,.. else 디폴트값 end as 칼럼명 */
select empno, ename,
		job,sal,
		case
		when job= 'MANAGER' then sal*1.1
		when job= 'SALESMAN' then sal*1.05
		when job= 'ANALYST' then sal
		else sal*1.03
		end as upsal
from emp;


select empno, ename, comm,
		case
		when comm is null then '해당사항 없음'
		when comm = 0 then '수당 없음'
		when comm > 0 then '수당: ' || comm
		end as comm_text
from emp;


/*급여(sal)가 1000 미만이면 'c'등급, 1000이상 2000미만이면 'b', 2000이상 3000미만이면 'a', 3000이상이면 's' */
select empno, ename, sal,
		case
		when sal < 1000 then 'C'
		when sal >= 1000 and sal < 2000 then 'B'
		when sal >= 2000 and sal < 3000 then 'A'
		else 'S'
		end as sal_grade
from emp;

select empno, ename, sal,
		case
		when sal < 1000 then 'C'
		when sal between 1000 and 2000 then 'B'
		when sal between 2000 and 3000 then 'A'
		else 'S'
		end as sal_grade
from emp;

select empno, ename, sal,
		case trunc(sal/1000)
		when 0 then 'C'
		when 1 then 'B'
		when 2 then 'A'
		else 'S'
		end as sal_grade
from emp;



