/* 숫자 관련 함수들 */
select round(1234.5678) as round, /* 소수점 첫자리에서 반올림 값 */
		round(1234.5678,0) as round_0, /* 소수점 첫째자리에서 반올림 값 */
		round(1234.5678,1) as round_1, /* 소수점 둘째자리에서 반올림 값 */
		round(1234.5678,2) as round_2, /* 소수점 셋째자리에서 반올림 값 */
		round(1234.5678,-1) as round_3, /* 자연수 일의자리에서 반올림 값 */
		round(1234.5678,-2) as round_4 /* 자연수 십의자리에서 반올림 값 */
from dual;

/*trunc(숫자값, 자리수) */
select trunc(1234.5678) as trunc, /* 소수점 첫자리에서 버림 값 */
		trunc(1234.5678,0) as trunc_0, /* 소수점 첫째자리에서 버림 값 */
		trunc(1234.5678,1) as trunc_1, /* 소수점 둘째자리에서 버림 값 */
		trunc(1234.5678,2) as trunc_2, /* 소수점 셋째자리에서 버림 값 */
		trunc(1234.5678,-1) as trunc_3 /* 자연수 일의자리에서 버림 값 */
		trunc(1234.5678,-2) as trunc_4 /* 자연수 십의자리에서 버림 값 */
from dual;

/* 지정한 숫자와 가까운 정수 ceil()--올림정수, floor()--내림정수 */
select ceil(3.14), floor(3.14), ceil(-3.14), floor(-3.14)
from dual;


/*나머지 함수 mod(a,b) */
select mod(15,6), mod(10,2), mod(11,2) from dual;












