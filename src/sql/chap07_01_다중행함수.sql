/* 다중행 함수*/
select sum(sal) from emp;

select avg(sal), sum(sal)/14 from emp;

/*count 함수는 값이 null이면 집계에서 제외됨 */
select count(empno), count(*), count(comm), count(nvl(comm,0)) from emp; /*--------------- *로 세는게 제일 안전하다 => 제일 일반적-----------------*/

select max(sal) from emp;	/* 최대값 */

select min(sal) from emp;	/* 최소값 */



/* 부서별로의 함수 결과값을 얻고 싶을 땐?*/
/* 그룹별 집계  group by */
select deptno, sum(sal) from emp
group by deptno order by deptno;

select deptno, avg(sal), sum(sal)/14, sum(comm), round(sum(sal)/count(*))
from emp
group by deptno;

select deptno, count(empno), count(*), count(comm), count(nvl(comm,0)) from emp
group by deptno order by deptno;


select deptno, max(sal) from emp 
group by deptno order by deptno;

select deptno, min(sal) from emp
group by deptno order by deptno;



/*-----------------------------*/
select deptno, job, max(sal), min(sal) from emp 
group by deptno, job 
order by deptno, job;



/*group by 후 having 절 사용하기 */
/* 개별 데이터 조건인 where과 having 같이쓰면 오류남*/
select deptno, job, avg(sal)
from emp
group by deptno, job
having avg(sal) >= 2000 /*개별 데이터가 아닌 집계데이터 대상으로 필터링 */
order by deptno, job;



select deptno, job, sum(sal)
from emp
where deptno in (10,30) 	/*개별 데이터 추출 조건 where */
group by deptno, job
having sum(sal) >= 2500 	/*집계 이후 데이터 추출 조건 having */
order by deptno, job;



/*rollup, cube 소계, 합계 구하기*/
/*rollup( group by 기준)*/
select deptno, job, count(*), max(sal), sum(sal), avg(sal)
from emp
group by rollup(deptno, job);

/*cube (group by 기준) 2^n 조합*/
select deptno, job, count(*), max(sal), sum(sal), avg(sal)
from emp
group by cube(deptno, job)
order by deptno, job;


/* 그룹핑 셋 */
select deptno, job, count(*)
from emp
group by grouping sets(deptno,job)
order by deptno, job;


/*grouping(칼럼) 그룹이 되었으면 0, 안되었으면 1 출력 */
select deptno, job, count(*), max(sal), sum(sal), avg(sal),
	grouping(deptno),
	grouping(job)
from emp
group by cube(deptno,job)
order by deptno, job;

/*grouping_id(여러개 칼럼) 00이면0, 01이면1, 10이면2, 11(null,null)이면3 */
select deptno, job, count(*), max(sal), sum(sal), avg(sal),
	grouping(deptno),
	grouping(job),
	grouping_id(deptno,job)
from emp
group by cube(deptno,job)
order by deptno, job;



/* LISTAGG - 가로 출력 */
select deptno, 
	listagg(ename,',')
	within group(order by sal desc) as enames
from emp
group by deptno;

/* pivot */
select * 
from(select deptno, job, sal from emp)
pivot(max(sal) for deptno in (10,20,30))
order by job;


/* unpivot - 세로 출력 */
select deptno,
		max(decode(job,'CLERK',sal)) "CLERK",
		max(decode(job,'SALESMAN',sal)) "SALESMAN",
		max(decode(job,'PRESIDENT',sal)) "PRESIDENT",
		max(decode(job,'MANAGER',sal)) "MANAGER",
		max(decode(job,'ANALYST',sal)) "ANALYST"
from emp
group by deptno
order by deptno;


select *
from(	select deptno,
		max(decode(job,'CLERK',sal)) "CLERK",
		max(decode(job,'SALESMAN',sal)) "SALESMAN",
		max(decode(job,'PRESIDENT',sal)) "PRESIDENT",
		max(decode(job,'MANAGER',sal)) "MANAGER",
		max(decode(job,'ANALYST',sal)) "ANALYST"
from emp
group by deptno
order by deptno)
unpivot(sal for job in (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST))
order by deptno, job;













