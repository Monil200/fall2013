create table address(
aid number(4),
street_no number(5),
street_address varchar2(50),
city varchar2(20),
state varchar2(20),
country varchar2(20),
zip number(8),
constraint addr_pk primary key (aid));

create table member1(
email varchar2(50),
fname varchar2(20),
lname varchar2(20),
birthdate date,
country varchar2(20),
state varchar2(20),
city varchar2(20),
age number(3),
birthmonth varchar2(9),
constraint mem_pk primary key (email));

create table page(
title varchar2(100),
p_type varchar2(15),
constraint page_pk primary key (title));

create table post(
post_id number(5),
note varchar2(200),
sender varchar2(50) constraint sender_nn not null,
receiver varchar2(50) constraint receiver_nn not null,
privacy number(1) constraint privacy_l not null,
datetime date,
constraint post_pk primary key (post_id),
constraint sender_fpk foreign key (sender) references member1(email) on delete cascade,
constraint receiver_fpk foreign key (receiver) references member1(email) on delete cascade);

create table post_comment(
post_id number(5),
text varchar2(200) not null,
email varchar2(50),
datetime date,
constraint post_id_fk foreign key (post_id) references post(post_id) on delete cascade,
constraint email_id_fk foreign key (email) references member1(email) on delete cascade); --PK is removed here

create table post_like(
post_id number(5),
email varchar2(50),
datetime date,
constraint post_like_fk foreign key (post_id) references post(post_id) on delete cascade,
constraint email_like_fk foreign key (email) references member1(email) on delete cascade);--no pk..pk is dropped..

create table photo(
code number(5),
post_id number(5),
datetime date,
constraint photo_pk primary key (code),
constraint photo_fk foreign key (post_id) references post(post_id) on delete cascade);


create table tookat(
code number(5),
title varchar2(100),
constraint tookat_pk primary key (code,title),
constraint tookat_code_fk foreign key (code) references photo(code) on delete cascade,
constraint tookat_title_fk foreign key (title) references page(title) on delete cascade);


create table watched(
movie_id varchar2(200),
email varchar2(50),
rating number(2),
constraint watched_pk primary key(movie_id,email,rating),
constraint w_id_fk foreign key (movie_id) references page(title) on delete cascade,
constraint w_email_fk foreign key (email) references member1(email) on delete cascade);


create table checkedin(
place_title varchar2(200),
email varchar2(50),
datetime date,
constraint chkin_pk primary key (place_title,email,datetime),
constraint chkin_email_fk foreign key (email) references member1(email) on delete cascade,
constraint chkin_title_fk foreign key (place_title) references page(title) on delete cascade);

--event has no PK
create table event(
title varchar2(100),
description varchar2(500),
aid number(4),
starttime date,
duration varchar(10),
constraint event_title_fk foreign key (title) references page(title) on delete cascade,
constraint event_aid_fk foreign key (aid) references address(aid) on delete cascade);


create table friendship(
email1 varchar2(50),
email2 varchar2(50),
ftype varchar(25),
constraint frienddship_pk primary key (email1,email2),
constraint f_email1_fk foreign key (email1) references member1(email) on delete cascade,
constraint f_email2_fk foreign key (email2) references member1(email) on delete cascade);

create table invited(
eventid varchar2(200),
email varchar2(50),
state varchar2(15),
constraint invited_pk primary key (eventid,email),
constraint event_fpk foreign key (eventid) references page(title) on delete cascade,
constraint event_email_fpk foreign key (email) references member1(email) on delete cascade);

create table place(
ptitle varchar2(200),
aid number(4),
pcategory varchar(20),
constraint place_title_fpk foreign key (ptitle) references page(title) on delete cascade,
constraint place_aid_fpk foreign key (aid) references address(aid) on delete cascade);

