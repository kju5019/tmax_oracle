/* 14.1*/
create table table_null(
login_id varchar2(20),
login_pwd varchar2(20),
tel varchar2(20)
);

insert into table_null(login_id,login_pwd,tel)
values(null,null,null);

select * from table_null;

insert into table_null(login_id,login_pwd,tel)
values('hong',null,null);

insert into table_null(login_id,login_pwd)
values('hong','1234');

insert into table_null(login_pwd,tel)
values('1234','010-111-1234');

commit


		/* 무결성 제약조건 */
/* 1. 영역 무결성(domain integrity)
 *		-자료형, 형식데이터, null여부 지정한 형식에 맞는지 체크
 * 2. 개체 무결성(entity integrity)
 * 		-테이블 데이터 유일 식별 키(기본키는 null이 되면 안됨)
 * 3. 참조 무결성(referential integrity)
 * 		-외래키값 참조테이블의 기본키로서 존재헤야함, null가능
 */


create table table_notnull(
login_id varchar2(20) not null,
login_pwd varchar2(20) not null,
tel varchar2(20)
);

select * from table_notnull;


insert into table_notnull(login_id,login_pwd,tel)
values(null,null,null);


insert into table_notnull(login_id,login_pwd,tel)
values('hong',null,null);

insert into table_notnull(login_id,login_pwd)
values('hong','1234');

insert into table_notnull(login_pwd,tel)
values('1234','010-111-1234');



/*not null로 지정한 칼럼의 데이터를 update로 null 변경 */
select * from table_notnull;

update table_notnull
	set login_pwd = null
where login_id = 'hong'
;


/* 제약조선 조회 user_constraints */
select * from user_constraints where constraint_name not like 'BIN%';


/* 사용자 정의 제약조건 명 
 * constraint 제약조건명 제약조건 */
create table table_notnull2(
login_id varchar2(20) constraint tblnn2_lgnid not null,
login_pwd varchar2(20) constraint tblnn2_lgnpw not null,
tel varchar2(20)
);


/* 제약조건 변경 
 * alter table*/
alter table table_notnull modify (tel not null) /*이미 안에 null이 있으면 변경이 안됨 -> 데이터를 먼저 바꾸자*/

update table_notnull
	set tel = '010-111-1234'
	where login_id = 'hong';
	
commit
select * from table_notnull;


/*not null 칼럼 제약조건명 */
select * from table_null;

update table_null
	set login_id = 'kim'
	where login_id is null
	and rownum = 1
	;
	
update table_null
	set login_id = 'kang'
	where login_id is null
	and rownum = 1
	;
commit

alter table table_null modify (login_id constraint tbln_loginid_notnull not null);

/* 제약조건 조회 user_constraints */
select * from user_constraints where constraint_name not like 'BIN%';


/* 제약조건명 변경 
 * alter table 테이블면 rename 이전 제약조건명 to 새로운 제약조건명*/
alter table table_null
rename constraint tbl_tel_nn to tbl_id_nn;


/*제약조건 삭제 
 * drop constraint 제약조건명 */
alter table table_null drop constraint tbl_id_nn;




/*14-3 unique 제약 조건 */
create table table_unique(
id varchar2(20) unique,
pwd varchar2(20) not null,
tel varchar2(20)
);

insert into table_unique values ('hong','1234','010-111-1234');
insert into table_unique values ('hong','1234','010-111-1234'); /*중복 오류*/
insert into table_unique values (null,'1234','010-111-1234'); /* unique에서 null은 중복으로도 입력 가능*/

select * from table_unique;





/* 테이블의 id는 primary key, tel은 unique 제약조건*/
create table table_tel_unique(
id varchar2(20) primary key,
pwd varchar2(20),
tel varchar2(20) unique
);

select * from table_tel_unique;

insert into table_tel_unique values ('hong','1234','010-111-1234');
insert into table_tel_unique values ('kim','1234','010-111-5678');
insert into table_tel_unique values ('kang','1234','010-111-5678'); /* tel이 unique 제약조건으로 오류 발생*/
/* ORA-00001: unique constraint (SCOTT.SYS_C007071) violated*/


/* 제약조건 삭제 
 * alter table 테이블명 drop constraint 제약조건명*/
alter table table_tel_unique drop constraint SYS_C007071;


/* 테이블 생성 후 제약조건 추가하기*/
alter table table_tel_unique 
	modify (tel constraint tbl_unique_tel unique)


/*제약조건 이름변경 */
alter table table_tel_unique
rename constraint tbl_unique_tel to tbl_tel_unique;









/* primary key 제약조건 (not null & unique)*/
create table table_pk(
id varchar2(20) primary key,
pwd varchar2(20) not null,
tel varchar2(20)
);

/* 제약조건 조회 user_constraints */
select * from user_constraints where table_name = 'TABLE_PK';

insert into table_pk values ('hong','1234',null);
insert into table_pk values ('hong','1234','010-111-1234');	/*오류*/
insert into table_pk values (null,'1234','010-111-1234'); 	/*오류*/



/* primary key 이름 부여*/
create table table_pk2(
id varchar2(20) constraint tblpk2_id_pk primary key,
pwd varchar2(20) constraint tblpk2_pwd_nn not null,
tel varchar2(20)
);

