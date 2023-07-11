create database class_2;
use class_2;
create table if not exists World(
name varchar(15),
continent varchar(10),
area int,
population int,
gdp bigint,
constraint pk primary key (name) 
);

insert into World values('Afghanistan','Asia',652230,25500100,20343000000),('Albania','Europe',28748,2831741,12960000000),
('Algeria','Africa',2381741,37100000,188681000000),('Andorra','Europe',468,78115,3712000000),
('Angola','Africa',1246700,20609294,100990000000);

select name,population,area from World
where area>=3000000 or population>=25000000;

create table if not exists Customer(
id int, name varchar(8), referee_id int,
primary key(id) );

insert into Customer values(1,'Will',null),(2,'Jane',null),(3,'Alex',2),(4,'Bill',null),
            (5,'Zack',1),(6,'Mark',2);

select name from Customer
where referee_id <> 2 or referee_id is null;
             -- Table - Customers
     create table if not exists Customers(
     id int, name varchar(5),
     primary key(id) );
     
     insert into Customers values(1,'Joe'),(2,'Henry'),(3,'Sam'),(4,'Max');
             -- Table - Orders
	 create table if not exists Orders(
     id int, customerId int,
     primary key(id),
     foreign key (customerId) references Customers(id) );
     
     insert into Orders values(1,3),(2,1);
     
     select name from Customers 
     where id not in (select customerId from Orders);
     
     create table if not exists Employee(
     employee_id int, team_id int,
     primary key(employee_id) );
     
     insert into Employee values(1,8),(2,8),(3,8),(4,7),(5,9),(6,9);
     
     select employee_id,count(team_id) over(partition by team_id) as team_size from Employee
     order by employee_id;
              -- Table - Person
     create table if not exists Person(
     id int, name varchar(10), phone_number varchar(11),
     primary key(id) );
     
     insert into Person values(3,'Jonathan','051-1234567'),(12,'Elvis','051-7654321'),(1,'Moncef','212-1234567'),
        (2,'Maroua','212-6523651'),(7,'Meir','972-1234567'),(9,'Rachel','972-0011100');
              -- Table - Country
     create table if not exists Country(
     name varchar(8), country_code varchar(3),
     primary key(country_code) );

     insert into Country values('Peru','051'),('Israel','972'),('Morocco','212'),('Germany','049'),('Ethiopia','251');
			  -- Table - Calls
	 create table if not exists Calls(
     caller_id int, callee_id int, duration int);
     
     insert into Calls values(1,9,33),(2,9,4),(1,2,59),(3,12,102),(3,12,330),(12,3,5),(7,9,13),(7,1,3),
                    (9,7,1),(1,7,7);
     
     SELECT c.name AS country FROM person p JOIN country c ON left(phone_number,3) = country_code 
     JOIN calls c ON p.id IN (c.caller_id, c.callee_id)
     GROUP BY co.name
     HAVING AVG(duration) > (SELECT AVG(duration) FROM calls);
 
     create table if not exists Activity(
     player_id int, device_id int,
     event_date date, games_played int,
     primary key(player_id,event_date) );
     
     insert into Activity values(1,2,'2016-03-01',5),(1,2,'2016-05-02',6),(2,3,'2017-06-25',1),
			(3,1,'2016-03-02',0),(3,4,'2018-07-03',5);
    
     select player_id,device_id from activity
     where event_date in (select min(event_date) over(partition by player_id) from Activity);
     
     create table if not exists Orderss(
     order_number int, customer_number int,
     primary key(order_number) );
     
     insert into Orderss values(1,1),(2,2),(3,3),(4,3);
     
     select customer_number,count(*) from Orderss
	 group by customer_number
	 having count(*)>=all(select count(customer_number) from orderss group by customer_number);
     
     create table if not exists Cinema(
     seat_id int not null auto_increment, free bool,
     primary key(seat_id) );
     
     insert into Cinema(free) values(1),(0),(1),(1),(1);
     
     select seat_id,rank() over(order by free range between current row and 0 following) from cinema;
     
	 select distinct t1.seat_id from cinema as t1 join cinema as t2
     on abs(t1.seat_id - t2.seat_id) = 1 and t1.free = 1 and t2.free = 1
     order by 1 ;
               -- Table - SalesPerson
     create table if not exists SalesPerson(
     sales_id int, name varchar(5), salary int,
     commission_rate int, hire_date varchar(10),
     primary key(sales_id) );
     set sql_safe_updates=0;
     show create table salesPerson;
     update SalesPerson set hire_date= date_format(hire_date,"%Y/%m/%d");
     
     insert into SalesPerson values(1,'Joh',100000,6,'4/1/2006'),(2,'Amy',12000,5,'5/1/2010'),(3,'Mark',65000,12,'12/25/2008'),
	 (4,'Pam',25000,25,'1/1/2005'),(5,'Alex',5000,10,'2/3/2007');
     
		    -- Table - Company
     create table if not exists Company(
     com_id int, name varchar(8), city varchar(10),
     primary key(com_id) );
     
     insert into company values(1,'RED','Boston'),(2,'ORANGE','New York'),(3,'YELLOW','Boston'),
        (4,'GREEN','Austin');

               -- Table - Orders
     create table if not exists Orderrs(
     order_id int, order_date varchar(10),
     com_id int, sales_id int, amount int,
     primary key(order_id),
     foreign key(com_id) references Company(com_id),
     foreign key(sales_id) references SalesPerson(sales_id) );
     
     insert into orderrs values(1,'1/1/2014',3,4,10000),(2,'2/1/2014',4,5,5000),(3,'3/1/2014',1,1,50000),
        (4,'4/1/2014',1,4,25000);
        
	 select name from salesPerson
     where sales_id not in (select sales_id from orderrs o join company c on o.com_id=c.com_id and o.com_id =1);

     create table if not exists Triangle(
     x int, y int, z int,
     primary key(x,y,z) );
     
     insert into Triangle values(13,15,30),(10,20,15);
     
     select * ,
	    case
            when ((x>y and x>z and y+z>x) or (y>x and y>z and x+z>y) or (z>x and z>y and x+y>z) )then 'Yes'
            else "No"
            end as "Traingle"
		from triangle;
     use class_2;
     create table if not exists Point(
     x int,
     primary key(x) );
     
     insert into Point values(-1),(0),(2);
     
     select min(abs(e.x-v.x)) as shortest from Point e,Point v 
	 where abs(e.x-v.x)<>0;
     
     create table if not exists ActorDirector(
     actor_id int, director_id int,
     timestamp int,
     primary key(timestamp) );
     
     insert into ActorDirector values(1,1,0),(1,1,1),(1,1,2),(1,2,3),(1,2,4),(2,1,5),(2,1,6);
          
     select actor_id,director_id from ActorDirector
     where actor_id=director_id
     group by director_id
     having count(actor_id)>=3;
     
           -- Table - Sales
	 create table if not exists Sales(
     sale_id int, product_id int, year int,
     quantity int, price int,
     primary key(sale_id ,year) );
     
     insert into Sales values(1,100,2008,10,5000),(2,100,2009,12,5000),(7,200,2011,15,9000);

            -- Table - Product
	 create table if not exists Product(
     product_id int, product_name varchar(8),
     primary key (product_id) );
     
     insert into Product values(100,'Nokia'),(200,'Apple'),(300,'Samsung');
     
     select p.product_name,s.year,s.price from Sales s join Product p on s.product_id=p.product_id;
              -- Table - Project
     create table if not exists Project(
     project_id int, employee_id int,
     primary key(project_id, employee_id) );
     
     insert into Project values(1,1),(1,2),(1,3),(2,1),(2,4);
     show tables;
		      -- Table - Employee
	 create table if not exists Employyee(
     employee_id int, name varchar(8),
     experience_years int,
     primary key(employee_id) );
     
     insert into Employyee values(1,'Khaled',3),(2,'Ali',2),(3,'John',1),(4,'Doe',2);
     
     select p.project_id,avg(e.experience_years) as average_years from Project p join Employyee e on
     p.employee_id=e.employee_id
     group by p.project_id;
                -- Table - Product
     create table if not exists Productt(
     product_id int, product_name varchar(6),
     unit_price int,
     primary key(product_id) );
     
     insert into Productt values(1,'S8',1000),(2,'G4',800),(3,'iPhone',1400);
     show tables;
                -- Table - Sales
	 create table if not exists Saless(
     seller_id int, product_id int,
     buyer_id int, sale_date date,
     quantity int, price int) ;
     
     insert into Saless values(1,1,1,'2019-01-21',2,2000),(1,2,2,'2019-02-17',1,800),
            (2,2,3,'2019-06-02',1,800),(3,3,4,'2019-05-13',2,2800);
      
	 select seller_id from saless group by seller_id
     having sum(price)>= All(select sum(price) over (partition by seller_id) from saless);
     
     select s.buyer_id from saless s join Productt p on s.product_id=p.product_id
     where p.product_id=1;
     show tables;
     create table if not exists Customerss(
     customer_id int, name varchar(8),
     visited_on date, amount int,
     primary key(customer_id,visited_on) );
     
     insert into Customerss values(1,'Jhon','2019-01-01',100),(2,'Daniel','2019-01-02',110),(3,'Jade','2019-01-03',120),
     (4,'Khaled','2019-01-04',130),(5,'Winston','2019-01-05',110),(6,'Elvis','2019-01-06',140),
     (7,'Anna','2019-01-07',150),(8,'Maria','2019-01-08',80),(9,'Jaze','2019-01-09',110),
     (1,'Jhon','2019-01-10',130),(3,'Jade','2019-01-10',150);
     
     
	 with tmp as (select distinct visited_on,sum(amount) over(order by visited_on range between Interval 6 Day preceding and 
                  current row)as amount from customerss)
	 select visited_on,amount,round(amount/7,2) as average_amount from tmp  t join 
     (SELECT MIN(visited_on) AS min_visited_on FROM customerss) AS b
     ON DATEDIFF(visited_on, min_visited_on) >= 6;
    
    with c1 as (select visited_on, sum(amount) as amount 
          from customerss group by visited_on),
	  c2 as  (select visited_on, sum(amount) as amount 
          from customerss group by visited_on) 
		select c1.visited_on, sum(c2.amount) as amount,round(avg(c2.amount),2) as average_amount from c1 join c2
    on datediff(c1.visited_on, c2.visited_on) between 0 and 6
	group by c1.visited_on
    having count(c2.amount) = 7
    order by c1.visited_on;

    create table if not exists Scores(
    player_name varchar(12), gender varchar(2),
    day date, score_points int,
    primary key(gender,day) );
    
    insert into Scores values('Aron','F','2020-01-01',17),('Alice','F','2020-01-07',23),
       ('Bajrang','M','2020-01-07',7),('Khali','M','2019-12-25',11),('Slaman','M','2019-12-30',13),
       ('Joe','M','2019-12-31',3),('Jose','M','2019-12-18',2),('Priya','F','2019-12-31',23),
       ('Priyanka','F','2019-12-30',17);
       
	select gender,day,
                 sum(score_points) over(partition by gender order by day) as total from Scores;
          use class_2;    
	create table logs(
    log_id int,
    primary key(log_id) );
    
    insert into logs values(1),(2),(3),(7),(8),(10);
    
    select a.*,b.* from logs a,logs b
    where a.log_id=b.log_id
    and b.log_id-a.log_id >=1;
    
    select min(log_id) as start_id,max(log_id) as end_id from
		   (select l.log_id, (l.log_id - l.row_num) as diff from 
                    (select log_id,row_number()over() as row_num from logs) l
		   ) l2        
    group by diff;
    
    select log_start.log_id as start_id, min(log_end.log_id) as End_id from
    (select log_id from logs where log_id - 1 not in (select * from Logs)) log_start,
    (select log_id from logs where log_id + 1 not in (select * from Logs)) log_end
    where log_start.log_id <= log_end.log_id
    group by log_start.log_id;
    -- Table - Students
    create table if not exists Students(
    student_id int, student_name varchar(8),
    primary key(student_id) );
    
    insert into Students values(1,'Alice'),(2,'Bob'),(13,'John'),(6,'Alex');
     
	-- Table - Subjects
    create table if not exists Subjects(
    subject_name varchar(12),
    primary key(subject_name) );
    
    insert into Subjects values('Math'),('Physics'),('Programming');
    
        -- Table - Examinations
	create table if not exists Examinations(
    student_id int,
    subject_name varchar(12) );
    
    insert into Examinations values(1,'Math'),(1,'Physics'),(1,'Programming'),(2,'Programming'),
      (1,'Physics'),(1,'Math'),(13,'Math'),(13,'Programming'),
      (13,'Physics'),(2,'Math'),(1,'Math');
      
	with tmp as (select s.student_id,s.student_name,st.subject_name,count(E.subject_name) as tot
    from Examinations E inner join subjects st on st.subject_name=e.subject_name 
    right join students s on e.student_id=s.student_id
    group by s.student_id,st.subject_name,s.student_name)
    
    select tmp.student_id,tmp.student_name,ifnull(tmp.subject_name,st.subject_name) as subject_name,tmp.tot as attended_marks from tmp,subjects st
    group by tmp.subject_name,tmp.student_id,subject_name,attended_marks;
    
    create table if not exists Employees(
    employee_id int, employee_name varchar(10), manager_id int,
    primary key(employee_id) );
    
    insert into employees values(1,'Boss',1),(3,'Alice',3),(2,'Bob',1),(4,'Daniel',2),
          (7,'Luis',4),(8,'Jhon',3),(9,'Angela',8),(77,'Robert',1);
          

