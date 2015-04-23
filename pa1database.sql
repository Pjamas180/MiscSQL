.mode columns
.headers on
/* Part (a) */

/* Creating the database with the schema */
create table sailor (sname TEXT, rating INTEGER, PRIMARY KEY (sname));
create table boat (bname TEXT, color TEXT, rating INTEGER, PRIMARY KEY (bname));
create table reservation (sname NOT NULL, bname NOT NULL, day TEXT, 
 FOREIGN KEY(sname) references sailor, FOREIGN KEY(bname) references boat);
create table alldays (day VARCHAR(255));

insert into sailor values ( 'Brutus', 1);
insert into sailor values ( 'Andy', 8);
insert into sailor values ( 'Horatio', 7);
insert into sailor values ( 'Rusty' , 8);
insert into sailor values ( 'Bob', 1);

insert into boat values ( 'SpeedQueen', 'white', 9);
insert into boat values ( 'Interlake', 'red', 8);
insert into boat values ( 'Marine', 'blue', 7);
insert into boat values ( 'Bay', 'red', 3);

insert into reservation values ( 'Andy', 'Interlake', 'Monday');
insert into reservation values ('Andy', 'Bay', 'Wednesday');
insert into reservation values ('Andy', 'Marine', 'Saturday');
insert into reservation values ('Rusty', 'Bay', 'Sunday');
insert into reservation values ('Rusty', 'Interlake', 'Wednesday');
insert into reservation values ('Rusty', 'Marine', 'Wednesday');
insert into reservation values ('Bob', 'Bay', 'Monday');

insert into alldays values ('Sunday');
insert into alldays values ('Monday');
insert into alldays values ('Tuesday');
insert into alldays values ('Wednesday');
insert into alldays values ('Thursday');
insert into alldays values ('Friday');
insert into alldays Values ('Saturday');

	/*select DISTINCT a.day as Most_Reservations
from 
	(select r.day, COUNT(r.day) as count
	from reservation r, alldays a
	where a.days = r.day
	group by r.day) a,
	(select r.day, COUNT(r.day) as count
	from reservation r, alldays a
	where a.days = r.day
	group by r.day) b
where a.day NOT IN (select c.day from 
		(select r.day, COUNT(r.day) as count
		from reservation r, alldays a
		where a.days = r.day
		group by r.day) c,
		(select r.day, COUNT(r.day) as count
		from reservation r, alldays a
		where a.days = r.day
		group by r.day) d
		where c.count < d.count);*/