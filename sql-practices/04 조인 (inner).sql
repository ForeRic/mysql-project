-- INNER JOIN

-- 현재 근무하고 있는 여직원의 이름과 직책을 직원 이름 순으로 출력하세요
select a.first_name, b.title
	from 	employees a, titles b
	where 	a.emp_no = b.emp_no -- 두 테이블을 붙이는 조건. join condition. 
	and 	b.to_date = '9999-01-01' -- select condition 현재 근무 직책
	and 	a.gender = 'F' 			-- 여직원 select condition
order by 	a.first_name;
-- reference for down below
select *
from employees limit 0,2;-- 실행시 뒤에 limit : mysql 있는 문법임. 게시판이나 상품에 리밋 달림 보통. 근데 여기선 양이 많아서 자동으로 걸어줌

-- 부서별로 현재 직책이 engineer 인 직원들에 대해서만 평균 급여를 구하세요 
-- (부서정보, 직책 , salary 필요 - dept_emp, titles, salaries. 중간단계인 employees 를 쓰면 좋지만 모델링시 쓰고 이번은 pass) 
select a.emp_no, a.dept_no, b.salary, c.title -- 뽑아낼 column 갯수 4 : 제일 마지막에 쓰는 곳
	from dept_emp a, salaries b, titles c -- 어디서 먼저 데이터를 뽑아내야 하는지 가장 먼저 쓰는 곳. 변수들 생성되는 곳 (a,b,c)
    where a.emp_no = b.emp_no 		-- join condition a=b
    and b.emp_no = c.emp_no 		-- join condition b=c
    and a.to_date = '9999-01-01' 	-- select condition for a (현재)
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and c.title = 'Engineer';

-- group by 해서 dept_no 부서만 뽑아냄. 그곳의 평균 연봉만 구하는 것 
select a.emp_no, avg(b.salary) -- 뽑아낼 column 갯수 2 : 제일 마지막에 쓰는 곳
	from dept_emp a, salaries b, titles c -- 어디서 먼저 데이터를 뽑아내야 하는지 가장 먼저 쓰는 곳. 변수들 생성되는 곳 (a,b,c)
    where a.emp_no = b.emp_no 		-- join condition a=b
    and b.emp_no = c.emp_no 		-- join condition b=c
    and a.to_date = '9999-01-01' 	-- select condition for a (현재)
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and c.title = 'Engineer'
group by a.dept_no;
-- order by 로 salary 내림차순
select a.emp_no, avg(b.salary) as avg_salary -- 뽑아낼 column 갯수 2 : 제일 마지막에 쓰는 곳
	from dept_emp a, salaries b, titles c -- 어디서 먼저 데이터를 뽑아내야 하는지 가장 먼저 쓰는 곳. 변수들 생성되는 곳 (a,b,c)
    where a.emp_no = b.emp_no 		-- join condition a=b
    and b.emp_no = c.emp_no 		-- join condition b=c
    and a.to_date = '9999-01-01' 	-- select condition for a (현재)
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and c.title = 'Engineer'
group by a.dept_no
order by avg_salary desc;
-- department 까지 얹어서. 
select a.emp_no, d.dept_name,avg(b.salary) as avg_salary -- 뽑아낼 column 갯수 2 : 제일 마지막에 쓰는 곳
	from dept_emp a, salaries b, titles c, departments d -- 어디서 먼저 데이터를 뽑아내야 하는지 가장 먼저 쓰는 곳. 변수들 생성되는 곳 (a,b,c)
    where a.emp_no = b.emp_no 		-- join condition a=b
    and b.emp_no = c.emp_no  		-- join condition b=c
    and a.dept_no = d.dept_no 
    and a.to_date = '9999-01-01' 	-- select condition for a (현재)
    and b.to_date = '9999-01-01'
    and c.to_date = '9999-01-01'
    and c.title = 'Engineer'
group by a.dept_no
order by avg_salary desc;

