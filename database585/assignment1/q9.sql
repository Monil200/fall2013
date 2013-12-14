
select m.email,m.fname,m.lname,tab1.post_count as max_pic_uploaded
from member1 m inner join
(select p.sender,sum(a.post_count) as post_count
from post p inner join
(select post_id,count(post_id) as post_count
from photo
group by post_id) a on a.post_id=p.post_id
group by p.sender) tab1 on tab1.sender=m.email
where tab1.post_count=(select max(tab2.post_count) from 
                                              (select p.sender,sum(a.post_count) as post_count
                                              from post p inner join
                                              (select post_id,count(post_id) as post_count
                                              from photo
                                              group by post_id) a on a.post_id=p.post_id
                                              group by p.sender) tab2)
                        


