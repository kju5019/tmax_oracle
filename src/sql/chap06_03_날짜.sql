/* 현재 날짜 시간 출력 함수 sysdate */
select sysdate from dual;


/*날짜 연산(기준단위: 날짜) */
select sysdate as now,
	   sysdate -1 as yesterday, /* - 이전날짜*/
	   sysdate +1 as tomorrow	/* + 이후날짜*/
from dual;
	   

/* 개월 후 날짜 구하기 add_months(날짜, 개월수) */
select sysdate,
		add_months(sysdate,3), /*3달 후*/
		add_months(sysdate,-3) /*3달 전*/
from dual;


/* 사원별 입사(hiredate) 10주년이 되는 날짜 추출 */
select empno, ename, hiredate, add_months(hiredate,120) as work10years
from emp;

/*입사 40년 미만 사원 출력*/
select empno, ename, hiredate, add_months(hiredate,12*40)
from emp
where add_months(hiredate,12*40)>sysdate ;


/* 개월 수 구하기 함수 month_between(a,b)  a-b  */
select empno, ename, hiredate,12*40, round(months_between(sysdate,hiredate))
from emp
where round(months_between(sysdate,hiredate)) > 12*40 ;

select empno, ename, hiredate, sysdate,
		months_between(hiredate, sysdate) as month1,  /* 이전-현재 = 음수*/
		months_between(sysdate, hiredate) as month2   /* 현재-이전 = 양수*/
from emp;



/* 요일 계산 함수 next_day(), 월의 마지막 날 계산 함수 last_day() */
select sysdate, next_day(sysdate, '월요일'), next_day(sysdate, '금요일'), last_day(sysdate) from dual; /*돌아오는 첫 번재 n요일 */


/* 날짜 반올링 함수 round(), trunc() */
select sysdate, 
		round(sysdate,'CC') as format_cc,
		round(sysdate,'yyyy') as format_yyyy,		
		round(sysdate,'Q') as format_q,			/*분기 반올림*/
		round(sysdate,'ddd') as format_ddd,		/*정오 반올림*/
		round(sysdate,'hh') as format_hh		/*시간 반올림*/
from dual;

select sysdate, 
		trunc(sysdate,'CC') as format_cc,
		trunc(sysdate,'yyyy') as format_yyyy,		
		trunc(sysdate,'Q') as format_q,			/*분기 버림*/
		trunc(sysdate,'ddd') as format_ddd,		/*정오 버림*/
		trunc(sysdate,'hh') as format_hh
from dual;