insert into address values(1,655,'W Jefferson','Los Angeles','CA','USA',90007);
insert into address values(2,12402,'Roosevelt AVE','Flushing','NY','USA',11368);
insert into address values(3,8446,'Melrose Pl','Los Angeles','CA','USA',90069);
insert into address values(4,1300,'E Main St','Alhambra','CA','USA',91801);
insert into address values(5,3607,'Trousdale Pkwy','Los Angeles','CA','USA',90089);
insert into address values(6,5757,'Wilshire Blvd','Los Angeles','CA','USA',90036);
insert into address values(7,1133,'N La Brea Ave','West Hollywood','CA','USA',90038);
insert into address values(8,3335,'S Figueroa St.','Los Angeles','CA','USA',90007);
insert into address values(9,2400,' Broadway','Santa Monica','CA','USA',90404);
insert into address values(10,1445,'South Lemon Street','Fullerton','CA','USA',92832);
insert into address values(11,2300,'Marine Drive','San Franscico','CA','USA',94129);
insert into address values(12,1,'Statue of Liberty National Monumentmore info','New York','NY','USA',10004);
insert into address values(13,2,'Griffith Park','Los Angeles','CA','USA',90027);
insert into address values(14,26101,'Magic Mountain Parkway','Valencia','CA','USA',91355);
insert into address values(15,1350,'Massachusetts Ave','Cambridge','MA','USA',2138);
insert into address values(16,405,'Hilgard Avenue','Los Angeles','CA','USA',90095);
insert into address values(17,77,'Massachusetts Ave','Cambridge','MA','USA',2139);
insert into address values(18,1890,'Shattuck Avenue','Berkeley','CA','USA',94709);


