/* Name: Pedro Villaroman
   Login: pvillaro
   CSE 132A
   Project 1 
   */


.mode columns
.headers on
/* Part (a) */

/* Creating the database with the schema */

/*create table sailor (sname TEXT, rating INTEGER, PRIMARY KEY (sname));
create table boat (bname TEXT, color TEXT, rating INTEGER, PRIMARY KEY (bname));
create table reservation (sname NOT NULL, bname NOT NULL, day TEXT, 
 FOREIGN KEY(sname) references sailor, FOREIGN KEY(bname) references boat);
create table alldays (day VARCHAR(255));*/

/* Part (b) */
 
select * from sailor;
select * from boat;
select * from reservation;

/* Part (c) */

/* Number 1 */
--List all boats reserved on Wednesday and the color.
select b.bname, b.color
from boat b, reservation r
where b.bname = r.bname and r.day = 'Wednesday';

/* Number 2 */
--List the sailors with the highest rating
--part i using the MAX aggregate function
select s.sname
from sailor s
where s.rating = (select MAX(rating) from sailor);

--part ii not using the MAX function
select s.sname
from sailor s
where s.sname NOT IN (select a.sname from sailor a, sailor b where a.rating < b.rating);

/* Number 3 */

select DISTINCT a.sname, b.sname
from reservation a, reservation b
where a.day = b.day and a.sname <> b.sname and a.sname < b.sname;

/* Number 4 */

SELECT day, COUNT(CASE WHEN color = 'red' THEN 1 ELSE NULL END) as Num_Of_Red
from alldays natural left outer join 
	 reservation natural left outer join
	 (select * from boat where color = 'red')
group by day;

/* Number 5 */

select DISTINCT r.day
from reservation r
where r.day not in 
	(select r.day 
	 from reservation r, boat b 
	 where r.bname = b.bname and b.color <> 'red');

/* Number 6 */

select a.day
from alldays a
where NOT EXISTS 
	(select * from reservation r where r.day = a.day AND NOT EXISTS
		(select * from boat b where r.bname = b.bname and b.color <> 'red'));

/* Number 7 */

-- Using NOT IN
select DISTINCT r.day
from reservation r
where r.day NOT IN
	(select a.day
	 from reservation a, boat b
	 where b.color = 'red' and a.day NOT IN
	 	(select day from reservation where b.bname = bname));

-- Using NOT EXISTS
select a.day
from alldays a
where not EXISTS
	(select * from boat b
	 where b.color = 'red'
	 and not EXISTS
	 	(select * from reservation r
	 	 where r.day = a.day
	 	 and r.bname = b.bname));

-- Using COUNT aggregate functions
select a.day
from 
	(select r.day, COUNT(*) as Num_Red_Boats
	from reservation r, boat b
	where r.bname = b.bname and b.color = 'red'
	group by r.day) a
group by a.day
having a.Num_Red_Boats = 
	(select COUNT(*) as Total
	from boat b
	where b.color = 'red');

/* Number 8 */

select r.day, AVG( s.rating ) as Average
from reservation r, sailor s
where r.sname = s.sname
group by r.day;

/* Number 9 */

select MAX(day) as Most_Reservations from reservation;


/* Part e */

select r.sname, s.rating, r.bname, b.rating, r.day
from reservation r, boat b, sailor s
where r.sname = s.sname and r.bname = b.bname and s.rating < b.rating;


/* Part f */

-- Number 1
update reservation
set day = CASE when day = 'Wednesday' then 'Monday'
			   when day = 'Monday' then 'Wednesday'
			   when day = 'Sunday' then 'Sunday'
			   when day = 'Tuesday' then 'Tuesday'
			   when day = 'Thursday' then 'Thursday'
			   when day = 'Friday' then 'Friday'
			   when day = 'Saturday' then 'Saturday'
			   end;

-- Number 2
delete from reservation
where sname IN 
	(select r.sname from reservation r, boat b, sailor s
	 where r.sname = s.sname and r.bname = b.bname and s.rating < b.rating);

/* Part g */

select * from reservation;