select a.employee_id as EMPLOYEE_ID
from
    Employees as a
    left join
    Employees as b on a.manager_id = b.employee_id
    left join
    Employees as c on b.manager_id = c.employee_id
    left join
    Employees as d on c.manager_id = d.employee_id
where
    a.employee_id != 1
    and
    d.employee_id = 1;

select employee_id  from Employees where manager_id in
(select employee_id from Employees WHERE manager_id in
(select employee_id from Employees where manager_id =1))
and employee_id !=1;

create table if not exists Transactions(
id int,country varchar(2),
state enum('approved','declined'),
amount int,trans_date date,
primary key(id) );
select * from Transactions;

insert into transactions values(121,'US','approved',1000,'2018-12-18'),(122,'US','declined',2000,'2018-12-19'),
       (123,'US','approved',2000,'2019-01-01'),(124,'DE','approved',2000,'2019-01-07');

with tmp as (select count(*) as count,amount,country,date_format(trans_date,'%Y-%m') as `month`
             from transactions where state='approved'
              group by country,date_format(trans_date,'%Y-%m'),amount) ,      
	tmp_2 as 		(select  date_format(trans_date,'%Y-%m') as `month`,country,
              count(country) as trans_count,
              sum(t.amount) as trans_total_amount from transactions t
               group by `month`,country)
               
