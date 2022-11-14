/* sub 쿼리 */
/* 'JONES' 사원의 급여보다 많이 받는 사원 출력 */
select sal from emp where ename = 'JONES';  /* => 2975 */
select * from emp where sal > 2975;

select * from emp where sal > (select sal from emp where ename = 'JONES');


/* SCOTT 사원보다 입사일자가 먼저인 사원들 정보 출력 */
select hiredate from emp;
update emp set hiredate = to_date('1987-07-13') where ename = 'SCOTT';

select * from emp
where hiredate < (select hiredate from emp where ename = 'SCOTT');


/* 전체 평균 급여보다 급여를 많이 받는 사원들 정보 출력 */
select avg(sal) from emp;
select * from emp where sal> 2073;

/* 집계 함수를 이용한 서브쿼리 */
select empno, ename, job, sal
from emp
where sal > (select avg(sal) from EMP);

/* join한 테이블에서 sub 쿼리 */
select empno, ename, job, sal, dept.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
and sal > (select avg(sal) from emp);


/* 다중 행 서브쿼리 */
/* 다중 행 결과는 in()으로 대체 가능 */
select* from emp
where sal in (select max(sal) from emp group by deptno);

/*다중 행 = 비교는 =any, =some */
select* from emp
where sal = any (select max(sal) from emp group by deptno);

select* from emp
where sal = some (select max(sal) from emp group by deptno);


/* 30번 부서의 최고 급여보다 적게받는 사원들 정보 */
select sal from emp where deptno =30;
select * from emp
where sal < any (select sal from emp where deptno = 30);

/* 30번 부서의 급여보다 적게받는 사원들 정보 */
/* all 서브쿼리와 비교조건에서 모두 만족해야 true */
select * from emp
where sal < all (select sal from emp where deptno = 30);


/* 30번 부서의 최고급여보다 많이 받는 사원만 출력 */
select * from emp
where sal > all (select sal from emp where deptno = 30);

select * from emp
where sal > (select max(sal) from emp where deptno = 30);


/* exists 조건에 맞는 결과가 존재하면 true */
select * from emp
where exists (select dname from dept where deptno = 10);



/* where 조건에 칼럼 두개 이상 서브쿼리와 비교 */
/* where (칼럼1, 칼럼2,...) in (select 칼럼1, 칼럼2,...) */
select * from emp
where (deptno, sal)in (select deptno, max(sal) from emp group by deptno);


/* from 절에 sub쿼리 사용하기 */
select * from emp where deptno = 10;
select * from dept;

select *
from (select * from emp where deptno = 10) a,
	(select * from dept) b
where a.deptno = b.deptno;

select ename, sal, dname
from
(select empno, ename, sal, deptno from emp where deptno = 10) a,
(select deptno, dname from dept) b
where a.deptno = b.deptno;


/*from절의 서브쿼리 */
select rownum, empno, ename, sal
from emp;

select rownum, empno, ename, sal
from emp
where rownum <= 5;

select rownum, empno, ename, sal
from emp
where rownum >= 5;

select *
from( select rownum as rn, empno, ename, sal from emp) a  /* 먼저 조회 후에 걸러내기 때문에 나온다. 별칭도 붙여야함 (rn) */
where rn >= 5
;

/* rownum 가상(pseudo)칼럼에 별칭을 붙여서 다른 칼럼으로 사용*/
select *
from( select rownum as rn, empno, ename, sal 
		from emp
		where rownum <=10
		) a  												/* 먼저 조회 후에 걸러내기 때문에 나온다. 별칭도 붙여야함 (rn) */
where rn >= 5
;


/* with */
with
e10 as (select * from emp where deptno = 10),
d as (select * from dept)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
from e10, d
where e10.deptno = d.deptno;



/* 칼럼에 사용되는 sub 쿼리 */
select empno, ename, job, sal,
	(select grade 
	from salgrade 
	where e.sal between losal and hisal) as salgrade,
	(select dname 
	from dept 
	where e.deptno = dept.deptno) as dname
from emp e;














