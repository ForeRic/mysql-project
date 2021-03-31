-- 예제1. 현재 fai bale 이 근무하는 부서의 전체 직원의 사번과 이름을 출력하시오. 
-- FAi Blae 근무 주소를 알아야 함 / 그 부서를 가지고 전체 직원을 가지고 사번을 출력 
-- solution 1 : 근무하는 주소를 아는 것.
select dept_no
	from 	dept_emp a, employees b
    where 	a.emp_no = b.emp_no
    and 	a.to_date = '9999-01-01'
    and 	concat(b.first_name, ' ', b.last_name) = 'Fai Bale'; -- result: d004  == R1
    
-- 위에 결과 가지고 나와서 사번만 일단 출력
-- 별로 좋은 방법은 아님. 
-- 개별 쿼리로 해결한것이라서 --> 가능하면 하나로 해결. 한번에 때리는게 좋음. 다른 결과가 나올 수가 있음. 데이터가 많은 경우에선.
select emp_no
	from 	dept_emp 
    where 	to_date = '9999-01-01'
    and 	dept_no = 'd004'; -- R2
	-- b 추가해서 출력. 
select a.emp_no, b.first_name
	from 	dept_emp a, employees b 
    where 	a.emp_no = b.emp_no
    and 	a.to_date = '9999-01-01'
    and 	dept_no = 'd004'; -- R3 = R1 실행 후 R2 실행 후 R3 실행해야 밑에 sol 2에 서브 쿼리랑 결과가 같음. 
    
-- sol 2 : 서브쿼리가 조건식에 들어간것임. where 절에 들어감. (단일 서브쿼리)
select a.emp_no, b.first_name
	from 	dept_emp a, employees b 
    where 	a.emp_no = b.emp_no
    and 	a.to_date = '9999-01-01'
    and 	dept_no = (	select dept_no 
							from 	dept_emp a, employees b
							where 	a.emp_no = b.emp_no
							and 	a.to_date = '9999-01-01'
							and 	concat(b.first_name, ' ', b.last_name) = 'Fai Bale');
                            
-- where 의 조건식에 서브쿼리를 사용하고 결과가 단일행인 경우,  
-- 조건 연산을 이런걸 할 수 있다:  =, !=, >, <, >=, <= 

-- 예제2.
-- 다중행인 경우 
-- 현재 전제 사원의 평균 연봉보다 적은 급여를 받는 사원의 리므, 급여를 출력하시오. 
select avg(salary)
	from salaires
    where to_date = '9999-01-01'; -- error: employees.salaires doesn't exist 
    
select *
	from 	salaries a, employees b
    where 	a.emp_no = b.emp_no
    and 	to_date = '9999-01-01'
    and 	a.salary < (select avg(salary)
	from salaires
    where to_date = '9999-01-01')
    order by a.salary desc;

-- where 의 조건식에 서브쿼리를 사용하고 결과가 다중행인 경우:  
-- in( not in)
-- any: =any (in 동일) 쓰지말라는 얘기가 있는데 데이터 작은 경우는 상관 없을 듯., >any, <>any, <any | != == <> | , <=any, >=any
-- all: =all, >all, <all, <>all (!=all, not in), <=all, >=all 

-- 예제3. 현재 급여가 50000 이상인 직원의 이름과 급여를 출력. 
-- join & subquery 둘다 가능
-- sol 1 = join 
select a.fist_name, b.salary
	from 	employees a, salaries b
    where 	a.emp_no = b.emp_no
    and 	b.to_date = '9999-01-01'
    and 	b.salary > 50000
    order by b. salary ;

-- sol 2 = subquery (멀티행, 멀티열)    두개 비교해야. 얘가 salary 가 이거다 로 계속 비교. 
select a.fist_name, b.salary
	from 	employees a, salaries b
    where 	a.emp_no = b.emp_no
    and 	b.to_date = '9999-01-01'
    and (a.emp_no, b.salary) in (select emp_no, salary from salaries where to_date = '9999-01-01' and salary > 50000)
order by b. salary ;

-- 위랑 아래랑 같은 거임. () 안에 있는 것 자체를 테이블로 본다 했을 경우 down below. 
-- from 절에도 넣을 수 있다! 
select a.fist_name, b.salary
	from 	employees a, (select emp_no, salary from salaries where to_date = '9999-01-01' and salary > 50000) b
    where 	a.emp_no = b.emp_no
    and 	b.to_date = '9999-01-01'
order by 	b.salary;

-- 예제 4. 현재 가장 적은 평균 급여의 직책과 그 평균급여를 출력하시오. 
-- 가장 적은 평균 급여 / 직책별로 평균 급여가 같다고 where 절에서 
select min(avg(salary)) from salaries where to_date ='9999-01-01'; -- error 남. Invalid use of group function. 
-- 이걸 어떻게? see down below
-- sol 1
select b.title, round(avg(salary)) as avg_salary -- 직책 때문에 필요. / 여기서 구한 소숫점 avg 랑 
	from 	salaries a, titles b
    where 	a.emp_no = b.emp_no
    and 	a.to_date ='9999-01-01'
    and	 	b.to_date = '9999-01-01'
group by b.title
having avg(salary) =(select min(avg_salary) -- 직책 없을 떄 
						from (
							select b.title, round(avg(salary) as avg_salary)
								from 	salaries a, titles b
								where 	a.emp_no = b.emp_no
								and 	a.to_date ='9999-01-01'
								and	 	b.to_date = '9999-01-01'
							group by b.title) a); -- result 결과가 안나올 수 잇음 . 여기서 구한 소숫점 avg 랑 다름. 소숫점까지 떨어지는데 위에 select 결과랑 괄호 안에 결과랑 소숫점이 다르면 불완전 처리로 round 처리해서 실수 처리를 해야한다. 

select min(avg_salary) -- 직책 없을 떄 
from (
select b.title, avg(salary) as avg_salary
	from 	salaries a, titles b
    where 	a.emp_no = b.emp_no
    and 	a.to_date ='9999-01-01'
    and	 	b.to_date = '9999-01-01'
group by b.title) a;

-- sol 2 : easy one. join 
select b.title, avg(salary) as avg_salary
	from 	salaries a, titles b
    where 	a.emp_no = b.emp_no
    and 	a.to_date ='9999-01-01'
    and	 	b.to_date = '9999-01-01'
group by b.title
-- order by avg_salary asc; -- 여러개 나오니까 이렇게 하지 말고 
order by avg_salary asc limit 0,1; -- 처음에서 부터 딱 1개만 빼옴. 0: 시작지점, 1: 빼오고 싶은 데이터 갯수 

-- 예제5. 현재, 각 부서별로 (from 절 섭쿼리로 해봐랏) 최고 급여를 받는 사원의 이름과 급여를 출력해 보세요. 
-- 힌트: 일단 부서별로 최고 급여를 구해야 함. if a부서 (dept_no) 최고 급여 (max_salary) 10원 b 는 20 c는 30 이라면 테이블 하나가 나오겠징? 
-- 힌트를 from 절에다 넣고, 
-- select emp_no, dept_no, salary from a,b,c( 이곳에서는 dept_no = abc dept_no, salary = abc min(salary) 
