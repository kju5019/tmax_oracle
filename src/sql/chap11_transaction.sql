/* transaction cimmit rollback */
create table dept_tcll as select * from dept;
select * from dept_tcll;

insert into dept_tcll values(50,'DATABASE','SEOUL');
update dept_tcll set loc = 'BUSAN' where deptno = 40;
delete from dept_tcll where dname = 'RESEARCH';

select * from dept_tcl;

commit

insert into dept_tcll values(60,'WEB','PANGYO');
update dept_tcll set loc = 'JEJU' where deptno = 40;
delete from dept_tcll where dname = 'DATABASE';
/* 앞전 commit 시점 이후부터 작업 insert, update, delete 작업 내용을 이전 commit 시점을 되돌림 */
rollback


drop table dept_tcl