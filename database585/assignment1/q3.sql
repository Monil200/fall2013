select m.email,m.fname,m.lname,NVL(tab2.family_member_count,0) as fmaily_member_count
from member1 m left outer join
(select tab1.email,sum(tab1.family_mem_count_1) as family_member_count
from 
((select m.email,count(f.ftype) as family_mem_count_1
from member1 m left outer join friendship f on m.email=f.email1
group by m.email,f.ftype,m.fname,m.lname
having f.ftype='Family')
union
(select m.email,count(f.ftype) as family_mem_count_2
from member1 m left outer join friendship f on m.email=f.email2
group by m.email,f.ftype,m.fname,m.lname
having f.ftype='Family')) tab1
group by tab1.email) tab2 on m.email=tab2.email
order by fmaily_member_count desc