select tmp_2.`month`,tmp_2.country,tmp_2.trans_count,tmp.count,tmp_2.trans_total_amount,tmp.amount 
 from tmp inner join tmp_2 on tmp.`month`=tmp_2.`month` and tmp.country=tmp_2.country; 
 select year(trans_date) from transactions
 where year(trans_date)=2018;
 use Northwind;
 select year(o.OrderDate) as orderyear, month(o.OrderDate) as ordermonth,s.CompanyName,count(o.order_id) from orders o join shippers s on o.ShipVia=s.ShipperID
 where year(o.OrderDate)=1998
 group by orderyear,ordermonth,s.CompanyName
 
 order by orderyear,ordermonth,s.CompanyName;
 
 select employee_id,country from transactions,employees;
 select employee_id from employees;
 select country from transactions;
 show databases;
 use class_2;
 show tables;
 -- Table -- Actions
 create table Actions(
 user_id int, post_id int, action_date date,
 `action` enum('view','like','reaction','comment','report','share'),
 extra varchar(6));
 
 insert  into Actions values(1,1,'2019-07-01','view','null'),(1,1,'2019-07-01','like','null'),(1,1,'2019-07-01','share','null'),(2,2,'2019-07-04','view','null'),
                  (2,2,'2019-07-04','report','spam'),(3,4,'2019-07-04','view','null'),(3,4,'2019-07-04','report','spam'),(4,3,'2019-07-02','view','null'),
                  (4,3,'2019-07-02','report','spam'),(5,2,'2019-07-03','view','null'),(5,2,'2019-07-03','report','racism'),(5,5,'2019-07-03','view','null'),
                  (5,5,'2019-07-03','report','racism');
                  
 -- Table -- Removals
 create table Removals(
 post_id int, remove_date date,
 primary key(post_id) );
 
 insert into Removals values(2,'2019-07-20'),(3,'2019-07-18');

 
 select format(avg(tmp.deletes_per_day),0) as average_daily_percentage from (
 select (count(r.post_id)/count(a.post_id))*100 as deletes_per_day from actions a left join removals r on a.post_id = r.post_id 
 where a.extra = 'spam'
 group by action_date) tmp ;
 
 show tables;

 show create table activity;
 select * from activity;
 SET SQL_SAFE_UPDATES = 0;
 update activity set event_date = '2016-03-02' where event_date = '2016-05-02';
 
 select count(temp.tot)/count(distinct player_id) from activity ,
 (select t1.player_id as tot from activity t1,activity t2
 where datediff(t1.event_date,t2.event_date) =1 and t1.player_id = t2.player_id) temp
 ;
 
 with cte as (select count(t1.player_id) as tot from activity t1,activity t2
			 where datediff(t1.event_date,t2.event_date) =1 and t1.player_id = t2.player_id),
 cte_2 as   (select count(distinct player_id) as players from activity)
 
 select round(cte.tot/cte_2.players,2) as fraction from cte,cte_2;
 
 select count(t1.player_id)/tmp.tot from (select count(distinct player_id) as tot from activity) tmp, activity t1 join activity t2 on t1.player_id = t2.player_id
 where datediff(t1.event_date,t2.event_date) = 1
 group by tmp.tot;
 
 create table Salaries(
 company_id int , employee_id int ,
 employee_name varchar(15) , salary int,
 primary key(company_id, employee_id) );
 
 insert into Salaries values(1,1,'Tony',2000),(1,2,'Pronub',21300),(1,3,'Tyrrox',10800),(2,1,'Pam',300),
                  (2,7,'Bassem',450),(2,9,'Hermione',700),(3,7,'Bocaben',100),(3,2,'Ognjen',2200),
                  (3,13,'Nyan Cat',3300),(3,15,'Morning Cat',7777);

 select company_id , employee_id , employee_name,
	CASE 
       When salary < 1000 then  salary
       when salary  between 1000 and 10000 then round(salary - salary * 24/100,0)
       else round(salary - salary * 49/100,0)
	END as salary
 from salaries;
 -- Table - variables
 create table variables(
 name varchar(1) , value int,
 primary key(name) );
 
 insert into variables values ('x',66),('y',77);
 -- Table - expressions
 create table expressions(
 left_operand varchar(1), 
 operator enum('<','>','='),
 right_operand varchar(1),
 primary key (left_operand, operator, right_operand) );
 
 insert into expressions values('x','>','y'),('x','<','y'),('x','=','y'),('y','>','x'),('y','<','x'),('x','=','x');
 
 select e.*,v1.value,v2.value from expressions e  join variables v1 on e.left_operand = v1.name  join variables v2 on e.right_operand = v2.name
 where x >y;
 
 SELECT e.left_operand, e.operator, e.right_operand,
       if(CASE
         WHEN e.operator = '>' THEN (v1.value > v2.value)
         WHEN e.operator = '<' THEN (v1.value < v2.value)
         WHEN e.operator = '=' THEN (v1.value = v2.value)
       END,'true','false' )AS value
