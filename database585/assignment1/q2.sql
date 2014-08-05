select member1.birthmonth,a.min_age as Min_age,b.max_age as Max_age,c.avg_age as Avg_age,a.Members_Born as Members_Born_in_Month
from member1,
                (select min(age) as min_age,birthmonth,count(*) as Members_Born
                from member1
                group by birthmonth) a,
                (select max(age) as max_age,birthmonth,count(*) as Members_Born
                from member1
                group by birthmonth) b,
                (select avg(age) as avg_age,birthmonth,count(*) as Members_Born
                from member1
                group by birthmonth) c 
where member1.birthmonth=a.birthmonth and member1.birthmonth=b.birthmonth and member1.birthmonth=c.birthmonth
group by member1.birthmonth,a.min_age,b.max_age,c.avg_age,a.Members_Born
order by Avg_age desc


                                               

