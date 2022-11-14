/* 커서 */
declare
 v_dept_row dept%rowtype; /*deptno,dname,loc */
begin
	select deptno, dname, loc
	into v_dept_row
	from dept
	where deptno=40;
	dbms_output.put_line('deptno: '||v_dept_row.deptno);
	dbms_output.put_line('dname: '||v_dept_row.dname);
	dbms_output.put_line('loc: '||v_dept_row.loc);
end;


/* 단일행 커서저장 */
declare
 v_dept_row dept%rowtype; 				--커서 데이터 입력받을 변수 선언
 
 cursor c1 is select deptno,dname,loc 	--명시적 커서 선언
 				from dept where deptno = 40;
 				
begin
	open c1;							--커서 open
	fetch c1 into v_dept_row;			--fetch
	
	dbms_output.put_line('deptno: '||v_dept_row.deptno);
	dbms_output.put_line('dname: '||v_dept_row.dname);
	dbms_output.put_line('loc: '||v_dept_row.loc);
	
	close c1;
end;


/* 여러행 커서저장 */
declare
 v_dept_row dept%rowtype; 				--커서 데이터 입력받을 변수 선언
 
 cursor c1 is select deptno,dname,loc 	--명시적 커서 선언
 				from dept;
 				
begin
	open c1;
	
	loop
		fetch c1 into v_dept_row;
		
		-- %notfound 속성으로 반복 빠져나오기
		exit when c1%notfound;
	
		dbms_output.put_line('deptno: '||v_dept_row.deptno);
		dbms_output.put_line('dname: '||v_dept_row.dname);
		dbms_output.put_line('loc: '||v_dept_row.loc);
		dbms_output.put_line('------------------------------');
	end loop;
	close c1;
end;


declare
 cursor c1 is select deptno,dname,loc 	--명시적 커서 선언
 				from dept;
begin
	for c1_rec in c1 loop
		dbms_output.put_line('deptno: '||c1_rec.deptno);
		dbms_output.put_line('dname: '||c1_rec.dname);
		dbms_output.put_line('loc: '||c1_rec.loc);
		dbms_output.put_line('------------------------------');
	end loop;

end;



/* 파라미터를 사용한 커서
 * cursor 커서명(파라미터 자료형,...) IS select문... */
declare
	--명시적 커서 선언
	cursor c1 (p_deptno dept.deptno%type) is
	  select deptno, dname, loc
	    from dept
	  where deptno = p_deptno;
	--커서 데이터를 담을 변수 선언
	v_dept_row dept%rowtype;
begin
	open c1(10);
	loop
		fetch c1 into v_dept_row;
		exit when c1%notfound;
	dbms_output.put_line('10번 부서-deptno:'||v_dept_row.deptno||' dname:'||v_dept_row.dname||' loc:'||v_dept_row.loc);
	end loop;
	close c1;
end; 

/* 입력받아서 출력 */
declare
	--명시적 커서 선언
	cursor c1 (p_deptno dept.deptno%type) is
	  select deptno, dname, loc
	    from dept
	  where deptno = p_deptno;
	--커서 데이터를 담을 변수 선언
	v_dept_row dept%rowtype;
	v_deptno dept.deptno%type;
begin
	--입력데이터 바인딩변수 선언
	v_deptno := &input_data;
	open c1(v_deptno);
	loop
		fetch c1 into v_dept_row;
		exit when c1%notfound;
	dbms_output.put_line(v_deptno||'번 부서-deptno:'||v_dept_row.deptno||' dname:'||v_dept_row.dname||' loc:'||v_dept_row.loc);
	end loop;
	close c1;
end; 



/* 묵시적 커서 */
begin
	update dept set dname = 'DATABASE'
	where deptno = 50;
	
	dbms_output.put_line('갱신된 행의 수 '||SQL%ROWCOUNT);
	
	if SQL%FOUND then
		DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부: true');
	else
		DBMS_OUTPUT.PUT_LINE('갱신 대상 행 존재여부: false');
	end if;
	
	if SQL%isopen then
		DBMS_OUTPUT.PUT_LINE('커서의 open여부: true');
	else
		DBMS_OUTPUT.PUT_LINE('커서의 open여부: false');
	end if;
end ;




/* EXCEPTION */
/* 예외코드 
 * 예외 발생 이후 명령문은 실행 안됨 */
declare
  v_wrong number;
begin
	select dname into v_wrong
	from dept
	where deptno=10;
	dbms_output.put_line('예외 발생시 이 메세지는 출력 안됨');
	
	exception
	when value_error then
		dbms_output.put_line('예외처리 : 수치 또는 값 오류');
end;
/


/* 사전 정의된 예외 사용하기 */
declare
  v_wrong number;
begin
	select dname into v_wrong
	from dept
	where deptno=10;
	dbms_output.put_line('예외 발생시 이 메세지는 출력 안됨');
	
	exception
	 when too_many_rows then
		dbms_output.put_line('예외처리 : 요구보다 많은 행 출력 오류');
	 when value_error then
		dbms_output.put_line('예외처리 : 수치 또는 값 오류');
	 when dup_val_on_index then
		dbms_output.put_line('예외처리 : 중복저장 오류');
	 when others then
		dbms_output.put_line('예외처리 : 사전 정의 외 오류 발생');
end;
/




/* SQL 코드, SQLERRM */
declare
 v_wrong number;
begin
	select dname into v_wrong
	  from dept
	where deptno = 10;	
	dbms_output.put_line('예외 발생시 이 메세지는 출력 안됨');
	
	exception
	when others then
		dbms_output.put_line('예외처리 : 사전 정의 외 오류 발생');
		dbms_output.put_line('SQLCODE: '||to_char(SQLCODE));
		dbms_output.put_line('SQLERRM: '||sqlerrm);

end;













