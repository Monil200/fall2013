select tab2.email,tab2.fname,tab2.lname,NVL(tab2.going_count,0) as going_count,NVL(c.not_going_Count,0) as not_going_count,NVL(tab2.maybe_count,0) as maybe_count
from 
(select tab1.email,tab1.fname,tab1.lname,tab1.maybe_count as maybe_count,b.going_count as going_count
from 
(select m.email,m.fname,m.lname,a.maybe_count as maybe_count
from member1 m left outer join
(select i.email,count(*) as maybe_count
from invited i
where i.state='Maybe'
group by i.state,i.email) a on m.email=a.email) tab1 left outer join 
                                                                      (select i.email,count(*) as going_Count
                                                                      from invited i
                                                                      where i.state='Going'
                                                                      group by i.state,i.email) b on b.email=tab1.email) tab2 left outer join 
                                                                                                                                            (select i.email,count(*) as not_going_Count
                                                                                                                                            from invited i
                                                                                                                                            where i.state='Not Going'
                                                                                                                                            group by i.state,i.email) c on
                                                                                                                                            c.email=tab2.email
order by tab2.going_count desc, c.not_going_count desc,tab2.maybe_count desc
--order