insert into member1(email,fname,lname,birthdate,country,state,city) values('angelina@csci585.edu','Angelina','Jolie','4-Jun-75','Uinted States','CA','Los Angeles');
insert into member1(email,fname,lname,birthdate,country,state,city) values('brad@csci585.edu','Brad','Pitt','18-Dec-63','Uinted States','OK','Shawnee');
insert into member1(email,fname,lname,birthdate,country,state,city) values('al@csci585.edu','Alfredo','Pacino','25-Apr-70','Uinted States','NY','New York City');
insert into member1(email,fname,lname,birthdate,country,state,city) values('steve@csci585.edu','Steve','Jobs','24-Feb-55','Uinted States','CA','Palo Alto');
insert into member1(email,fname,lname,birthdate,country,state,city) values('bill@csci585.edu','Bill','Gates','28-Oct-55','Uinted States','WA','Seattle');
insert into member1(email,fname,lname,birthdate,country,state,city) values('miley@csci585.edu','Miley','Cyrus','23-Nov-92','Uinted States','TN','Nashville');
insert into member1(email,fname,lname,birthdate,country,state,city) values('hope@csci585.edu','Hope','Solo','20-Jul-81','Uinted States','WA','Richland');
insert into member1(email,fname,lname,birthdate,country,state,city) values('andre@csci585.edu','Andre','Agassi','29-Apr-70','Uinted States','NV','Las Vegas');
insert into member1(email,fname,lname,birthdate,country,state,city) values('nelle@csci585.edu','Nelle','Lee','12-Sep-55','Uinted States','AL','Monroeville');
insert into member1(email,fname,lname,birthdate,country,state,city) values('jen@csci585.edu','Jennifer','Aniston','11-Feb-69','Uinted States','CA','Los Angeles');
insert into member1(email,fname,lname,birthdate,country,state,city) values('pit@csci585.edu','Pit','Sampras','12-Aug-71','Uinted States','MD','Potomac');
insert into member1(email,fname,lname,birthdate,country,state,city) values('josh@csci585.edu','Josh','Radnor','29-Jul-74','Uinted States','OH','Columbus');
insert into member1(email,fname,lname,birthdate,country,state,city) values('tom@csci585.edu','Tom','Cruise','3-Jul-62','Uinted States','NY','Syracuse');
insert into member1(email,fname,lname,birthdate,country,state,city) values('serina@usc.edu','Serena','Williams','26-Sep-81','Uinted States','MI','Saginaw');
insert into member1(email,fname,lname,birthdate,country,state,city) values('venus@csci585.edu','Venus','Williams','17-Jun-89','Uinted States','CA','Lynwood');
insert into member1(email,fname,lname,birthdate,country,state,city) values('fan@csci585.edu','Fan','Bingbing','16-Sep-81','China','Shandong','Qingdao');
insert into member1(email,fname,lname,birthdate,country,state,city) values('jay@csci585.edu','Jay','Chou','18-Jan-79','Taiwan','New Taipei','Linkou');
insert into member1(email,fname,lname,birthdate,country,state,city) values('jakie@csci585.edu','Jackie','Chan','7-Apr-54','Hong Kong','Victoria Peak','Victoria Peak');
insert into member1(email,fname,lname,birthdate,country,state,city) values('andy@csci585.edu','	Andy','Lau','27-Sep-61','Hong Kong','Tai Po','Tai Po');
insert into member1(email,fname,lname,birthdate,country,state,city) values('zzhang@csci585.edu','Zhang','Ziyi','9-Feb-79','China','Beijing','Beijing');
insert into member1(email,fname,lname,birthdate,country,state,city) values('haung@usc.edu','Haung','Xiaoming','13-Nov-77','China','Shandong','Qingdao');
insert into member1(email,fname,lname,birthdate,country,state,city) values('son@csci585.edu','Yeon-Jae','Son','28-May-94','S Korea','Seoul','Seoul');
insert into member1(email,fname,lname,birthdate,country,state,city) values('kim@csci585.edu','Soo-Hyun','Kim','16-Feb-88','S Korea','Seoul','Gangnam');
insert into member1(email,fname,lname,birthdate,country,state,city) values('urm@csci585.edu','Urmila','Matondkar','4-Feb-74','India','Maharashra','Mumbai');
insert into member1(email,fname,lname,birthdate,country,state,city) values('kamal@csci585.edu','Kamal','Hassan','7-Nov-54','India','Madras','Paramakudi');
insert into member1(email,fname,lname,birthdate,country,state,city) values('mani@csci585.edu','Manisha','Koirala','16-Aug-70','Nepal','Kathmandu','Kathmandu');
insert into member1(email,fname,lname,birthdate,country,state,city) values('niki@csci585.edu','Niki','Karimi','10-Nov-71','Iran','Tehran','Tehran');
insert into member1(email,fname,lname,birthdate,country,state,city) values('bbahram@csci585.edu','Bahram','Radan','28-Apr-79','Iran','Tehran','Tehran');
insert into member1(email,fname,lname,birthdate,country,state,city) values('had@csci585.edu','Hadis','Fouladvand','1-Jan-79','Iran','Tehran','Tehran');
insert into member1(email,fname,lname,birthdate,country,state,city) values('tina@csci585.edu','Tina',' Verma','22-Oct-92','India','Madras','Paramakudi');
insert into member1(email,fname,lname,birthdate,country,state,city) values('deena@csci585.edu','Deena','Gandhi','4-Feb-89','India','Maharashra','Mumbai');


insert into page values('The Shawshank Redemption (1994)','Movie');
insert into page values('The Godfather (1972)','Movie');
insert into page values('The Godfather: Part II (1974)','Movie');
insert into page values('Pulp Fiction (1994)','Movie');
insert into page values('University of Southern California','Place');
insert into page values('Harvard University','Place');
insert into page values('University of California, Los Angeles','Place');
insert into page values('Massachusetts Institute of Technology','Place');
insert into page values('University of California, Berkeley','Place');
insert into page values('Microsoft','Place');
insert into page values('Apple','Place');
insert into page values('Google','Place');
insert into page values('Yahoo','Place');
insert into page values('Amazon','Place');
insert into page values('Baja Fresh','Place');
insert into page values('Panda Express','Place');
insert into page values('Carl''s Jr','Place'); --imp
insert into page values('Mcdonalds','Place');
insert into page values('Yogurtland','Place');
insert into page values('Golden Gate','Place');
insert into page values('The statue of liberty','Place');
insert into page values('Hollywood sign','Place');
insert into page values('Shrine auditorium','Place');
insert into page values('6 flags magic mountain','Place');
insert into page values('Tailgate 13','Event');
insert into page values('Superbowl 13','Event');
insert into page values('NBAFinals 13','Event');
insert into page values('Oscars 13','Event');
insert into page values('US OPEN 13','Event');
insert into page values('Avatar (2009)','Movie');

