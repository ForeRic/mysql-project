-- 1. where 
select concat(first_name, ' ', last_name) as '이름'
	from employees
	where emp_no = '10944';

-- 2. 문제2. 
-- 전체직원의 다음 정보를 조회하세요.
-- 가장 선임부터 출력이 되도록 하세요. 
-- 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요
-- alias 쓰세요
select concat(first_name, ' ', last_name) as '이름', 
		gender as '성별',
		hire_date as '입사일'
    from employees
    order by hire_date;

-- 3. 여직원 남직원 각 몇? 쿼리 1번으로 count , where 절에. 두개로 나눠서 풀라는 문제 : 모르겠음
select count(gender)
	from employees
    where gender = 'F';
select count(gender)
	from employees
    where gender = 'M';
select count(gender)
    from employees;

-- 4. 현재 근무하는 직원수?(salaries테이블 사용)
-- salary 가서 to_date 9999 시작하는것 그리고 카운트 세삼
select count(*) from salaries where to_date like '9999%';
select count(*) from salaries where from_date like '2001%';

-- 5. 부서는 총 몇개가 있죠? distinct 는 결과 테이블. count 집계 순서는 
-- select 
-- from
-- where
-- order by (맨 마지막)
select distinct count(dept_name)
	from departments;

-- 6. 현재 부서 매니저는 몇명?
select count(emp_no)
	from dept_manager;

-- 7. length 
select dept_name 
	from departments
    order by length(dept_name) desc;
    
-- 8. 현재 급여 120,000 count 세야 
select count(salary) from salaries;

-- 9. 중복 distinct 하고 그 타이틀의 length 하고 order by
select distinct title , length(title) as lt
from titles
order by lt desc;

-- 10. where to date 타이틀 걸어서 count 세면 됨. 
select count(emp_no) 
	from titles 
	where to_date like '9999%' and title = 'Engineer';
-- 11. 사번이 13250(zeydy) 얘가 직책이 어떻게 변경됐는지 시간순으로 쭉 적어라. 
select emp_no, title
	from titles
    where emp_no = '13250' and to_date like '9999%'
    order by title;
    