FROM Expressions e
JOIN Variables v1 ON e.left_operand = v1.name
JOIN Variables v2 ON e.right_operand = v2.name;

show create table calls;
select * from calls;
show tables;
update country set country_code = 49 where country_code = 049;

 select c.name from person p join country c on substr(p.phone_number,1,3) = c.country_code
 join calls ca on ca.caller_id = p.id
 group by c.name
 having avg(ca.duration) > (select avg(duration) from calls);
  select p.*,c.*,ca1.*,ca2.* from person p join country c on substr(p.phone_number,1,3) = c.country_code
 join calls ca1 on ca1.caller_id = p.id join calls ca2 on ca2.callee_id = p.id 
 group by c.name;
  select substr(phone_number,1,3) from person;
  
 SELECT cl.*,p.*,c.* 
FROM Calls AS cl
JOIN Person AS p ON cl.caller_id = p.id
JOIN Country AS c ON p.phone_number LIKE CONCAT('%', c.country_code, '-%')
GROUP BY c.name
HAVING AVG(cl.duration) > (SELECT AVG(duration) FROM Calls);

show tables;
create table employeds(
employee_id int, name varchar(15),
months int, salary int );

insert into employeds values(12228,'Rose',15,1968),(33645,'Angela',1,3443),(45692,'Frank',17,1608),(56118,'Patrick',7,1345),
              (59725,'Lisa',11,2330),(74197,'Kimberly',16,4372),(78454,'Bonnie',8,1771),(83565,'Michael',6,2017),
              (98607,'Todd',5,3396),(99989,'Joe',9,3573);