insert into post values(1,'"What''s something that adults do that they shouldn''t do?""Punish kids. And war."','angelina@csci585.edu','angelina@csci585.edu',2,'14-Sep-13');
insert into post values(2,'"I''m from the Ivory Coast.""Why''d you come to America?"He formed his hands into two imaginary guns. "Too much boom boom," he said. "So I run."','angelina@csci585.edu','brad@csci585.edu',1,'14-Sep-13');
insert into post values(3,'"What was the happiest moment of your life?""Any time I wake up and nothing hurts."','brad@csci585.edu','al@csci585.edu',2,'14-Sep-13');
insert into post values(4,'"Everyone loves me. I go everywhere, and I don''t fight with nobody. If somebody''s yelling at me, I just keep walking. I''ve only been in one fight. I used to be a taxi driver."','nelle@csci585.edu','angelina@csci585.edu',1,'14-Sep-13');
insert into post values(5,'"I had this idea to make a portrait, and instead of filling it in with physical features, I filled it in with the verbs that each body part can do."','niki@csci585.edu','bbahram@csci585.edu',2,'14-Sep-13');
insert into post values(6,'"My dad is big and strong and lifts the heavy weights at the gym. He also is a fireman and he once saved eleven people."','bbahram@csci585.edu','had@csci585.edu',1,'14-Sep-13');
insert into post values(7,'"If you could give one piece of advice to a large group of people, what would it be?""Be optimistic."','had@csci585.edu','kamal@csci585.edu',2,'14-Sep-13');
insert into post values(8,'Today in microfashion...','kim@csci585.edu','son@csci585.edu',1,'14-Sep-13');
insert into post values(9,'"If you could give one piece of advice to a large group of people, what would it be?" "Enjoy it while it lasts."','zzhang@csci585.edu','zzhang@csci585.edu',0,'14-Sep-13');
insert into post values(10,'"I''m breaking out of my shell."','andy@csci585.edu','andre@csci585.edu',1,'14-Sep-13');


insert into post_comment values(1,'GREAT!','andre@csci585.edu','14-Sep-13');
insert into post_comment values(3,'GREAT!','andre@csci585.edu','14-Sep-13');
insert into post_comment values(5,'GREAT!','andre@csci585.edu','14-Sep-13');
insert into post_comment values(7,'GREAT!','andre@csci585.edu','14-Sep-13');
insert into post_comment values(1,'GREAT!','brad@csci585.edu','14-Sep-13');
insert into post_comment values(3,'AWESOME!','brad@csci585.edu','14-Sep-13');
insert into post_comment values(5,'AWESOME!','brad@csci585.edu','14-Sep-13');
insert into post_comment values(7,'AWESOME!','brad@csci585.edu','14-Sep-13');
insert into post_comment values(1,'AWESOME!','steve@csci585.edu','14-Sep-13');
insert into post_comment values(3,'AWESOME!','steve@csci585.edu','14-Sep-13');
insert into post_comment values(5,'AMAZING!','steve@csci585.edu','14-Sep-13');
insert into post_comment values(7,'AMAZING!','steve@csci585.edu','14-Sep-13');
insert into post_comment values(1,'AMAZING!','niki@csci585.edu','14-Sep-13');
insert into post_comment values(3,'AMAZING!','niki@csci585.edu','14-Sep-13');
insert into post_comment values(5,'AMAZING!','niki@csci585.edu','14-Sep-13');
insert into post_comment values(7,'AMAZING!','niki@csci585.edu','14-Sep-13');
insert into post_comment values(1,'REALLY?','haung@usc.edu','14-Sep-13');
insert into post_comment values(3,'REALLY?','haung@usc.edu','14-Sep-13');
insert into post_comment values(5,'REALLY?','haung@usc.edu','14-Sep-13');
insert into post_comment values(7,'REALLY?','haung@usc.edu','14-Sep-13');
insert into post_comment values(1,'REALLY?','kamal@csci585.edu','14-Sep-13');
insert into post_comment values(3,'REALLY?','kamal@csci585.edu','14-Sep-13');
insert into post_comment values(5,'COOL!','kamal@csci585.edu','14-Sep-13');
insert into post_comment values(5,'COOL!','kamal@csci585.edu','14-Sep-13');
insert into post_comment values(7,'COOL!','kamal@csci585.edu','14-Sep-13');
insert into post_comment values(2,'COOL!','al@csci585.edu','14-Sep-13');
insert into post_comment values(4,'COOL!','had@csci585.edu','14-Sep-13');
insert into post_comment values(6,'COOL!','angelina@csci585.edu','14-Sep-13');
insert into post_comment values(8,'COOL!','son@csci585.edu','14-Sep-13');
insert into post_comment values(10,'COOL!','jay@csci585.edu','14-Sep-13');
insert into post_comment values(2,'COOL!','nelle@csci585.edu','14-Sep-13');

