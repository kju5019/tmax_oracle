/* 오라클 함수 upper() 대문자, lower() 소문자, initcap() 첫글자대문자 나머지소문자 */
select 'hello', upper('hello'), upper('Hello'), lower('HELLO'), lower('Hello'), initcap('hello'), initcap('Hello') from dual;

select 'hello gildong', initcap('hello gildong'), initcap('hellogildong') from dual;


/*where 절에서 upper, lower 사용*/ /* 모두 대문자, 소문자로 */
select*from emp where upper(ename) = upper('scott');
select*from emp where upper(ename) = 'SCOTT';
select*from emp where ename = upper('scott');

/* lower */
select*from emp where lower(ename) = 'scott';
select*from emp where lower(ename) = lower('Scott');

/*like와 같이 사용 */
select*from emp where upper(ename) like upper('%scott%');
select*from emp where upper(ename) like upper('%s%');

/* 문자열 길이 length, lengthb(바이트씩) */
select ename, length(ename), lengthb(ename) from emp;
select '안녕하세요', length('안녕하세요'), lengthb('안녕하세요') from dual;

select length('한글'), lengthb('한글') from dual;


/* 문자열 길이 where절에서 사용*/
select empno, ename from emp where length(ename) >=5;


/* substr() 함수 문자열 추출*/
select job, substr(job,1,2), substr(job,3,2), substr(job,5) from emp;
/* 음수는 뒤에서부터 시작*/
select job, substr(job,-length(job)), substr(job,-length(job),2), substr(job,-3) from emp;



/* instr() 문자열내의 해당 패턴의 시작 위치 번호 */
select instr('HELLO, ORACLE!','L') as instr_1,
	instr('HELLO, ORACLE!','L',5) as instr_2, /* instr(문자열,패턴,시작인덱스번호)*/
	instr('HELLO, ORACLE!','L',2,2) as instr_3, /* instr(문자열, 패턴, 시작인덱스번호, 두번째 발견패턴 */
	instr('HELLO, ORACLE!','F') as instr_4 /*데이터베이스는 1부터시작이라 포함안되는 번호 0이 출력된다. JAVA는 -1 출력되는것과 같음*/
	from dual;
	
/* instr() where 절에서 사용 */
select * from emp where instr(ename,'S') > 0;
select * from emp where ename like '%S%';




/* replace(문자열, 찾는문자열(old), 대체문자열(new)) */
select '010-1234-5678' as repalce_before,
	replace('010-1234-5678','-',' ') as replace_1,
	replace('010-1234-5678','-') as replace_2
from dual;


/* lpad(대상문자열, 전체길이, 채울패턴), rpad(대상문자열, 전체길이, 채울패턴) */ /*left, right*/ /*----------------p.141---------------*/
select 'Oracle',
	lpad('Oracle',10,'#') as lpad_1,
	rpad('Oracle',10,'#') as rpad_1,
	lpad('Oracle',10) as lpad_2,
	length(lpad('Oracle',10)) as lpad_2_length,
	length(rpad('Oracle',10)) as rpad_2_length,
	length(trim(lpad('Oracle',10))) as lpad_2_trim,
	length(trim(rpad('Oracle',10))) as rpad_2_trim
from dual;


/* rpad() 함수를 사용하여 개인정보 뒷자리 마스킹 */
select rpad('971225-', 14, '*') as rpad_jmno,
       rpad('010-1234-', 13, '*') as rpad_phone
from dual;


/*문자열 합치기 ||, 함수 concat(a,b) */
select empno || ename,
		concat(empno, ename)
from emp
where ename = upper('scott');

/*두개 이상의 문자열 합치기*/
select empno|| ':' ||ename,
		concat(empno, concat(':',ename))
from emp
where ename = upper('scott');


/* 특정 패턴을 지우는 trim, ltrim, rtrim */
/* trim([삭제옵션(선택) leading/trailing/both] from [타겟문자(필수)]) */
select '['|| trim(' _ _Oracle_ _ ')||']' as trim from dual;
select '['|| trim(leading from ' _ _Oracle_ _ ')||']' as trim_leading from dual;
select '['|| trim(trailing from ' _ _Oracle_ _ ')||']' as trim_trailing from dual;
select '['|| trim(both from ' _ _Oracle_ _ ')||']' as trim_both from dual;
       
/* trim([삭제옵션(선택) leading/trailing/both] [삭제할 문자(선택)] from [타겟문자(필수)]) */
select '['|| trim('_'from' _ _Oracle_ _ ')||']' as trim, /*공백이 앞뒤에 있어서 '_'가 안없어진다링*/
		'['|| trim('_'from'_ _Oracle_ _')||']' as trim,
		'['|| trim(leading '_'from'_ _Oracle_ _')||']' as trim_leading,
		'['|| trim(trailing '_'from'_ _Oracle_ _')||']' as trim_trailing,
		'['|| trim(both '_'from'_ _Oracle_ _')||']' as trim_both
from dual;


/* ltrim([원본 문자열(필수)], [삭제할 문자집합(선택)]) , rtrim() */
select '['|| trim(' _Oracle_ ')||']' as trim,
		'['|| ltrim(' _Oracle_ ')||']' as ltrim,
		'['|| ltrim('<_Oracle_>','_<')||']' as ltrim_2, /*--------------- _< 와 <_ 둘다 제거된다 ----------------*/
		
		'['|| rtrim(' _Oracle_ ')||']' as rtrim,
		'['|| rtrim('<_Oracle_>','>_')||']' as rtrim_2
from dual;







