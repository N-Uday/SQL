create database class_3;
use class_3;
create table UserActivity(
username varchar(6), activity varchar(10),
startDate date, endDate date);

insert into UserActivity values('Alice',' Travel','2020-02-12','2020-02-20'),('Alice',' Dancing','2020-02-21','2020-02-23'),
('Alice',' Travel','2020-02-24','2020-02-28'),('Bob','Travel','2020-02-11','2020-02-18');

with tmp as (select username,activity, startDate, endDate,
       dense_rank() over(partition by username order by startDate, endDate) as activity_num ,
       count(*) over( partition by username) as activity_count
       from UserActivity)
select username, activity, startDate, endDate
from tmp
where case when activity_count = 1 then 1
           when activity_num = 2 then 1
	  end = 1;
      
create table students(
id int, name varchar(10),
marks int) ;

insert into students values(1, 'Ashley', 81),(2, 'Samantha', 75),(4, 'Julia', 76),(3, 'Belvet', 84);

select name from students
where marks > 75
order by right(name,3), id;

create table employee(
employee_id int,name varchar(15),
months int, salary int);

INSERT INTO employee VALUES(12228, 'Rose', 15, 1968),(33645, 'Angela', 1, 3443),(45692, 'Frank', 17, 1608),
(56118, 'Patrick', 7, 1345),(59725, 'Lisa', 11, 2330),(74197, 'Kimberly', 16, 4372),
(78454, 'Bonnie', 8, 1771),(83565, 'Michael', 6, 2017),(98607, 'Todd', 5, 3396),(99989, 'Joe', 9, 3573);

select name from employee
where months < 10
and salary > 2000;

create table triangles(
a int, b int, c int);

insert into triangles values(20,20,23),(20,20,20),(20,21,21),(13,14,30);

select CASE
          When a + b < c or a + c < b or b + c < a then 'Not A Triangle'
          When a = b and b = c then 'Equilateral'
          When a = b  then 'Isosceles'
          else 'Scalene'
		end as diff_triangles
from triangles;
       
create table employees(
id int, name varchar(10),
salary int );

insert into employees values(1,'Kristeen', 1420),(2, 'Ashley', 2006),(3, 'Julia', 2210),(4, 'Maria', 3000);

SELECT CEIL(AVG(salary) - AVG(REPLACE(CAST(salary AS char), '0', ''))) as error_amount
FROM EMPLOYEES;


select concat(salary, ' ', count(salary) ) as output from  
                              (select max(salary * months) as salary 
                               from employee) as tmp
group by salary;

create table occupations(
name varchar(15), occupation varchar(10) );

insert into occupations values('Samantha', 'Doctor'),('Julia', 'Actor'),('Maria', 'Actor'),('Meera', 'Singer'),
   ('Ashely', 'Professor'),('Ketty', 'Professor'),('Christeen', 'Professor'),('Jane', 'Actor'),('Jenny', 'Doctor'),('Priya', 'Singer');

select concat(name,'(',left(occupation,1),')') Designation from occupations
order by name asc;

with val as ( select occupation, count(occupation) as occ_count from occupations
              group by occupation )
              
select concat('There are a total of ',occ_count,' ',lower(occupation),'s') as Occupations from val
order by occ_count asc;
              
WITH occupations_cte AS (
  SELECT concat(name, '(', left(occupation, 1), ')') AS Designation
  FROM occupations
  ORDER BY name ASC
),
val AS (
  SELECT occupation, count(occupation) AS occ_count
  FROM occupations
  GROUP BY occupation
)
SELECT Designation
FROM occupations_cte
UNION ALL
SELECT concat('There are a total of ', occ_count, ' ', lower(occupation), 's')
FROM val
ORDER BY Designation ASC;



 


