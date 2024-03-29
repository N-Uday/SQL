create database class;
show databases;
show tables;
use class;
create table CITY(
ID int,
`NAME` VARCHAR(17),
COUNTRY_CODE VARCHAR(3),
DISTRICT VARCHAR(20),
POPULATION INT
);
alter table city modify column `NAME` VARCHAR(40);
SELECT * FROM CITY
WHERE COUNTRY_CODE='USA'
AND POPULATION>100000;

SELECT NAME FROM CITY
WHERE COUNTRY_CODE='USA'
AND POPULATION>100000;

select * from CITY
where id=1661;

SELECT * FROM CITY
WHERE COUNTRY_CODE='JPN		';

SELECT NAME FROM CITY
WHERE ID%2=0;

select sum(country_code)-sum(distinct country_code) from city;
CREATE TABLE STATION(
ID INT,
CITY VARCHAR(21),
STATE VARCHAR(2),
LAT_N INT,
LONG_W INT
);
SELECT count(CITY)-count(DISTINCT city) FROM STATION;	

SELECT LENGTH('UDAY')-LENGTH('ROH') AS LEN;
SELECT MIN(LENGTH(CITY)) AS LOW_LEN_CITY,CITY FROM STATION 
WHERE CITY=(SELECT LENGTH(CITY) AS LEN FROM STATION ORDER BY LEN DESC LIMIT 1)
GROUP BY CITY ;
SELECT CITY,LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC,CITY ASC;

SELECT CITY,LENGTH(CITY) FROM STATION 
WHERE CITY=(SELECT CITY FROM STATION ORDER BY length(CITY),CITY LIMIT 1)
OR CITY=(SELECT CITY FROM STATION ORDER BY length(CITY) DESC,CITY LIMIT 1);

-- select city from station
-- where city like ;

select distinct city from station 
where  substr(city,1,1) in ('a','e','i','o','u');

select distinct city from station 
where  substr(city,1,1) not in ('a','e','i','o','u');

SELECT DISTINCT city FROM station WHERE city  LIKE '[a,e,i,o,u]%'; -- AND city NOT LIKE '%[a,e,i,ou]';

SELECT DISTINCT CITY FROM STATION
WHERE  lower(LEFT(CITY, 1)) not IN ('a', 'e', 'i', 'o', 'u')
AND  lower(RIGHT(CITY, 1)) not IN ('a', 'e', 'i', 'o', 'u');
use class;
show tables;
CREATE TABLE PRODUCT(
product_id INT,
product_name varchar(30),
unit_price int,
constraint pk primary key(product_id)
);
Insert into product values(1,'S8',1000),(2,'G4',800),(3,'iPhone',1400);
CREATE TABLE SALES(
seller_id int,
product_id int,
buyer_id int,
sale_date date,
quantity int,
price int,
constraint fk foreign key(product_id) references product(product_id)
);
Insert into sales values(1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),(2,2,3,'2019-06-02',1,800),
                         (3,3,4,'2019-05-13',2,2800);

select p.product_id,p.product_name from product p,sales s where 
 s.sale_date between  2019-01-01 and 2019-03-31;
 
 select s.buyer_id,p.product_name from product p,sales s;
 
SELECT product_id, product_name FROM   product 
WHERE  product_id NOT IN (SELECT product_id FROM   sales 
                          WHERE  sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31');
SELECT product_id FROM   sales 
                          WHERE  sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31';
                          
select p.product_id, p.product_name
from Product p
left join Sales s
on p.product_id = s.product_id
group by p.product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date);
select p.product_id, p.product_name from product p,sales s
where p.product_id=s.product_id
group by p.product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date);

select sum(s.sale_date between '2019-01-01' and '2019-03-31') from sales s;
select count(s.sale_date) from sales s;
use class;
select product_id from product
where product_id not in (select product_id from sales 
                          where sale_date not between '2019-01-01' and  '2019-03-31');