insert into post_like values(1,'andre@csci585.edu','14-Sep-13');
insert into post_like values(3,'andre@csci585.edu','14-Sep-13');
insert into post_like values(5,'andre@csci585.edu','14-Sep-13');
insert into post_like values(7,'andre@csci585.edu','14-Sep-13');
insert into post_like values(1,'brad@csci585.edu','14-Sep-13');
insert into post_like values(3,'brad@csci585.edu','14-Sep-13');
insert into post_like values(5,'brad@csci585.edu','14-Sep-13');
insert into post_like values(7,'brad@csci585.edu','14-Sep-13');
insert into post_like values(1,'steve@csci585.edu','14-Sep-13');
insert into post_like values(3,'steve@csci585.edu','14-Sep-13');
insert into post_like values(5,'steve@csci585.edu','14-Sep-13');
insert into post_like values(7,'steve@csci585.edu','14-Sep-13');
insert into post_like values(1,'niki@csci585.edu','14-Sep-13');
insert into post_like values(3,'niki@csci585.edu','14-Sep-13');
insert into post_like values(3,'tina@csci585.edu','15-Sep-13');
insert into post_like values(7,'niki@csci585.edu','14-Sep-13');
insert into post_like values(1,'haung@usc.edu','14-Sep-13');
insert into post_like values(3,'haung@usc.edu','14-Sep-13');
insert into post_like values(5,'haung@usc.edu','14-Sep-13');
insert into post_like values(7,'haung@usc.edu','14-Sep-13');


insert into photo values(1,1,'13-Sep-13');
insert into photo values(2,1,'13-Sep-13');
insert into photo values(3,1,'13-Sep-13');
insert into photo values(4,2,'13-Sep-13');
insert into photo values(5,2,'13-Sep-13');
insert into photo values(6,3,'13-Sep-13');
insert into photo values(7,5,'13-Sep-13');
insert into photo values(8,4,'13-Sep-13');
insert into photo values(9,6,'13-Sep-13');
insert into photo values(10,6,'13-Sep-13');
insert into photo values(11,7,'13-Sep-13');
insert into photo values(12,8,'13-Sep-13');
insert into photo values(13,9,'13-Sep-13');
insert into photo values(14,9,'13-Sep-13');
insert into photo values(15,7,'13-Sep-13');
insert into photo values(16,6,'13-Sep-13');
insert into photo values(17,5,'13-Sep-13');
insert into photo values(18,4,'13-Sep-13');
insert into photo values(19,4,'13-Sep-13');
insert into photo values(20,3,'13-Sep-13');