/* 제약조건 조회 user_constraints */
select * from user_constraints where table_name = 'TABLE_PK2';

/* primary key 이름 부여*/
create table table_pk3(
id varchar2(20),
pwd varchar2(20) not null, 
tel varchar2(20),
primary key(id),
constraint tbl_pwd_nn unique(pwd) /*not null제외*/
);

/* 제약조건 조회 user_constraints */
select * from user_constraints where table_name = 'TABLE_PK3';



/* 복합키로 주키 생성시 */
create table table_pk4(
id varchar2(20),
sno varchar2(20),
pwd varchar2(20), 
tel varchar2(20),
primary key(id,sno)		/* primary key(칼럼1,칼럼2,...)*/
);



/*FOREIGN KEY 제약조건
 * 부모테이블의 주키가 자식테이블의 속정으로 참조되는 키 */
/* 부모테이블*/
create table dept_fk(
deptno number(2) constraint deptfk_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13)
);

/*자식테이블*/
create table emp_fk(
empno number(4) constraint emp_fk_empno_pk primary key,
ename varchar2(10),
job varchar2(9),
mgr number(4),
hiredate date,
sal number(7,2),
comm number(7,2),
deptno number(2) constraint empfk_deptno_fk 
				references dept_fk(deptno)
);


/* 부모테이블에 데이터 입력*/
insert into dept_fk values(10,'Accounting','서울시'); /*10번이 아닌 다른데이터는 자식테이블에 못들어감*/
select * from dept_fk;

insert into emp_fk values(9999,'홍길동','MANAGER',null,to_date('2001/01/01','yyyy/mm/dd'),3000,null,20); /*parent key not found 오류*/
insert into emp_fk values(9999,'홍길동','MANAGER',null,to_date('2001/01/01','yyyy/mm/dd'),3000,null,10);
insert into emp_fk values(9998,'일지매','ANALYST',null,to_date('2001/01/01','yyyy/mm/dd'),3000,null,null); /*부서번호 null은 들어감*/
select *from emp_fk;


insert into dept_fk values(20,'SALES','수원시');
/*foreign key로 지정된 칼럼의 데이터를 null-> 부모테이블의 domain 값으로 update */
update emp_fk
	set deptno=20	/* null->20 */
where empno=9998;

select*from user_constraints;
 

/* foreign key 제약조건이 적용된 부모테이블 삭제 */
delete from dept_fk where deptno = 10;	/* child record found 자식칼럼이 있어서 불가함 */

alter table emp_fk
disable constraint empfk_deptno_fk;		/*제약조건을 비활성화 */

alter table emp_fk
enable constraint empfk_deptno_fk;	


/*참조하는 자식테이블 데이터부터 먼저 삭제 */
delete from emp_fk where deptno=10;
delete from dept_fk where deptno=10;


/* 제약조건 생성시 on delete 옵션 추가 */
select * from user_constraints where table_name = upper('emp_fk');

/* emp_fk 테이블의 foreign key 제약 조건 삭제*/
alter table emp_fk
drop constraint empfk_deptno_fk;

/* 부모테이블의 칼럼값 삭제시 참조하는 모든 자식테이블의 해당 칼럼값이 삭제*/
/* alter table 테이블명
 * add constraint 제약조건명
 * foreign key(칼럼)
 * references 부모테이블(부모칼럼)
 * on delete cascade; -------참조하는 자식 테이블의 행 삭제
 */
alter table emp_fk
add constraint empfk_deptno_fk 
foreign key(deptno)
references dept_fk(deptno)
on delete cascade;

/* on delete cascade 적용 후 부모 테이블의 칼럼값 삭제 */
delete from dept_fk where deptno=20;

select * from emp_fk;


rollback;





/* emp_fk테이블의 foreign key 제약 조건 삭제 */
alter table emp_fk 
drop constraint empfk_deptno_fk;

/* 참조되는 부모테이블의 칼럼값 삭제시 참조하는 모든 자식 테이블의
 * 해당칼럼값을 null로 처리 */     
alter table emp_fk
add constraint empfk_deptno_fk 
foreign key(deptno)
references dept_fk(deptno)
on delete set null;       
       
/* 제약조건 생성시 on delete 옵션추가 */
select * from user_constraints 
 where table_name=upper('emp_fk');       
       
       
 /* on delete set null 적용 후 부모테이블의 칼럼값 삭제 */
delete from dept_fk where deptno=20;
select * from dept_fk;
select * from emp_fk;






/* check 제약조건 */
create table table_check(
id varchar2(20) constraint tbl_id_pk primary key,
pwd varchar2(20) constraint tbl_pwd_ck check (length(pwd) > 3),
tel varchar2(20)
);

insert into table_check values ('hong','1234','010-111-1234');
select*from table_check;

insert into table_check values ('kim','123','010-111-1234');

select * from user_constraints;


/* 기본값 지정하는 default */
create table table_default (
id varchar2(20) constraint tblck2_id_pk primary key,
pwd varchar2(20) default '1234',
tel varchar2(20),
regdate date default sysdate
);

select * from table_default;
select * from user_constraints 
 where table_name=upper('table_default');   

insert into table_default(id, tel) values('hong','010-111-1234');
insert into table_default values('kang','3333','010-111-1234',to_date('2022/10/17','yyyy-mm-dd'));
























