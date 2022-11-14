/**/
select file_name, tablespace_name,  bytes/1024/1024 
from dba_data_files;

select * from dba_data_files;

/* tablespace에 물리적인 파일 공간 추가하기 */
alter tablespace users 
add datafile  'C:\\ORACLEXE\\APP\\ORACLE\\ORADATA\\XE\\USERS2.DBF' 
size 100m;


select tablespace_name,  sum(bytes/1024/1024) 
from dba_data_files
group by tablespace_name
;



/* 패스워드 만료 처리 */
alter user scott password expire;

/* scott 유저에서 테이블 생성 */
create table temp01(
col1 varchar2(20),
col2 varchar2(20)
);

/* 객체 권한 
 * grant 권한 on 객체 to 유저 */
grant select on temp01 to hr;
grant insert on temp01 to hr;
grant delete on temp01 to hr;

select * from temp01;


/* 권한 회수 
 * revoke 권한 on 객체 from 유저 */
revoke select on temp01 from hr;
revoke insert on temp01 from hr;
revoke delete on temp01 from hr;

/* 한번에 여러 권한 부여 and 회수 */
grant select, insert,delete on temp01 to hr;
revoke insert,delete on temp01 from hr;


/* Role
 * connect - alter session, create cluster, create database link, create sequence, create session
 * resource - creater trigger, create sequence, create type, create procedure, create cluster
 */

/* 사용자 정의 role 생성하기*/
SQL> create role rolestudy;

Role created.


SQL> grant connect, resource, create view,
  2  create synonym to rolestudy;

Grant succeeded.


SQL> grant rolestudy to hr;

Grant succeeded.

/* role 회수 */
SQL> revoke rolestudy from hr;

Revoke succeeded.

/* role과 권한 확인 */
select * from user_sys_privs;
select * from user_role_privs;












