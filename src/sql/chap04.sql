/* 데이터 조회 select문 */
/* select 추출할 칼럼 리스트 from 테이블명; */
select empno, ename, job, mgr, hiredate, sal, comm, deptno
	from emp;
/*wildcard 문자 *로 전체 칼럼 대체 */
select * from emp;

/*selecion*/
select * from emp where empno = 7788;

/*projection*/
select empno, ename, job, deptno from emp;

/*select & projection*/
select empno, ename, job, deptno from emp where empno = 7788;

/*select 중복 배제*/
select all deptno from emp; /*기본이 all임*/
select distinct deptno from emp;

/* 사원테이블(emp)에서 모든 사원 정보 출력*/
select*from emp;
/* 사원테이블(emp)에서 모든 사원의 사원번호, 이름, 부서번호 출력*/
select empno, ename, deptno from emp;
/* 사원테이블(emp)에서 업무(job)별 부서번호(deptno) 종류별 출력*/
select distinct job, deptno from emp;

/*칼럼결과 별칭*/
/*null과 다른 데이터롸의 연산 결과는 항상 null이 나옴*/
/*별칭에 띄어쓰기가 있으면 "" 붙혀줘야함*/
select ename, sal, sal*12 as annual, sal*12+comm "annal Sal", comm from emp; /*as는 붙혀도 안붙혀도 된다*************/


/*정렬 - 오름차순 order by 칼럼명 asc */
select*from emp order by empno;
select*from emp order by empno asc; /*asc는 default라서 생략가능*/
/*정렬 - 내림차순 order by 칼럼명 desc */
select*from emp order by empno desc;

/*정렬 기준이 두개 이상인 경우 ,로 구분*/
/*부서번호는 오름차순, 부서별 급여는 내림차순*/
select*from emp order by deptno, sal desc;


/*부서별(deptno) 오름차순, 업무별(job) 오름차순, 급여별(sal) 내림차순 */
select*from emp order by deptno, job, sal desc;


/*칼럼명에 별칭 붙이기 empno -> employee_no, ename -> employee_name,
 * mgr -> manager
 * sal -> salary
 * comm -> commision,
 * deptno -> department_no
 */
select empno employee_no,
	ename emplyee_name,
	job,
	mgr manager,
	hiredate,
	sal salary,
	comm commision,
	deptno department_no
from emp;