-- 현재 직책별로 급여의 총합의 구하되, engineer 직책은 제외하세요. 
-- 단, 총합이 2,000,000,000 이상인 직책만 나타내며 급여의 통합에 대해서는 내림차순 (desc)으로 정렬하소서. 
-- (현재 (where to_date) / 직책 (titles) distinct engineer / 급여 총합 (sum salary) / 총합 20~ 이상 desc 
select 	a.title, sum(b.salary)
from 	titles a, salaries b
where 	a.emp_no = b.emp_no
and 	a.to_date = '9999-01-01'
and 	b.to_date = '9999-01-01'
and 	a.title != 'Engineer'
group by a.title 
having 	sum(b.salary)>2000000000
order by	 sum(b.salary) desc;

-- ---------------------------------------------------------------------
-- ANSI / ISO SQL 1999 Join 문법 
--
-- join ~ on : 표준 문법 : join 조건과 select 조건이 명확함. 
-- OR
-- equijoin (equi (=) join) (where 절에 join 과 select condition 섞여있음)
-- 현재 근무하고 있는 여직원의 이름과 직책을 직원 이름 순으로 출력하세요
select a.first_name, b.title
	from 	employees a 
    join titles b 
    on a.emp_no = b.emp_no-- join 할것 명확하게 하고 on 에다가 join 할것 같다 붙여씀. 
	where 	 b.to_date = '9999-01-01' -- select condition 현재 근무 직책
	and 	a.gender = 'F' 			-- 여직원 select condition
order by 	a.first_name;

-- Natural Join (조건이 없음)
select a.first_name, b.title
	from 	employees a 
natural join titles b  -- 자동으로 자연스럽게 함 join on 기능이랑 같음. 근데 자동으로 걸리는 조인 조건이 있어야 하자네. : 칼럼 이름이 같으면 다 조인함. employees 랑 titles 안에 emp_no가 같아서 그게 조인이 걸림. 
	where 	 b.to_date = '9999-01-01' -- select condition 현재 근무 직책
	and 	a.gender = 'F' 			-- 여직원 select condition
order by 	a.first_name;
-- 여기서 count 세고 싶으면 down below
select count(*) -- *: ALL 
	from 	employees a 
natural join titles b  
	where 	 b.to_date = '9999-01-01' -- select condition 현재 근무 직책
	and 	a.gender = 'F' 			-- 여직원 select condition
order by 	a.first_name; -- result: 96010

-- natural join (뭐가 안좋은지) vs join on 
select count(*)
	from titles a 
    join salaries b
    on 	a.emp_no = b.emp_no -- 조건 명확 
    where a.to_date = '9999-01-01' 
    and   b.to_date = '9999-01-01'; -- result 240124
-- Natural join 단점임    DO NOT USE IF U CAN 잘못쓰면 큰일 남. 의도치 않은 칼럼이 두개가 같다고 세워짐. 이것을 극복할라고 join using 이 나옴... 
select count(*)
	from 	titles a 
natural join salaries b -- emp_no 만 걸어야 하는데 같은걸 다 join 해버림. 
    where 	a.to_date = '9999-01-01' 
    and   	b.to_date = '9999-01-01'; -- result 4
    
-- Join ~ using : 관계는 걸지 않지만 어떤 칼럼을 가져다 쓰겠다 하는 거임.
select count(*)
	from titles a 
    join salaries b
    using 	(emp_no) -- = on 	a.emp_no = b.emp_no -- 조건 명확
    where a.to_date = '9999-01-01' 
    and   b.to_date = '9999-01-01'; -- result 240124
    
-- Outer JOIN = Left Join , Right Join 
-- 현재 회사의 직원의 이름과 부서 이름을 출력하세요. (table 새로 2개 만들어서 ) 양이 많아서.. // 모델링 설계 툴: erd -> DDL 스크립트 물리 테이블 만들어줌. Forward Engineering 

-- 1. 테스트 데이터 넣기
 insert into dept values (null, '총무');
 insert into dept values (null, '개발');
 insert into dept values (null, '영업');

 insert into emp values (null, '둘리', 2);
insert into emp values (null, '마이콜', 3);
insert into emp values (null, '또치', 2);
insert into emp values (null, '도우넛', 2);
insert into emp values (null, '길동', null);

-- 현재 회사의 직원의 이름과 부서 이름을 출력하라 
select a.name, b.name 
	from emp a
    join dept b 
    on 	a.dept_no = b.no;
    
-- Left Join 
-- (join 을 사이에 두고 더 나와야 할 쪽을 left 에 둠.) employee 쪽이 더 데이터가 나와줘야 함. 길동이! 
select a.name, b.name 
	from emp a
left join dept b 
    on 	a.dept_no = b.no; -- result : 길동이 나오고 옆에 null 나옴 테이블에 
    
    select a.name, ifnull(b.name,'없음') -- 만약 null 이면 없음이라고 나오게 해라. null 대신 없음 출력됨. 
	from emp a
left join dept b 
    on 	a.dept_no = b.no; 

-- RIGHT join (팀이 나옴)
select a.name, b.name 
	from emp a
right join dept b 
    on 	a.dept_no = b.no; -- result: 팀이 총무 팀이 나옴.

select ifnull(a.name, "직원없음"), b.name 
	from emp a
right join dept b 
    on 	a.dept_no = b.no;