insert into tookat values(1,'6 flags magic mountain');
insert into tookat values(2,'Hollywood sign');
insert into tookat values(3,'The statue of liberty');
insert into tookat values(4,'Shrine auditorium');
insert into tookat values(5,'Hollywood sign');
insert into tookat values(6,'6 flags magic mountain');
insert into tookat values(7,'Shrine auditorium');
insert into tookat values(8,'Golden Gate');
insert into tookat values(9,'The statue of liberty');
insert into tookat values(10,'6 flags magic mountain');
insert into tookat values(11,'Hollywood sign');
insert into tookat values(12,'Golden Gate');
insert into tookat values(13,'Hollywood sign');
insert into tookat values(14,'Hollywood sign');
insert into tookat values(15,'6 flags magic mountain');
insert into tookat values(16,'Baja Fresh');
insert into tookat values(17,'Yogurtland');
insert into tookat values(18,'Panda Express');
insert into tookat values(19,'Mcdonalds');
insert into tookat values(20,'Carl''s Jr');


insert into watched values('The Shawshank Redemption (1994)','angelina@csci585.edu',5);
insert into watched values('The Godfather (1972)','angelina@csci585.edu',5);
insert into watched values('The Godfather (1972)','bill@csci585.edu',9);
insert into watched values('The Godfather (1972)','jen@csci585.edu',8);
insert into watched values('The Godfather: Part II (1974)','bill@csci585.edu',7);
insert into watched values('The Godfather: Part II (1974)','angelina@csci585.edu',6);
insert into watched values('Pulp Fiction (1994)','angelina@csci585.edu',7);
insert into watched values('Pulp Fiction (1994)','bill@csci585.edu',8);
insert into watched values('Pulp Fiction (1994)','jen@csci585.edu',9);
insert into watched values('Pulp Fiction (1994)','urm@csci585.edu',8);
insert into watched values('Avatar (2009)','angelina@csci585.edu',5);
insert into watched values('Avatar (2009)','bill@csci585.edu',7);
insert into watched values('Avatar (2009)','jen@csci585.edu',8);
insert into watched values('Avatar (2009)','urm@csci585.edu',6);
insert into watched values('Avatar (2009)','niki@csci585.edu',6);


insert into checkedin values('6 flags magic mountain','andy@csci585.edu','14-Sep-13');
insert into checkedin values('6 flags magic mountain','hope@csci585.edu','14-Sep-13');
insert into checkedin values('6 flags magic mountain','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Amazon','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Amazon','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Apple','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Apple','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Baja Fresh','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Baja Fresh','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Baja Fresh','tom@csci585.edu','14-Sep-13');
insert into checkedin values('Baja Fresh','venus@csci585.edu','14-Sep-13');
insert into checkedin values('Carl''s Jr','al@csci585.edu','14-Sep-13');
insert into checkedin values('Carl''s Jr','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Carl''s Jr','niki@csci585.edu','14-Sep-13');
insert into checkedin values('Carl''s Jr','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Golden Gate','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Golden Gate','nelle@csci585.edu','14-Sep-13');
insert into checkedin values('Golden Gate','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Google','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Harvard University','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Harvard University','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Hollywood sign','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Hollywood sign','pit@csci585.edu','14-Sep-13');
insert into checkedin values('Hollywood sign','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Massachusetts Institute of Technology','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Massachusetts Institute of Technology','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Mcdonalds','bbahram@csci585.edu','14-Sep-13');
insert into checkedin values('Mcdonalds','bill@csci585.edu','14-Sep-13');
insert into checkedin values('Mcdonalds','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Mcdonalds','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Microsoft','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Microsoft','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Panda Express','angelina@csci585.edu','14-Sep-13');
insert into checkedin values('Panda Express','had@csci585.edu','14-Sep-13');
insert into checkedin values('Panda Express','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Panda Express','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Shrine auditorium','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Shrine auditorium','josh@csci585.edu','14-Sep-13');
insert into checkedin values('Shrine auditorium','pit@csci585.edu','15-Sep-13');
insert into checkedin values('The statue of liberty','hope@csci585.edu','14-Sep-13');
insert into checkedin values('The statue of liberty','jen@csci585.edu','14-Sep-13');
insert into checkedin values('The statue of liberty','pit@csci585.edu','15-Sep-13');
insert into checkedin values('University of California, Berkeley','hope@csci585.edu','14-Sep-13');
insert into checkedin values('University of California, Berkeley','pit@csci585.edu','15-Sep-13');
insert into checkedin values('University of California, Los Angeles','hope@csci585.edu','14-Sep-13');
insert into checkedin values('University of California, Los Angeles','pit@csci585.edu','15-Sep-13');
insert into checkedin values('University of Southern California','hope@csci585.edu','14-Sep-13');
insert into checkedin values('University of Southern California','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Yahoo','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Yahoo','pit@csci585.edu','15-Sep-13');
insert into checkedin values('Yogurtland','hope@csci585.edu','14-Sep-13');
insert into checkedin values('Yogurtland','jakie@csci585.edu','14-Sep-13');
insert into checkedin values('Yogurtland','miley@csci585.edu','14-Sep-13');
insert into checkedin values('Yogurtland','pit@csci585.edu','15-Sep-13');