select sum(s.sale_date between '2019-01-01' and '2019-03-31') from sales s;
select sum(s.sale_date not between '2019-01-01' and '2019-03-31') from sales s;
select count(s.sale_date) from sales s;
-- where sale_date in ('2019-01-01','2019-03-31');
select * from sales;
select product_id, count(s.sale_date) as su from sales s
group by product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date);

select s.product_id,s.sale_date from sales s,product p
where s.product_id=p.product_id
and sale_date between '2019-01-01' and '2019-03-31';
select p.product_id, p.product_name,s.sale_date from product p,sales s
where p.product_id=s.product_id
-- group by p.product_id 
;
select product_id from sales s
group by product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date);

select p.product_id,p.product_name from product p,sales s
where p.product_id=s.product_id
-- and sale_date between '2019-01-01' and '2019-03-31'
group by product_id
having sum(s.sale_date between '2019-01-01' and '2019-03-31') = count(s.sale_date);


create table views(
article_id int,
author_id int,
viewer_id int,
view_date date);

insert into views values(1,3,5,'2019-08-01'),(1,3,6,'2019-08-02'),(2,7,7,'2019-08-01'),(2,7,6,'2019-08-02'),
                         (4,7,1,'2019-07-22'),(3,4,4,'2019-07-21'),(3,4,4,'2019-07-21');
                
select * from views;
select distinct author_id as id from views
where author_id=viewer_id
order by id;

create table Delivery(
delivery_id int,
customer_id int,
order_date date,
customer_pref_delivery_date date);

insert into Delivery values(1,1,'2019-08-01','2019-08-02'),(2,5,'2019-08-02','2019-08-02'),(3,1,'2019-08-11','2019-08-11'),
						(4,3,'2019-08-24','2019-08-26'),(5,4,'2019-08-21','2019-08-22'),(6,2,'2019-08-11','2019-08-13');
                        
select round(avg(order_date=customer_pref_delivery_date)*100,2) from Delivery;

create table Ads(
ad_id int,
user_id int,
`action` enum('Clicked','Viewed','Ignored'),
constraint pk primary key(ad_id,user_id)
);

insert into Ads values(1,1,'Clicked'),(2,2,'Clicked'),(3,3,'Viewed'),(5,5,'Ignored'),(1,7,'Ignored'),(2,7,'Viewed'),
                       (3,5,'Clicked'),(1,4,'Viewed'),(2,11,'Viewed'),(1,2,'Clicked');
select ad_id,ifnull(Round(sum(action='Clicked')/(sum(action='Clicked')+sum(action='Viewed'))*100,2),0) as ctr from Ads
group by ad_id
order by ctr desc,ad_id asc;
select ad_id,count(action='Clicked') from Ads
group by ad_id;
select distinct ad_id,round(sum(action='Clicked'));
select distinct ad_id, ifnull(
        round(sum(action = 'Clicked') / (sum(action = 'Clicked') + sum(action = 'Viewed')) * 100, 2) , 0) as ctr
    from Ads
    group by ad_id
    order by ctr desc, ad_id;

create table if not exists Employee(
employee_id int,
team_id int,
constraint pk primary key(employee_id)
);

insert into Employee values(1,8),(2,8),(3,8),(4,7),(5,6),(6,9);

select employee_id,count(team_id)over(partition by team_id) from Employee
order by employee_id;
select count(team_id)over(partition by team_id) from employee;
select e.employee_id, (select count(team_id) from Employee where e.team_id = team_id) as team_size
from Employee e;

    -- Table-Countries  
create table if not exists Countries(
country_id int,
country_name varchar(10),
constraint pk primary key(country_id));
insert into Countries values(2,'USA'),(3,'Australia'),(7,'Peru'),(5,'China'),(8,'Morocco'),(9,'Spain');
    -- Table-Weather
