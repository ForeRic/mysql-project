select * from departments;

select first_name as '이름', last_name as '성', hire_date as '입사일'
	from employees;
select concat(first_name, ' ', last_name) as '이름', 
		length(first_name),
        gender as '성 별',
		hire_date as '입사일'
	from employees;
    
-- distinct :중복된것 빼라
select distinct title from titles;

-- order by
select concat(first_name, ' ', last_name) as '이름', 
		length(first_name),
        gender as '성 별',
		hire_date as '입사일'
	from employees
order by hire_date desc;

-- 1. salaries 테이블에서 2001년 월급을 가장 높은순으로 사번
-- 월급순으로 출력
-- like 검색 : 2001로 시작하는 모든 애들. like '2001-06%' 이러면 06월
-- 가운데 pe 가 들어가거나 p로 시작하는 모든 애들. 
-- 'p___' 피로 시작하는 다음자가 3글자 가진 이름 가진 애들. p 이후 길이값 3정해줌. 
select * from employees where first_name like 'p%'; 
select * from employees where first_name like '%pe%';
select * from salaries where from_date like '2001%';
select emp_no, salary
 from salaries 
 where from_date like '2001-%'
order by salary desc;

-- 2. salaries 테이블에서 2001년 월급을 가장 높은순으로 사번: like 를 모를때
select emp_no, salary
 from salaries 
 where from_date > '2000-12-31'
 and from_date < '2002-01-01'
order by salary desc;

-- 3. salaries 테이블에서 2001년 월급을 가장 높은순으로 사번: where ppt69
select first_name, gender, hire_date
	from employees
	where hire_date < '1991-01-01'
order by hire_date desc;
-- date_format 
-- 4. employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일 출력
select first_name, gender, 
	date_format(hire_date, '%Y년 %m월 %d일 %h:%i:%s') as hire_date
	from employees
	where hire_date < '1991-01-01'
    and gender = 'F'
order by hire_date desc;

