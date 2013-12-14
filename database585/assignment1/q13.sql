select m.email,m.fname,m.lname,NVL(final1.prvt_pics_of_frnd_vis,0) as PICS_VISIBLE
from member1 m left outer join 
(select email2,sum(pvt_pics_frnd_vis)+
                                    (select sum(c.no_of_pics_taken)
                                     from
                                    (select b.sender,sum(b.no_of_pics_taken) as no_of_pics_taken 
                                     from
                                     (select sender,a.no_of_pics_taken
                                     from post inner join 
                                     (select post_id,count(post_id) as no_of_pics_taken
                                     from photo
                                     group by post_id
                                      ) a on post.post_id=a.post_id
                                     where privacy=2) b
                                      group by b.sender) c
                                     )as prvt_pics_of_frnd_vis
from 
((select email2,sum(prvt_pics_of_frnd) as pvt_pics_frnd_vis
from
((select email2,sum(mut1.private_count_for_frnd_view) as prvt_pics_of_frnd
from 
              (select a.sender,count(a.sender) as private_count_for_frnd_view
              from photo p inner join
                                  (select sender,post_id
                                  from post
                                  where privacy=1
                                  group by sender,post_id) a on a.post_id=p.post_id
              group by a.post_id,a.sender) mut1 inner join friendship f on f.email1=mut1.sender 
              group by email2) union all  --main1 full outer join
(select email1,sum(mut2.private_count_for_frnd_view) as prvt_pics_of_frnd
from 
              (select a.sender,count(a.sender) as private_count_for_frnd_view
              from photo p inner join
                                  (select sender,post_id
                                  from post
                                  where privacy=1
                                  group by sender,post_id) a on a.post_id=p.post_id
              group by a.post_id,a.sender) mut2 inner join friendship f on f.email2=mut2.sender 
              group by email1)) fin --main2 on main1.email2=main2.email1 
              group by email2) union all---this is final
 
(select b.sender,sum(b.no_of_pics_taken) as pvt_pics_frnd_vis--no_of_pics_taken
    from
        (select sender,a.no_of_pics_taken,a.post_id
        from post inner join 
                            (select post_id,count(post_id) as no_of_pics_taken
                            from photo
                            group by post_id
                            ) a on post.post_id=a.post_id
                            where privacy!=2) b
group by b.sender)) fin1  
group by email2) final1 on m.email=final1.email2
order by NVL(final1.prvt_pics_of_frnd_vis,0) desc, m.fname asc, m.lname asc 