create table if not exists Weather(
country_id int,
weather_state int,
`day` date,
constraint pk primary key(country_id,day));
insert into Weather values(2, 15, '2019-11-01'),
(2, 12, '2019-10-28'),(2, 12, '2019-10-27'),(3, -2, '2019-11-10'),(3, 00, '2019-11-11'),
(3, 03, '2019-11-12'),(5, 16, '2019-11-07'),(5, 18, '2019-11-09'),(5, 21, '2019-11-23'),
(7, 25, '2019-11-28'),(7, 22, '2019-12-01'),(7, 20, '2019-12-02'),(8, 25, '2019-11-05'),
(8, 27, '2019-11-15'),(8, 31, '2019-11-25'),(9, 07, '2019-10-23'),(9, 03, '2019-12-23');

select distinct c.country_name,
case
	when avg(w.weather_state)<=15 then 'Cold'
    when avg(w.weather_state)>=25 then 'Hot'
    else 'Warm'
end as weather_type
from Countries c inner join Weather w on c.country_id=w.country_id
where w.`day`  between '2019-11-01' and '2019-11-30'
group by c.country_name
order by weather_type;
      -- Table-Prices
create table if not exists Prices(
product_id int,
start_date date,
end_date date,
price int,
constraint pk primary key(product_id,start_date,end_date));
insert into Prices values(1,'2019-02-17','2019-02-28',5),(1,'2019-03-01','2019-03-22',20),
                          (2,'2019-02-01','2019-02-20',15),(2,'2019-02-21','2019-03-31',30);
	 -- Table-UnitsSold
create table if not exists UnitsSold(
product_id int,
purchase_date date,
units int) ;
insert into UnitsSold values(1,'2019-02-25',100),(1,'2019-03-01',15),
                          (2,'2019-02-10',200),(2,'2019-03-22',30);
                          
select p.product_id as product_id, units, price * units as prices_sum
            from Prices p inner join UnitsSold u
            on p.product_id = u.product_id where purchase_date between start_date and end_date;
            
create view pu as select p.product_id,units,price*units as price_each from Prices p inner join UnitsSold u on 
                      p.product_id=u.product_id and purchase_date between start_date and end_date;
select product_id, ifnull(round(sum(prices_sum) / sum(units), 2), 0) as average_price
    from (
        select p.product_id as product_id, units, price * units as prices_sum
            from Prices p left join UnitsSold u
            on p.product_id = u.product_id and purchase_date between start_date and end_date
    ) as temp
    group by product_id;
with tmp as (select p.product_id as product_id,units,price*units as tot_price from Prices p left join UnitsSold u
              on p.product_id =u.product_id and purchase_date between start_date and end_date)
select product_id,round(sum(tot_price)/sum(units),2) as average_price from tmp group by product_id;

create table if not exists Activity(
player_id int,
device_id int,
event_date date,
games_played int,
constraint pk primary key(player_id,event_date) );

insert into Activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);
select distinct player_id,min(event_date) over(partition by player_id order by event_date) from Activity ;
select player_id,min(event_date) from Activity group by player_id;

select player_id,device_id from Activity
where event_date in (select min(event_date) from Activity
                       group by player_id);
                       show tables;
         -- Table-Products                     
create table if not exists Products(
product_id int,
product_name varchar(30),
product_category varchar(10),
constraint pk primary key (product_id) );
insert into Products values (1,'Leetcode Solutions','Book'),(2,'Jewels of Stringology ','Book'),(3,'HP','Laptop'),
                             (4,'Lenovo','Laptop'),(5,'Leetcode Kit','T-shirt');
			-- Table-Orders
create table if not exists Orders(
product_id int,
order_date date,
unit int,
foreign key(product_id) references Products(product_id));
insert into Orders values (1, '2020-02-05', 60),(1, '2020-02-10', 70),(2, '2020-01-18', 30),(2, '2020-02-11', 80),
						  (3, '2020-02-17', 2 ),(3, '2020-02-24', 3 ),(4, '2020-03-01', 20),(4, '2020-03-04', 30),
                          (4, '2020-03-04', 60),(5, '2020-02-25', 50),(5, '2020-02-27', 50),(5, '2020-03-01', 50);
