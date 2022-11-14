/*전체 행의 곱의 수로 출력 카티션 곱*/
select *
from emp, dept
order by empno;

/*join 카티션 곱중에서 왼쪽의 갈럼값과 오른쪽 칼럼값이 같은 것만 추출하여 새로운 가상의 테이블 조회 결과 만듬 */
select *
from emp, dept
where emp.deptno = dept.deptno
order by empno;

/* join 후에 칼럼 조회
 * 동등 join 왼쪽테이블.칼럼명 = 오른쪽테이블.칼럼명 */
/* 출력시 칼럼이 공통이면 테이블명.칼럼 으로 표시해야함 */
select empno, ename, emp.deptno, dname, loc
from emp, dept
where emp.deptno = dept.deptno
order by e.deptno, e.name;


/* 등가(equi) 조인 = */
select * 
from emp, dept
where emp.deptno = dept.deptno
order by empno;

select * 
from emp, dept
where emp.deptno = dept.deptno
order by emp.deptno;



/* 테이블 별칭(alias) (테이블명 별칭) */
select *
from emp e, dept d /*별칭 설정*/
where e.deptno = d.deptno;


/* 테이블 별칭 부여 후 칼럼 표시 - 테이블별칭.칼럼명 */
select empno, ename, e.deptno, dname
from emp e, dept d                      /*별칭 설정*/
where e.deptno = d.deptno;


/* join과 비교 연산 */
select e.empno, e.ename, e.sal, d.deptno, d.dname, loc
from emp e, dept d
where e.deptno = d.deptno
and e.sal >=3000;


/* emp테이블 별칭 e, dept d로 등가 조인
 * 급여가 2500 이하이고 사원번호가 9999이하인 사원정보 출력
 * empno, ename, deptno, dname, loc
 */
select e.empno, e.ename,e.sal, d.deptno, d.dname, loc
from emp e, dept d
where e.deptno = d.deptno
	and sal <= 2500
	and e.empno <= 9999
order by empno;


/* 비등가 조인 (non-equi) */
select *
from emp e, SALGRADE s
where sal between losal and hisal;



/*자체(self) 조인 */
select *
from emp e1, emp e2 /*가상의 두개 테이블로 나눔*/
where e1.empno = e2.empno;

/* 각 사원들의 직속 상관의 사번과 이름을 알고 싶을때 */
select e1.empno empno, e1.ename ename,
		e2.empno mgrno, e2.ename mgrname
from emp e1, emp e2
where e1.mgr = e2.empno(+) /*조건에 맞지 않는 다른 데이터도 보여달라*/
order by e2.ename, e1.ename;

select empno,ename, mgr from emp;

/* https://tiboy.tistory.com/563 */
select level,
	lpad(' ',10*(level - 1))||ename
from emp
start with mgr is null
connect by prior empno = mgr;


/* SQL-99 표준 */
/* natural join - 두 테이블이 동일 칼럼 자동 join*/
select empno, ename, job, mgr, sal, deptno, danme, loc
from emp e natural join dept d
order by deptno, empno;

/* join ~ using ~ using(조인할 칼럼) */
select empno, ename, job, mgr, deptno, dname
from emp join dept using(deptno)
where sal >= 3000
order by deptno, empno;


/* join ~ on ~ on(조인조건) */
select empno, ename, emp.deptno, ename
from emp join dept on (emp.deptno = dept.deptno);




/* left outer join */
select e1.empno, e1.ename, e1.mgr,
		e2.empno, e2.ename
from emp e1 left outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;

/* right outer join */
select e1.empno, e1.ename, e1.mgr,
		e2.empno, e2.ename
from emp e1 right outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;

/* full outer join */
select e1.empno, e1.ename, e1.mgr,
		e2.empno, e2.ename
from emp e1 full outer join emp e2 on (e1.mgr = e2.empno)
order by e1.empno;



select hiredate from emp;




