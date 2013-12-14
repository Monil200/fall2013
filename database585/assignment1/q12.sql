select m.email,m.fname,m.lname,c.post_id,c.max_agg_comm_like,c.comments,c.likes
from member1 m inner join 
                          (select p.sender,main_max.comments,main_max.likes,main_max.max_agg_comm_like,main_max.post_id
                          from post p,(select a.post_id, NVL(comments_on_post,0)+NVL(likes_on_post,0) as max_agg_comm_like,NVL(comments_on_post,0) as comments,NVL(likes_on_post,0) likes
                                      from 
                                      (select post_id,count(post_id) as comments_on_post
                                      from post_comment
                                      group by post_id) a full outer join
                                      --order by count(post_id) desc
                                      (select post_id,count(post_id) as likes_on_post
                                      from post_like
                                      group by post_id) b on a.post_id=b.post_id
                                      group by (NVL(comments_on_post,0)+NVL(likes_on_post,0)),a.post_id,NVL(comments_on_post,0),NVL(likes_on_post,0)
                                      having NVL(comments_on_post,0)+NVL(likes_on_post,0)=                                                  --this will select max post_comm_like
                                                                                          (select max(tp.agg_comm_like)
                                                                                          from
                                                                                          (select max(NVL(comments_on_post,0)+NVL(likes_on_post,0)) as agg_comm_like
                                                                                          from 
                                                                                          (select post_id,count(post_id) as comments_on_post
                                                                                          from post_comment
                                                                                          group by post_id) a full outer join
                                                                                          --order by count(post_id) desc
                                                                                          (select post_id,count(post_id) as likes_on_post
                                                                                          from post_like
                                                                                          group by post_id) b on a.post_id=b.post_id
                                                                                          group by (NVL(comments_on_post,0)+NVL(likes_on_post,0))) tp)) main_max--this is only to get max poct_com_like if
                          where p.post_id=main_max.post_id) c 
on m.email=c.sender                                                                                                                           -- i dont do this then all posts with same highest agg will not be choosen.
                                                                                                                            --although this is not the case here
--order by agg_comm_like desc