select product_name,unit from( select distinct p.product_id,product_name,sum(unit) as unit from Products p inner join Orders o 
                      on p.product_id=o.product_id and 
                      order_date between '2020-02-01' and '2020-02-29'
                      group by p.product_id,product_name
                      having sum(unit)>=100) as tmp;
create table if not exists Users(
user_id int,
name varchar(15),
mail varchar(25),
primary key (user_id) );
insert into Users values(1,'Winston','winston@leetcode.com'),(2,'Jonathan','jonathanisgreat'),(3,'Annabelle','bella-@leetcode.com'),
			(4,'Sally','sally.come@leetcode.com'),(5,'Marwan','quarz#2020@leetcode.com'),(6,'David','david69@gmail.com'),
            (7,'Shapiro','.shapo@leetcode.com');
select user_id,`name`,mail from Users
where REGEXP_LIKE(mail, '^[a-zA-Z][a-zA-Z0-9\_\.\-]*@leetcode.com');
      -- Table-Customers
create table if not exists Customers(
customer_id int,
name varchar(15),
country varchar(10),
primary key (customer_id) );
insert into Customers values(1,'Winston','USA'),(2,'Jonathan','Peru'),(3,'Moustafa','Egypt');
      -- Table-Product
create table if not exists Prod(
product_id int,
`description` varchar(15),
price int,
primary key(product_id) );
insert into Prod values(10,'LC Phone',300),(20,'LC T-Shirt',10),(30,'LC Book',45),(40,'LC Keychain',2);
      -- Table-Orders
create table if not exists `Order`(
order_id int,
customer_id int,
product_id int,
order_date date,
quantity int,
primary key (order_id) );
insert into `Order` values(1,1,10,'2020-06-10',1),(2,1,20,'2020-07-01',1),(3,1,30,'2020-07-08',2),(4,2,10,'2020-06-15',2),
             (5,2,40,'2020-07-01',10),(6,3,20,'2020-06-24',2),(7,3,30,'2020-06-25',2),(9,3,30,'2020-05-08',3);

select o.customer_id, c.name
from Customers c, Prod p, `Order` o
where c.customer_id = o.customer_id and p.product_id = o.product_id
group by o.customer_id
having 
(
    sum(case when o.order_date like '2020-06%' then o.quantity*p.price else 0 end) >= 100
    and
    sum(case when o.order_date like '2020-07%' then o.quantity*p.price else 0 end) >= 100
);
     -- Table-TVProgram
create table if not exists TVProgram(
program_date date,
content_id int,
channel varchar(15),
primary key (program_date,content_id) );

insert into TVProgram values('2020-06-10',1,'LC-Channel'),('2020-05-11',2,'LC-Channel'),('2020-05-12',3,'LC-Channel'),
            ('2020-05-13',4,'Disney Ch'),('2020-06-18',4,'Disney Ch'),('2020-07-15',5,'Disney Ch');
	-- Table-Content
create table if not exists Content(
content_id int,
title varchar(20),
kids_content enum('Y','N'),
content_type varchar(10),
primary key(content_id) );
insert into Content values(1,'Leetcode Movie','N','Movies'),(2,'Alg. for kids','Y','Series'),(3,'Database Sols','N','Series'),
              (4,'Aladdin','Y','Movies'),(5,'Cinderella','Y','Movies');

select distinct title from TVProgram t join Content c on t.content_id=c.content_id 
and t.program_date like '2020-06-%' and c.kids_content='Y';
      -- Table-NPV
create table if not exists NPV(
id int, `year` int, npv int,
primary key(id,`year`) );
insert into NPV values(1,2018,100),(7,2020,30),(13,2019,40),(1,2019,113),(2,2008,121),(3,2009,12),(11,2020,99),(7,2019,0);
     -- Table-Queries
