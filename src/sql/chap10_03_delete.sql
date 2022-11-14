/* 데이터 삭제 delete from 테이블 where 조건 */
select * from emp_temp;

delete from emp_temp where job = 'MANAGER';


/* 삭제 조건에 sub 쿼리 사용 */
/* 급여 등급이 3등급, 부서번호 30인 사원 정보 삭제 */
select * from emp_temp2;

delete from emp_temp2
where empno in
(select empno from emp, salgrade
where emp.sal between losal and hisal
	and emp.deptno = 30
	and salgrade.grade = 3)
	;
	
	
/* 전체 데이터 삭제 */
delete from emp_temp;
select * from emp_temp;

/* Data Manipulation Language */
/* select(retrieve), insert(create), update, delete --> CRUD */