insert into event values('Tailgate 13','Football ' ||chr(38) || ' Tailgate Tickets USC Trojans vs. UTAH Utes Saturday, October 26th. Join us for a tailgate three hours prior to kickoff',5,'26-Oct-13','2 Hours');
insert into event values('Superbowl 13','The Super Bowl is the annual championship game of the National Football League (NFL), the highest level of professional American football in the United States, culminating a season that begins in the late summer of the previous calendar year.',4,'15-Dec-13','4 Hours');
insert into event values('NBAFinals 13','The NBA Finals is the championship series of the National Basketball Association. The series was named the NBA World Championship Series until 1986.',3,'15_Jan_13','3 Hours');
insert into event values('Oscars 13','The Academy Awards, now officially known as The Oscars,[1] are a set of awards given annually for excellence of cinematic achievements. The Oscar statuette is officially named the Academy Award of Merit and is one of nine types of Academy Awards.',3,'11-Nov-13','5 Hours');
insert into event values('US OPEN 13','The United States Open Tennis Championships is a hardcourt tennis tournament which is the modern iteration of one of the oldest tennis championships in the world, the U.S. National Championship, for which men''s singles was first contested in 1881.',2,'10-Sep-13','14 Days');

insert into friendship values('angelina@csci585.edu','brad@csci585.edu','Family');
insert into friendship values('angelina@csci585.edu','al@csci585.edu','Close Friend');
insert into friendship values('angelina@csci585.edu','nelle@csci585.edu','Regular Friend');
insert into friendship values('angelina@csci585.edu','zzhang@csci585.edu','Regular Friend');
insert into friendship values('angelina@csci585.edu','niki@csci585.edu','Regular Friend');
insert into friendship values('brad@csci585.edu','nelle@csci585.edu','Close Friend');
insert into friendship values('brad@csci585.edu','hope@csci585.edu','Regular Friend');
insert into friendship values('brad@csci585.edu','haung@usc.edu','Regular Friend');
insert into friendship values('al@csci585.edu','angelina@csci585.edu','Regular Friend');
insert into friendship values('al@csci585.edu','andre@csci585.edu','Close Friend');
insert into friendship values('steve@csci585.edu','bill@csci585.edu','Close Friend');
insert into friendship values('steve@csci585.edu','tina@csci585.edu','Regular Friend');
insert into friendship values('serina@usc.edu','venus@csci585.edu','Family');
insert into friendship values('andre@csci585.edu','fan@csci585.edu','Regular Friend');
insert into friendship values('nelle@csci585.edu','had@csci585.edu','Regular Friend');
insert into friendship values('nelle@csci585.edu','jen@csci585.edu','Close Friend');
insert into friendship values('pit@csci585.edu','venus@csci585.edu','Close Friend');
insert into friendship values('josh@csci585.edu','jakie@csci585.edu','Regular Friend');
insert into friendship values('josh@csci585.edu','nelle@csci585.edu','Close Friend');
insert into friendship values('josh@csci585.edu','kamal@csci585.edu','Close Friend');
insert into friendship values('josh@csci585.edu','niki@csci585.edu','Regular Friend');
insert into friendship values('josh@csci585.edu','son@csci585.edu','Regular Friend');
insert into friendship values('serina@usc.edu','tom@csci585.edu','Regular Friend');
insert into friendship values('jay@csci585.edu','andy@csci585.edu','Regular Friend');
insert into friendship values('son@csci585.edu','tom@csci585.edu','Regular Friend');
insert into friendship values('urm@csci585.edu','kim@csci585.edu','Close Friend');
insert into friendship values('niki@csci585.edu','bbahram@csci585.edu','Close Friend');
insert into friendship values('niki@csci585.edu','had@csci585.edu','Close Friend');
insert into friendship values('bbahram@csci585.edu','tina@csci585.edu','Close Friend');
insert into friendship values('son@csci585.edu','kim@csci585.edu','Regular Friend');
insert into friendship values('deena@csci585.edu','mani@csci585.edu','Regular Friend');
insert into friendship values('miley@csci585.edu','pit@csci585.edu','Regular Friend');
insert into friendship values('jen@csci585.edu','jakie@csci585.edu','Regular Friend');
insert into friendship values('bbahram@csci585.edu','angelina@csci585.edu','Regular Friend');


