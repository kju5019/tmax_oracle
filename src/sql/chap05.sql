/*해당 조건에 맞는 행만 추출할 때, where 칼럼=값; */

/*부서번호가 30인 사원정보 데이터 출력*/
select*from emp where deptno=30;

/*job을 기준으로 추출 job이 'CLERK'*/
select*from emp where job = 'CLERK';

/*칼럼의 연산결과와 같은 값을 가지는 조건으로 추출*/
/* sal*12를 한 결과가 36000인 사원 정보*/
select*from emp where sal*12=36000;

/* 비교연산으로 추출*/
select*from emp where sal >= 3000;

/*이름(문자열) 비교연산(=, !=, >=, <=,<,>)으로 추출*/              
select*from emp where ename >= 'F' order by ename;
select*from emp where ename >= 'FORZ' order by ename; /* F 미포함 */
select*from emp where ename <= 'FORZ' order by ename; /* F 포함 */

/*급여가 3000이 아닌 사원들만 추출*/               /*-------!= 는 <>, ^= 로도 쓸 수 있다.--------*/
select*from emp where sal != 3000;
select*from emp where sal <> 3000;
select*from emp where sal ^= 3000;


/*조회 조건이 2개 이상인 경우*/
/*부서 번호(deptno)=30, job='SALEMAN'인 사원들*/
select*from emp where deptno=30 and job='SALESMAN';

/*입사일자가 1980년 1월 1일 이후 입사, 부서번호가 30이고, job='CLERK'인 사원정보*/
select*from emp where hiredate >= '1980-01-01' and deptno=30 and job='CLERK';


/*부서번호가 30, job='salesman', comm이 0인 사원*/
select*from emp where deptno=30 and job='SALSMAN' and comm=0;
/*emp 테이블에서 job의 종류는 몇개일까?*/
select distinct job from emp;
select count(distinct job) from emp;
/*emp 테이블에서 모든 사원의 수는 몇명?*/
select count(empno) from emp;
/*emp 테이블에서 job별 오름차순, 급여별 내림차순 정렬*/
select*from emp order by job, sal desc;

/*emp 테이블에서 job변 오름차순, 연봉(sal*12+comm)별 내림차순 정렬*/
select*from emp order by job, (sal*12+comm) desc;
select empno, job, sal, sal*12+comm from emp order by job, (sal*12+comm) desc;
select empno, job, sal, sal*12+nvl(comm,0) from emp order by job, (sal*12+nvl(comm,0)) desc;
/*null값과 null이 아닌값을 연산한 결과는 null이 되어 연산 불가*/
/*null을 다른값으로 대체하는 함수 nvl(칼럼(값),대체값)
 *앞의 인자가 null이 아니면 그대로 출력, null이면 뒤의 대체값으로 출력  */
select nvl(null,0), nvl(1,0) , nvl(null,'hello') from dual;



/* or연산자와 IN 연산자*/
select*from emp where job='MANAGER' or job='SALESMAN' or job='CLERK';
select*from emp where job in('MANAGER','SALESMAN','CLERK');


/* 등가비교연산자와 and 연산자로 출력*/
select*from emp where job !='MANAGER' and job<>'SALESMAN' and job^='CLERK';

/* IN 연산자와 논리 부정 연산자로 출력*/
select*from emp where not job in ('MANAGER','SALESMAN','CLERK');


/* 비교연산, AND*/
/* 급여(SAL)가 2000~3000사이인 사원*/
select*from emp where sal >= 2000 and sal <= 3000;
/*between 최소 and 최대 */
select*from emp where sal between 2000 and 3000;

select*from emp where sal < 2000 or sal > 3000;
select*from emp where not sal between 2000 and 3000;



/*like와 와일드카드 문자*/
 /*S로 시작하는 사원*/
select*from emp where ename like 'S%';
/* S로 끝나는 사원*/
select*from emp where ename like '%S';
/*사원이름의 두 번째 글자가 L인 사원*/
select*from emp where ename like '_L%';
/*사원이름의 세 번재 글자가 M인 사원*/
select*from emp where ename like '__M%';
/*사원이름 중 'AM이 들어간 사원*/
select*from emp where ename like '%AM%';
select*from emp where not name like '%AM%';  /*안들어간 사원*/