create table if not exists Queries(
id int, `year` int,
primary key(id,`year`) );
insert into Queries values(1,2019),(2,2008),(3,2009),(7,2018),(7,2019),(7,2020),(13,2019);

select q.*,ifnull(n.npv,0) from NPV n right join Queries q on n.id=q.id and n.year=q.year;

show tables;
       -- Table - Employees
create table if not exists Employees(
id int, `name` varchar(10),
primary key (id) );

insert into Employees values(1,'Alice'),(2,'Bob'),(11,'Meir'),(90,'Winston'),(3,'Jonathan');
       -- Table -- EmployeeUNI
create table if not exists EmployeeUNI(
id int, unique_id int,
primary key(id,unique_id) );

insert into EmployeeUNI values(3,1),(11,2),(90,3);

select u.unique_id,e.name from Employees e left join EmployeeUNI u on e.id=u.id;

  -- Table - Users
create table if not exists `User`(
id int, name varchar(10),
primary key (id) );

insert into `User` values(1,'Alice'),(2,'Bob'),(3,'Alex'),(4,'Donald'),(7,'Lee'),(13,'Jonathan'),(19,'Elvis');

    -- Table - Rides
create table if not exists Rides(
id int, user_id int,  distance int,
primary key(id) );

insert into Rides values(1,1,120),(2,2,317),(3,3,222),(4,7,100),(5,13,312),(6,19,50),(7,7,120),(8,19,400),(9,7,230);

select distinct u.name,ifnull(sum(r.distance)over(partition by user_id),0) as travelled_distance from `User` u left join Rides r on u.id=r.user_id
order by travelled_distance desc,u.name;
show tables;
          -- Table - Movies
create table if not exists Movies(
movie_id int, title varchar(10),
primary key(movie_id) );

insert into Movies values(1,'Avengers'),(2,'Frozen 2'),(3,'Joker');

         -- Table - Users
create table if not exists Userss(
user_id int, name varchar(10),
primary key(user_id) );

insert into Userss values(1,'Daniel'),(2,'Monica'),(3,'Maria'),(4,'James');

		-- Table - MovieRating
create table if not exists MovieRating(
movie_id int, user_id int,
rating int, created_at date,
primary key (movie_id,user_id) );

insert into MovieRating values(1, 1, 3, '2020-01-12'),(1, 2, 4, '2020-02-11'),(1, 3, 2, '2020-02-12'),
   (1, 4, 1, '2020-01-01'),(2, 1, 5, '2020-02-17'),(2, 2, 2, '2020-02-01'),(2, 3, 2, '2020-03-01'),
   (3, 1, 3, '2020-02-22'),(3, 2, 4, '2020-02-25');

select user_name as results from
(
select u.name as user_name, COUNT(mr.user_id)  from MovieRating as mr
    join Userss as u
    on u.user_id = mr.user_id
    group by mr.user_id
    order by count(mr.user_id) desc, user_name asc limit 1
) first_one
Union
select title as results from( 
select m.title,sum(mr.rating) as rate from MovieRating mr join Movies m on mr.movie_id = m.movie_id
where created_at like '2020-02-%'
group by mr.movie_id
order by rate desc,m.title asc limit 1
) snd_one; 

     -- Table - Departments
create table if not exists Departments(
id int, name varchar(30),
primary key(id) );

insert into Departments values(1,'Electrical Engineering'),(7,'Computer Engineering'),(13,'Business Administration');
       -- Table - Students
create table if not exists Students(
id int, name varchar(15), department_id int,
primary key(id) );

insert into Students values(23,'Alice', 1),(1,'Bob', 7),(5,'Jennifer', 13),(2,'John',14),(4,'Jasmine', 77),
         (3,'Steve', 74),(6,'Luis', 1),(8,  'Jonathan', 7),(7,  'Daiana', 33),(11, 'Madelynn', 1);

select s.id,s.name from Students s
where department_id not in (select id from Departments);

create table if not exists Calls(
from_id int, to_id int, duration int);

