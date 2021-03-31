-- employees db!!

-- 예제1.: salaries 테이블에서 현재 전체 직원의 평균 + 최고 급여 출력

select ave(salary), max(salary)
	from salaries 
    where to_date = '9999-01-01';

-- emp_no: 이거 에러가 나야하는 구문임.. (집계함수 넣었기 때문에 쿼리 안돌아야함): 빼라. 
select emp_no, max(salary) 
	from salaries 
    where to_date = '9999-01-01';
    
-- 2. salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총합
select avg(salary), sum(salary) 
from salaries
where emp_no = 10060;

-- 3. 이 예제 직원의 최저 임금 '받은 시기'와 최대 임금 받은 시기를 가각 출력하셈
-- select 절에 집계함수가 있으면, 다른 컬럼은 올 수 없다.
-- 따라서 '받은 시기' (from date or to date) 는 조인이나 서브쿼리를 통해서 구해야 한다. 
select max(salary), min(salary) 
from salaries
where emp_no = 10060;
-- 밑에 구문에서는 department name 이 없다 : from 이후가 deaprtments 가 되야함 
select * from dept_emp; 
-- 4. dept-emp 테이블에서 d008에 현재 근무하는 인원수는 
select *
  from dept_emp
 where dep_no = 'd008' 
   and to_date = '9999-01-01';
   
-- 그룹 관리와 heading 
-- 5. 각 사원별 평균연봉 출력 // 여태 직원들의 salary 에서 emp_no 로 그룹바이 해서 각 emp_no 에 대한 평균이 나옴
select emp_no, avg(salary) as avg_salary
  from salaries
group by emp_no 
order by avg_salary desc; -- 여러 row 가 있어서 해볼 수 있다. 

-- 6. salaries 테이블에서 현재 전체 직원별로 평균급여가 35000 이상인 직원의 평균 급여를 큰 순으로 내봐라.
-- -- avg(salary) 가 35000 이상이어야하니까  (현재 못함: )
-- where 지나서 group by
select emp_no, avg(salary)  
	from salaries
	where to_date='9999-01-01'
 group by emp_no 
 having avg(salary) > 35000
 order by avg(salary) desc;
 
-- 7. 사원별로 몇 번의 직책 변경이 있었는지 조회하삼.
select emp_no, count(*)
	from titles
group by emp_no;

select * from titles where emp_no = 10004; 

-- 8. 현재 직책별로 직원수를 구하되 직원수가 100명 이상인 직책만 출력하삼
select title, count(*) as cnt
from titles
where to_date = '9999-01-01'
group by title
having cnt >100 
order by cnt desc;