/*null값 비교 is null, is not null*/
select*from emp where comm is null;  /* comm = null <----이렇게 쓰면 안됨*/
select*from emp where mgr is not null;

select*from emp where sal > null and comm is null;



/* 연산자 */
select ename, sal, sal*12+nvl(comm,0) as annsal, comm from emp;

/* 직속상관(mgr)이 있는 사원 출력 */
select*from emp where mgr is not null;

/*and와 is null 연산자 사용*/
select*from emp where sal > null and comm is null; /*안나옴*/
select*from emp where sal > null or comm is null; /*나옴*/



/*집합 연산*/
/* UNION*/ /* 합집합 - 교집합 */
/*출력되는 두 쿼리의 칼럼 수나 데이터 타입이 다른 경우 = 오류 */
select empno, ename, sal, deptno
	from emp
	where deptno=10
union
select empno, ename, sal, deptno
	from emp
	where deptno=20;
	
/* 칼럼 갯수가 다른 경우 숫자인 경우 처리*/	
select empno, ename, sal, 10
	from emp
	where deptno=10
union
select empno, ename, sal, deptno
	from emp
	where deptno=20;
	
/* 칼럼 갯수가 다른 경우 문자인 경우 처리*/	
select empno, 'noName', sal, deptno
	from emp
	where deptno=10
union
select empno, ename, sal, deptno
	from emp
	where deptno=20;
	
	

/* 동일 쿼리문으로 union */
select empno, ename, sal, deptno
	from emp where deptno=10
union
select empno, ename, sal, deptno
	from emp where deptno=10;
	
/* union all = A+B */
select empno, ename, sal, deptno
	from emp where deptno=10
union all
select empno, ename, sal, deptno
	from emp where deptno=10;

	
	
/* 차집합 */
select 10, 'hello', sysdate from dual
minus
select 10, 'hello', sysdate from dual

/*A - (A and B) */
select mgr,job from emp where deptno = 10
minus
select mgr,job from emp where deptno = 20;



/* 교집합 intersection */
select empno, ename, sal, deptno
from emp
intersect
select empno, ename, sal, deptno
from emp where deptno = 10;



/*연산자 우선순위
 * *,/
 * +,-
 * =, !=, >, >=
 * is null, is not null, like, in
 * between A and B
 * not
 * and
 * or
 */

/*---------------연습문제---------------------*/

/* 1) emp 테이블에서 사원이름(ename) S로 끝나는 사원 모두 출력*/
select * from emp where ename like '%S';

/* 2) 30번 부서(deptno)에서 근무하는 사원 중 직책(job)이 'SALESMAN'인 사원의 사원번호, 이름, 직책, 급여, 부서번호 출력*/
select empno, ename, job, sal, deptno from emp where deptno=30 and job = 'SALESMAN';

/* 3) 20번 부서, 30번 부서에 근무하는 사원 중 급여가 2000 초과인 사원 출력 (사원번호, 이름, 직책, 급여, 부서번호)
 * 1. 집합연산자를 사용하지 않은 방식
 * 2. 집합연산자를 사용하는 방식 (union, union all) 
 */
select empno, ename, job, sal, deptno from emp where (deptno=20 or deptno=30) and sal>2000;
select empno, ename, job, sal, deptno from emp where deptno=20 and sal>2000
union 
select empno, ename, job, sal, deptno from emp where deptno=30 and sal>2000;

/* 4) 급여(sal)값이 2000이상 3000이하 범위 이외의 값을 가진 데이터*/
select *from emp where not sal between 2000 and 3000;

/* 5)사원이름에 E가 포함된 30번 부서의 사원 중 급여가 1000~2000사이인 
 * 사원의 이름, 사번, 급여, 부서번호 출력 */
select empno, ename, job, sal, deptno from emp 
where ename like '%E%' and deptno=30 and sal between 1000 and 2000;
 
/* 6)추가수당(comm)이 존재하지 않고 상급자가 있고 직책이 
 * MANAGER, CLERK인 
 * 사원 중 사원이름의 두번째 글자가 L이 아닌 사원 정보 */ 
select * from emp 
where comm is null
and mgr is not null
and job in('MANAGER','CLERK')
and ename not like '_L%';



