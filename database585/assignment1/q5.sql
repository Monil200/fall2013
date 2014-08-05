-----this is done confirmed
select main_t.email1 email1,main_t.email2 email2,main_t.comm_city as comm_city,main_t.comm_state as comm_state,main_t.comm_country as comm_country 
from 
(select addr.aid aid,addr.city as event_city,tab2.eventid as eventid,tab2.email1 email1,tab2.email2 email2,tab2.comm_city as comm_city,tab2.state as comm_state,tab2.country as comm_country
from address addr inner join
(select tab1.eventid as eventid,tab1.email1 email1,tab1.email2 email2,tab1.comm_city as comm_city,e.aid as aid,tab1.state,tab1.country
from event e inner join
(select i.eventid as eventid,a.email1 email1,a.email2 as email2,a.city as comm_city,a.state,a.country
from invited i inner join 
(select m1.email as email1,m2.email as email2,m1.city,m1.state,m1.country
    from member1 m1 inner join member1 m2
    on m1.city=m2.city
    where m1.email!=m2.email
    order by m1.city) a on a.email1=i.email
where email1 in (select email from invited where state='Going')
and email2 in (select email from invited where state='Going')) tab1 on e.title=tab1.eventid) tab2 on tab2.aid=addr.aid) main_t
where main_t.event_city!=main_t.comm_city
order by email1 asc,email2 asc