select name from employeds order by name;

create table user_transactions(
transaction_id int, product_id int,
spend double, transaction_date datetime);

insert into user_transactions values(1341, 123424, 1500.60, STR_TO_DATE('12/31/2019 12:00:00', '%m/%d/%Y %H:%i:%s')),
(1423, 123424, 1000.20, STR_TO_DATE('12/31/2020 12:00:00', '%m/%d/%Y %H:%i:%s')),
(1623, 123424, 1246.44, STR_TO_DATE('12/31/2021 12:00:00', '%m/%d/%Y %H:%i:%s')),
(1322, 123424, 2145.32, STR_TO_DATE('12/31/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));

select product_id, 
       spend as curr_year_spend, 
       lag(spend) over(order by transaction_date) as prev_year_spend,
       round((spend - lag(spend) over(order by transaction_date))*100/lag(spend) over(order by transaction_date),2) as yoy_rate 
       from user_transactions; 


create table amazon_inventory(
item_id int, item_type varchar(25),
item_category varchar(25), square_footage double);

insert into amazon_inventory values(1374,'prime_eligible','minirefrigerator',68.00),(4245,'not_prime','standing lamp',26.40),(2452,'prime_eligible','television',85.00),
                        (3255,'not_prime','side table',22.60),(1672,'prime_eligible','laptop',8.50);

with prime_tmp as (select floor((500000/sum(square_footage))) as std,sum(square_footage) as val
                   from amazon_inventory
				   where item_type = 'prime_eligible')
select item_type,
	Case 
		when item_type = 'prime_eligible' then p.std*count(item_type)
        when item_type = 'not_prime' then 
                       floor((500000 - (p.std*p.val))*count(item_type)/(sum(square_footage)))
	end as item_count
from amazon_inventory,prime_tmp p
group by item_type,p.std,p.val;

select * from amazon_inventory;
update amazon_inventory set item_category = 'mini refrigerator',item_type = 'prime_eligible' where item_category = 'refrigerator';
use class_2;
create table user_actions(
user_id int, event_id int,
event_type varchar(10), event_date datetime);

INSERT INTO user_actions VALUES 
(445,7765,'sign-in',STR_TO_DATE('05/31/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(742,6458,'sign-in',STR_TO_DATE('06/03/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(445,3634,'like',STR_TO_DATE('06/05/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(742,1374,'comment',STR_TO_DATE('06/05/2022 12:00:00', '%m/%d/%Y %H:%i:%s')),
(648,3124,'like',STR_TO_DATE('06/18/2022 12:00:00', '%m/%d/%Y %H:%i:%s'));

 with dir as (select user_id , extract(month from event_date) as mon from user_actions
 order by user_id)
 
 select a.mon , count(a.user_id) as monthly_active_users from dir a join dir b on a.user_id = b.user_id
 where a.mon - b.mon = 1
 group by a.mon;
 show databases;
 use class_2;
 create table search_frequency_table(
 searches int, num_users int);
 
 insert into search_frequency_table values(1,2),(2,2),(3,3),(4,1);
 select * from search_frequency_table;
  select 
        case 
            when tmp.n % 2 = 0 then round(((n/2)+(n/2+1))/2,1)
		    else n/2
		end as median
		from  (select count(num_users) as n from search_frequency_table ) as tmp;
  with recursive CTE_median as (
  select searches,num_users , 1 as temp from search_frequency_table 
  union all
  select searches , num_users , temp+1 from CTE_median where temp+1 <= num_users)        
  select round(avg(t.searches),1) as median from (
  select searches,row_number() over(order by searches,temp) as r1,
  row_number() over(order by searches desc,temp desc ) as r2 from CTE_median
  order by searches) t 
  where t.r1 in (t.r2,t.r2-1,t.r2 +1);
  
  use class_2;
  create table advertiser(
  user_id varchar(15),status varchar(15) );
  insert into advertiser values('bing','NEW'),('yahoo','NEW'),('alibaba','EXISTING');
  create table daily_pay(
  user_id varchar(10),paid decimal);
  insert into daily_pay values('yahoo',45.00),('alibaba',100.00),('target',13.00);
  
  select a.user_id,
		case 
            when a.status in ('NEW','EXISTING','RESURRECT') and paid is not null then 'EXISTING'
            else 'CHURN'
		END AS new_status
            from advertiser a left join daily_pay d on a.user_id = d.user_id;
            
   use class_2;
   create table server_utilization(
   server_id int, status_time timestamp,
   session_status varchar(5));
   
   insert into server_utilization values(1,STR_TO_DATE('08/02/2022 10:00:00', '%m/%d/%Y %H:%i:%s'),'start'),
              (1,STR_TO_DATE('08/04/2022 10:00:00', '%m/%d/%Y %H:%i:%s'),'stop'),
              (2,STR_TO_DATE('08/17/2022 10:00:00', '%m/%d/%Y %H:%i:%s'),'start'),
              (2,STR_TO_DATE('08/24/2022 10:00:00', '%m/%d/%Y %H:%i:%s'),'stop');
              
   select * from server_utilization;
  
  alter table server_utilization modify session_status varchar(5);
   
   show tables;
   
  create table transactions_new (
  transaction_id int, merchant_id int,
  credit_card_id int, amount int,
  transaction_timestamp datetime);
  
  insert into transactions_new values (1,101,1,100,str_to_date('09/25/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(2,101,1,100,str_to_date('09/25/2022 12:08:00','%m/%d/%Y %H:%i:%s')),
(3,101,1,100,str_to_date('09/25/2022 12:28:00','%m/%d/%Y %H:%i:%s')),
(4,102,2,300,str_to_date('09/25/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(6,102,2,400,str_to_date('09/25/2022 14:00:00','%m/%d/%Y %H:%i:%s'));

	
    SELECT COUNT(*) as payment_count
FROM ( SELECT *,
    lag(merchant_id) over(order by credit_card_id,transaction_timestamp) as prev_merchant,
    lag(transaction_timestamp) OVER (ORDER BY credit_card_id,transaction_timestamp) AS prev_datetime
  FROM transactions_new ) t
WHERE TIMESTAMPDIFF(MINUTE, t.prev_datetime, transaction_timestamp) between 1 and 10
and prev_merchant - merchant_id = 0;
-- GROUP BY FLOOR(TIMESTAMPDIFF(MINUTE, prev_datetime, transaction_timestamp) / 10);



select a.*,b.* from transactions_new a,transactions_new b
-- where a.credit_card_id = b.credit_card_id and a.merchant_id = b.merchant_id
where TIMESTAMPDIFF(MINUTE, a.transaction_timestamp, b.transaction_timestamp) <= 10
order by a.transaction_id
; 

select timestampdiff(month,'2023-08-12 12:08:00','2022-09-24 12:08:00');
use class_2;
-- Table - door_orders
create table door_orders(
order_id int, customer_id int,
trip_id int, status varchar(30),
order_timestamp timestamp );

insert into door_orders values(727424,8472,100463,'completed successfully',str_to_date('06/05/2022 09:12:00','%m/%d/%Y %H:%i:%s')),
(242513,2341,100482,'completed incorrectly',str_to_date('06/05/2022 14:40:00','%m/%d/%Y %H:%i:%s')),
(141367,1314,100362,'completed incorrectly',str_to_date('06/07/2022 15:03:00','%m/%d/%Y %H:%i:%s')),
(582193,5421,100657,'never_received',str_to_date('07/07/2022 15:22:00','%m/%d/%Y %H:%i:%s')),
(253613,1314,100213,'completed successfully',str_to_date('06/12/2022 13:43:00','%m/%d/%Y %H:%i:%s'));
 -- Table - trips
create table trips(
dasher_id int, trip_id int,
estimated_delivery_timestamp timestamp, actual_delivery_timestamp timestamp);

insert into trips values(101,100463,str_to_date('06/05/2022 09:42:00','%m/%d/%Y %H:%i:%s'),str_to_date('06/05/2022 09:38:00','%m/%d/%Y %H:%i:%s')),
(102,100482,str_to_date('06/05/2022 15:10:00','%m/%d/%Y %H:%i:%s'),str_to_date('06/05/2022 15:46:00','%m/%d/%Y %H:%i:%s')),
(101,100362,str_to_date('06/07/2022 15:33:00','%m/%d/%Y %H:%i:%s'),str_to_date('06/07/2022 16:45:00','%m/%d/%Y %H:%i:%s')),
(102,100657,str_to_date('07/07/2022 15:52:00','%m/%d/%Y %H:%i:%s'),null),
(103,100213,str_to_date('06/12/2022 14:13:00','%m/%d/%Y %H:%i:%s'),str_to_date('06/12/2022 14:10:00','%m/%d/%Y %H:%i:%s'));
 -- Table - door_customers
create table door_customers(
customer_id int, signup_timestamp timestamp);

insert into door_customers values(8472,str_to_date('05/30/2022 00:00:00','%m/%d/%Y %H:%i:%s')),
(2341,str_to_date('06/01/2022 00:00:00','%m/%d/%Y %H:%i:%s')),
(1314,str_to_date('06/03/2022 00:00:00','%m/%d/%Y %H:%i:%s')),
(1435,str_to_date('06/05/2022 00:00:00','%m/%d/%Y %H:%i:%s')),
(5421,str_to_date('06/07/2022 00:00:00','%m/%d/%Y %H:%i:%s'));

SELECT round((COUNT(CASE WHEN status <> 'completed successfully' THEN 1 ELSE NULL END)/count(*))*100,2) as tot
FROM door_orders o join door_customers c on o.customer_id = c.customer_id
where month(c.signup_timestamp) = 6;

show tables;
show create table person;

create table numbers(
num int, frequency int,
primary key (num) );

insert into numbers values(0,7),(1,1),(2,3),(3,1);

with recursive tmp as(
select num,frequency,1 as tag from numbers
union 
select num,frequency,tag+1 from tmp where tag < frequency
)
select round(sum(num)/2,0) as median from (select num,row_number() over(order by num) as r_num from tmp) as test
where r_num = (select count(*) from tmp)/2
or r_num = (select count(*) from tmp)/2 +1;

use class_2;
show tables;

create table salary(
id int, employee_id int,
amount int, pay_date date,
primary key(id),
foreign key (employee_id) references new_employee(employee_id) );

insert into salary values(8,1,9000,date_format('2017/03/31','%Y-%m-%d')),
(2,2,6000,'2017/03/31'),
(3,3,1000,'2017/03/31'),
(4,1,7000,'2017/02/28'),
(5,2,6000,'2017/02/28'),
(6,3,8000,'2017/02/28');

create table new_employee(
employee_id int, department_id int,
primary key(employee_id) );

insert into new_employee values(1,1),(2,2),(3,2);

with tmp as (select date_format(pay_date,"%Y-%m") as pay_month, department_id,
avg(amount) over(partition by month(pay_date) ) as  average_1,
avg(amount) over(partition by department_id order by month(pay_date) ) as average_2
from salary s join new_employee e on s.employee_id = e.employee_id) 
select pay_month,department_id,
       case 
           when average_2 > average_1 then 'higher'
           when average_2 < average_1 then 'lower'
           else 'same'
		end as comparision
	from tmp
group by pay_month,department_id,comparision;

show tables;
    select install_date as install_dt,
		   count(install_date) as installs,
    round(
        count(case when activity_date = DATE_ADD(install_date, interval 1 day) then player_id end) / COUNT(install_date),
        2
    ) as Day1_retention
from
    (select
        player_id,
        MIN(event_date) as install_date,
        case
        when max(event_date) = DATE_ADD(MIN(event_date), interval 1 day) then  max(event_date)
        else 0 
        end AS activity_date
    from
        Activity
    group by
        player_id) as subquery
group by
    install_date;
    
show tables;

-- Table - Players
create table players(
player_id int primary key,
group_id int) ;

insert into players(player_id, group_id) values(15,1),(25,1),(30,1),(45,1),(10,2),(35,2),(50,2),(20,3),(40,3);

-- Table - Matches
create table Matches(
match_id int primary key,
first_player int, second_player int,
first_score int, second_score int);

insert into Matches values(1,15,45,3,0),(2,30,25,1,2),(3,30,15,2,0),(4,40,20,5,2),(5,35,50,1,1);

select group_id, player_id
 from
 (SELECT group_id, player as player_id, points,
           ROW_NUMBER() OVER (PARTITION BY group_id ORDER BY points DESC, player ASC) AS row_num
from
(select group_id, first_player as player, sum(first_score) as points from Matches 
join players on player_id = first_player
group by group_id, first_player
union
select group_id, second_player as player, sum(second_score) as points from Matches
join players on player_id = second_player
group by group_id, second_player
) as tmp
) as result
where row_num = 1
order by group_id asc;

SELECT p.group_id, p.player_id
FROM Players p
INNER JOIN (
    SELECT 
           CASE 
               WHEN m.first_score > m.second_score THEN m.first_player
               WHEN m.first_score < m.second_score THEN m.second_player
               ELSE LEAST(m.first_player, m.second_player)
           END AS winner
    FROM Matches m
) AS winners ON p.group_id = winners.group_id AND p.player_id = winners.winner;

use class_2;
show tables;

-- Table - Student
create table student(
student_id int primary key,
student_name varchar(10) );

insert into student values(1,'Daniel'),(2,'Jade'),(3,'Stella'),(4,'Jonathan'),(5,'Will');

-- Table - Exam
create table exam(
exam_id int, student_id int,
score int,
primary key(exam_id, student_id) );

insert into exam values(10,1,70),(10,2,80),(10,3,90),(20,1,80),
      (30,1,70),(30,3,80),(30,4,90),(40,1,60),(40,2,70),(40,4,80);

SELECT s.student_id, s.student_name
FROM Student s
WHERE s.student_id IN (
    SELECT DISTINCT e.student_id
    FROM Exam e
    WHERE e.student_id NOT IN (
        SELECT DISTINCT student_id
        FROM Exam
        WHERE (exam_id, score) IN (
            SELECT exam_id, MIN(score)
            FROM Exam
            GROUP BY exam_id
            UNION
            SELECT exam_id, MAX(score)
            FROM Exam
            GROUP BY exam_id
        )
    )
)
ORDER BY s.student_id;

show tables;

-- Table - songs_history
create table songs_history(
history_id int, user_id int,
song_id int, song_plays int);

insert into songs_history values(10011, 777, 1238, 11),(12452, 695, 4520, 1);

-- Table - songs_weekly
create table songs_weekly(
user_id int, song_id int, 
listen_time datetime);

insert into songs_weekly values(777,1238,str_to_date('08/01/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(695,4520,str_to_date('08/04/2022 08:00:00','%m/%d/%Y %H:%i:%s')),
(125,9630,str_to_date('08/04/2022 16:00:00','%m/%d/%Y %H:%i:%s')),
(695,9852,str_to_date('08/07/2022 12:00:00','%m/%d/%Y %H:%i:%s'));


WITH all_song_list AS(
  SELECT sw.user_id, sw.song_id, count(*) as song_plays
  FROM songs_weekly sw 
  WHERE 
    STR_TO_DATE(listen_time,'%Y-%m-%d') <= STR_TO_DATE('08/04/2022','%m/%d/%Y')
  GROUP BY sw.user_id, sw.song_id
  UNION ALL
  SELECT sh.user_id, sh.song_id, sh.song_plays
  FROM songs_history sh
)
SELECT user_id, song_id, sum(song_plays) as song_plays
FROM  all_song_list
GROUP BY user_id,song_id
ORDER BY song_plays DESC;
show tables;

show databases;
use class_2;

show tables;

-- Table Emails
create table emails(
email_id int, user_id int,
signup_date datetime);

insert into emails values(125,7771,str_to_date('06/14/2022 00:00:00','%m/%d/%Y %H:%i:%s')),(236,6950,str_to_date('07/01/2022 00:00:00','%m/%d/%Y %H:%i:%s')),
              (433,1052,str_to_date('07/09/2022 00:00:00','%m/%d/%Y %H:%i:%s'));

create table texts(
text_id int, email_id int,
signup_action varchar(15) );

insert into texts values(6878,125,'Confirmed'),(6920,236,'Not Confirmed'),(6994,236,'Confirmed');

select round(sum(t.signup_action = 'Confirmed') / count(*), 2) as confirm_rate 
from texts t inner join emails e
on t.email_id = e.email_id;

create table tweets(
tweet_id int, user_id int,
tweet_date timestamp);

insert into tweets values(214252,111,str_to_date('06/01/2022 12:00:00','%m/%d/%Y %H:%i:%s')),(739252,111,str_to_date('06/01/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(846402,111,str_to_date('06/02/2022 12:00:00','%m/%d/%Y %H:%i:%s')),(241425,254,str_to_date('06/02/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(137374,111,str_to_date('06/04/2022 12:00:00','%m/%d/%Y %H:%i:%s'));

SELECT user_id,tweet_date,
  ROUND(AVG(COUNT(*)) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3days
FROM tweets
GROUP BY user_id,tweet_date;


SELECT user_id,tweet_date,
 count(*) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS rolling_avg_3days
FROM tweets
GROUP BY user_id,tweet_date;

create table activities(
activity_id int, user_id int, 
activity_type enum('send','open','chat'),
time_spent float,
activity_date datetime);

insert into activities values(7274,123,'open',4.50,str_to_date('06/22/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(2425,123,'send',3.50,str_to_date('06/22/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(1413,456,'send',5.67,str_to_date('06/23/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(1414,789,'chat',11.00,str_to_date('06/25/2022 12:00:00','%m/%d/%Y %H:%i:%s')),
(2536,456,'open',3.00,str_to_date('06/25/2022 12:00:00','%m/%d/%Y %H:%i:%s'));

create table age_breakdown(
user_id int, age_bucket enum('21-25','26-30','31-35') );

insert into age_breakdown values(123,'31-35'),(456,'26-30'),(789,'21-25');

select age_bucket,
  ROUND((send_time / (send_time + open_time)) * 100.0, 2) AS send_perc,
  ROUND((open_time / (send_time + open_time)) * 100.0, 2) AS open_perc
FROM (
  select ab.age_bucket,
    SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) AS send_time,
    SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) AS open_time
  FROM activities a
  JOIN age_breakdown ab ON a.user_id = ab.user_id
    where activity_type in ('open', 'send')
  GROUP BY ab.age_bucket
  order by ab.age_bucket
) AS breakdown;
 -- Talbe - personal_profiles
create table personal_profiles(
profile_id int, name varchar(20),
followers int );

insert into personal_profiles values(1,'Nick Singh', 92000),(2,'Zach Wilson', 199000),(3,'Daliana Liu', 171000),
(4,'Ravit Jain', 107000),(5,'Vin Vashishta', 139000),(6,'Susan Wojcicki', 39000);

 -- Talbe - employee_company
create table employee_company(
personal_profile_id int,
company_id int);

insert into employee_company values(1,4),(1,9),(2,2),(3,1),(4,3),(5,6),(6,5);

-- Talbe - company_pages
create table company_pages(
company_id int, name varchar(35),
followers int);

insert into company_pages values(1,'The Data Science Podcast',8000),(2,'Airbnb',700000),(3,'The Ravit Show',6000),
   (4,'DataLemur',200),(5,'YouTube',16000000),(6,'DataScience.Vin',4500),(9,'Ace The Data Science Interview',4479);


SELECT p.profile_id
FROM personal_profiles p
JOIN (
  SELECT personal_profile_id, MAX(followers) AS max_followers
  FROM employee_company ec
  JOIN company_pages cp ON ec.company_id = cp.company_id
  GROUP BY personal_profile_id
) AS tmp ON p.profile_id = tmp.personal_profile_id
WHERE p.followers > tmp.max_followers
ORDER BY p.profile_id ASC;