insert into Calls values(1,2,59),(2,1,11),(1,3,20),(3,4,100),(3,4,200),(3,4,200),(4,3,499);

WITH caller as (
    select from_id as person1, to_id as person2, duration
    from Calls
    UNION ALL
    select to_id as person1, from_id as person2, duration
    from Calls
),

unique_caller as (
    select person1, person2, duration
    from caller
    where person1 < person2
)

select
    person1, person2, count(*) as call_count, sum(duration) as total_duration
from unique_caller
group by person1, person2;

select from_id as person1,to_id as person2,
    count(duration) as call_count, sum(duration) as total_duration
from (select * 
      from Calls 
      union all
      select to_id, from_id, duration 
      from Calls) t1
where from_id < to_id
group by person1, person2;
SELECT
    LEAST(from_id, to_id) as person1,
    GREATEST(from_id, to_id) as person2,
    COUNT(*) as call_count,
    SUM(duration) as total_duration
FROM Calls
GROUP BY 1, 2;
show tables;
        -- Table Warehouse
create table if not exists Warehouse(
name varchar(10), product_id int, units int,
primary key (name,product_id) );

insert into Warehouse values('LCHouse1', 1,1),('LCHouse1', 2,10),('LCHouse1', 3,5),('LCHouse2', 1,2),('LCHouse2', 2,2),
                    ('LCHouse3', 4,1);

        -- Table Products
create table if not exists Productss(
product_id int, product_name varchar(15),
width int, length int, height int,
primary key (product_id) );

insert into Productss values(1,'LC-TV',5,50,40),(2,'LC-Keychain',5,5,5),(3,'LC-Phone',2,10,10),(4,'LC-T-Shirt',4,10,20);

select w.name,sum(w.units*p.width*p.length*p.height) as volume 
from Warehouse w join Productss p on p.product_id=w.product_id 
group by w.name;
        
create table if not exists Saless(
sale_date date, fruit enum('apples','oranges'),
sold_num int,
primary key(sale_date,fruit) );

insert into Saless values('2020-05-01', 'apples ',10),('2020-05-01', 'oranges', 8),('2020-05-02', 'apples ',15),
        ('2020-05-02', 'oranges', 15),('2020-05-03', 'apples ',20),('2020-05-03', 'oranges', 0),
        ('2020-05-04', 'apples ',15),('2020-05-04', 'oranges', 16);

select a.sale_date, (a.sold_num - b.sold_num) as diff
from Saless a left join Saless b
on a.sale_date = b.sale_date
where a.fruit = 'apples' and b.fruit = 'oranges';

create table if not exists Activityy(
player_id int, devide_id int,
event_date date, games_played int,
primary key(player_id,event_date) );

insert into Activityy values(1,2,'2016-03-01',5),(1,2,'2016-03-02',6),(2,3,'2017-06-25',1),
     (3,1,'2016-03-02',0),(3,4,'2018-07-03',5);

with tmp as (select a.player_id from Activityy a left join Activityy b on a.player_id=b.player_id 
            where datediff(a.event_date,b.event_date)=-1)
select round(sum(t.player_id)/(select count(distinct player_id) from Activityy),2) as fraction from tmp t;

select sum(a.player_id)/(select count(distinct player_id) from Activityy) from Activityy a left join Activityy b on a.player_id=b.player_id 
where datediff(a.event_date,b.event_date)=-1;

show tables;
create table if not exists Employeee(
id int,name varchar(8),
department varchar(1), managetId int,
primary key (id) );

insert into Employeee values(101,'John', 'A', null),(102,'Dan', 'A', 101),(103,'James', 'A', 101),
     (104,'Amy', 'A', 101),(105,'Anne', 'A', 101),(106,'Ron', 'B', 101);

select Name from Employeee as t1 
join (select ManagetId from Employeee
    group by ManagetId
    having count(ManagetId) >= 5) as t2
on t1.Id = t2.ManagetId;
      -- Table - Student
