/* 데이터 정의의 Data Definition Language (DDL) */
/* 데이터 저장소(table), 데이터 타입, 데이터 최대길이 */
/* create table 테이블명 ( 칼럼명 타입,...); */
create table emp_ddl(
empno number(4),
ename varchar2(10),
job varchar(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2)
); 

desc emp_ddl;

insert into emp_ddl values(1111,'홍길동', 'MANAGER',9999,SYSDATE,5000,NULL,20);
insert into emp_ddl values(2222,'임꺽정', 'SALESMAN',1111,SYSDATE,3000,1000,30);
insert into emp_ddl values(3333,'일지매', 'SALESMAN',1111,SYSDATE,3000,1000,30);

select * from emp_ddl;

commit
rollback

/* truncate 는 db에 직접 반영되므로 rollback 사용 불가  ------------>>> delete 와 truncate의 차이 */
truncate table emp_ddl;


/* table 수정 alter table 변경작업; */
/* table 칼럼 변경 alter table 테이블명 modify */

alter table emp_ddl modify empno number(6);     /************** 큰거에서 작은걸로 줄이는 것은 데이터가 비어있어야만 가능 ***************************/
alter table emp_ddl modify empno number(5);
alter table emp_ddl modify empno number(4);
alter table emp_ddl modify empno number(3);


/* 칼럼 추가 alter table 테이블명 add 칼럼 타입(길이) */
alter table emp_ddl add hp varchar(20);

/* 칼럼 명 바꾸기 alter table 테이블명 rename column 이전명 to 새로운명 */
alter table emp_ddl rename column hp to tel;

/* 칼럼 삭제 alter table 테이블명 drop column 칼럼명 */
alter table emp_ddl drop column tel;



/* 테이블명 변경 rename 이전테이블명 to 바꿀테이블명 */
rename emp_ddl to emp_myddl;
select * from emp_myddl;

/* 테이블 삭제 drop table 테이블명 */
drop table emp_myddl;