insert into invited values('Oscars 13','angelina@csci585.edu','Maybe');
insert into invited values('US OPEN 13','jen@csci585.edu','Going');
insert into invited values('US OPEN 13','angelina@csci585.edu','Going');
insert into invited values('Oscars 13','niki@csci585.edu','Going');
insert into invited values('Oscars 13','bbahram@csci585.edu','Going');
insert into invited values('Superbowl 13','fan@csci585.edu','Going');
insert into invited values('Superbowl 13','haung@usc.edu','Going');
insert into invited values('NBAFinals 13','deena@csci585.edu','Going');
insert into invited values('NBAFinals 13','urm@csci585.edu','Going');
insert into invited values('Tailgate 13','mani@csci585.edu','Going');
insert into invited values('Tailgate 13','kim@csci585.edu','Going');
insert into invited values('Tailgate 13','jay@csci585.edu','Maybe');
insert into invited values('Tailgate 13','venus@csci585.edu','Not Going');
insert into invited values('Tailgate 13','tom@csci585.edu','Not Going');
insert into invited values('NBAFinals 13','tina@csci585.edu','Going');
insert into invited values('NBAFinals 13','kamal@csci585.edu','Not Going');
insert into invited values('NBAFinals 13','zzhang@csci585.edu','Maybe');
insert into invited values('Oscars 13','zzhang@csci585.edu','Maybe');
insert into invited values('US OPEN 13','venus@csci585.edu','Going');
insert into invited values('US OPEN 13','serina@usc.edu','Going');
insert into invited values('Oscars 13','serina@usc.edu','Not Going');
insert into invited values('Oscars 13','mani@csci585.edu','Maybe');
insert into invited values('Superbowl 13','had@csci585.edu','Maybe');
insert into invited values('Superbowl 13','son@csci585.edu','Maybe');
insert into invited values('NBAFinals 13','son@csci585.edu','Not Going');
insert into invited values('US OPEN 13','pit@csci585.edu','Going');


insert into place values('Yahoo',9,'Company');
insert into place values('Amazon',10,'Company');
insert into place values('Baja Fresh',6,'Restaurant');
insert into place values('Panda Express',5,'Restaurant');
insert into place values('Carl''s Jr',5,'Restaurant');
insert into place values('Mcdonalds',7,'Restaurant');
insert into place values('Yogurtland',8,'Restaurant');
insert into place values('Golden Gate',11,'Entertainment');
insert into place values('The statue of liberty',12,'Entertainment');
insert into place values('Hollywood sign',13,'Entertainment');
insert into place values('Shrine auditorium',1,'Entertainment');
insert into place values('6 flags magic mountain',14,'Entertainment');
insert into place values('University of Southern California',5,'Education');
insert into place values('Harvard University',15,'Education');
insert into place values('University of California, Los Angeles',16,'Education');
insert into place values('Massachusetts Institute of Technology',17,'Education');
insert into place values('University of California, Berkeley',18,'Education');
insert into place values('Microsoft',1,'Company');
insert into place values('Apple',2,'Company');
insert into place values('Google',3,'Company');