create table if not exists Student(
student_id int, student_name varchar(4),
gender varchar(1),dept_id int,
primary key(student_id),
foreign key(dept_id) references Department(dept_id) );

insert into Student values(1,'Jack','M',1),(2,'Jane','F',1),(3,'Mark','M',2);

      -- Table - Department
create table if not exists Department(
dept_id int, dept_name varchar(15),
primary key(dept_id) );

insert into Department values(1,'Engineering'),(2,'Science'),(3,'Law');

select d.dept_name,count(s.dept_id) as student_number from Department d left join Student s on d.dept_id=s.dept_id
group by d.dept_id;
          -- Table - Customer
create table if not exists Customer(
customer_id int, product_key int);

insert into Customer values(1,5),(2,6),(3,5),(3,6),(1,6);
        
        -- Table - Product
create table if not exists Productt(
product_key int,
primary key (product_key) );

insert into Productt values (5),(6);

select customer_id from Customer
group by customer_id
having count(customer_id)=(select count(*) from Productt);
       -- Table Project
create table if not exists Project(
project_id int, employee_id int,
primary key(project_id,employee_id),
foreign key(employee_id) references Employyee(employee_id) );

insert into Project values(1,1),(1,2),(1,3),(2,1),(2,4);

		 -- Table Employee
create table if not exists Employyee(
employee_id int, name varchar(8),
experience_years int,
primary key (employee_id) );

insert into Employyee values(1,'Khaled',3),(2,'Ali',2),(3,'John',3),(4,'Doe',2);

select project_id,employee_id from
(
select
p.project_id,
e.employee_id,e.experience_years,
Rank() over (partition by project_id order by experience_years desc ) as rank_experience
from Project p join employyee e
on p.employee_id = e.employee_id
) as tmp
where rank_experience=1;
select p.project_id,e.employee_id,Rank() over(partition by project_id order by experience_years desc) as rank_exp from Project p join employyee e
on p.employee_id=e.employee_id;
show tables;
        -- 48 Table - Books
create table if not exists Books(
book_id int, name varchar(30), available_from date,
primary key(book_id) );

insert into Books values(1,"Kalila And Demna",'2010-01-01'),(2,"28 Letters",'2012-05-12'),
       (3,"The Hobbit",'2019-06-10'),(4,"13 Reasons Why",'2019-06-01'),(5,"The Hunger Games",'2008-09-21');
       
       -- 48 Table - Orders
create table if not exists Orderss(
order_id int, book_id int,
quantity int, dispatch_date date,
primary key(order_id),
foreign key(book_id) references Books(book_id) );

insert into Orderss values(1,1,2,'2018-07-26'),(2,1,1,'2018-11-05'),(3,3,8,'2019-06-11'),(4,4,6,'2019-06-05'),
     (5,4,5,'2019-06-20'),(6,5,9,'2009-02-02'),(7,5,8,'2010-04-13');
     
select book_id, name 
from books
where book_id not in (
    select book_id
    from Orderss 
    where (dispatch_date between date_sub('2019-06-23',interval 1 year) and '2019-06-23') 
      group by (book_id) 
     having sum(quantity) >= 10)
and 
    available_from < date_sub('2019-06-23', interval 1 month);


     -- 49. Table - Enrollments
create table if not exists Enrollments(
student_id int, course_id int, grade int,
primary key(student_id, course_id) );

insert into Enrollments values(2,2,95),(2,3,95),(1,1,90),(1,2,99),(3,1,80),(3,2,75),(3,3,82);

select student_id,course_id,grade from (select *,
                      dense_rank() over(partition by student_id order by grade desc,course_id asc) as ranks 
                      from Enrollments) as tmp
where ranks=1;
show tables;
     -- Table - Teams
create table if not exists Teams(
team_id int, team_name varchar(10),
primary key (team_id) );
	-- Table - Matches
create table if not exists Matches(
match_id int, host_team int, guest_team int,
host_goals int, guest_goals int,
primary key(match_id) );