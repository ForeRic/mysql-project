-- pet table 생성
create table pets(
name varchar (20),
owner varchar(20),
species varchar(1),
birth date,
death date
);

-- table scheme 확인
desc pets;

-- insert
insert
	into pets 
values ('성탄이','kickscar','dog','m','2010-12-25',null);

insert
	into pets(owner,name, species, gender, birth)
values ('kickscar', 'choco', 'cat', 'm', '2015-01-01');


-- select
select * from pets;

select name, birth from pets order by birth desc;

select count(*) from pets; 
select count(*) from pets where death is not null;

-- update(U)
update pets
	set species = 'monkey'
where name = 'choco';

-- delete(D)

delete 
	from pets 
 where death is not null;
