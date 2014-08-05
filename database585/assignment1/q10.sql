select m.email,m.fname,m.lname,NVL(f1.title,'NO PIC TAKEN') as Pic_Took_at,NVL(f1.total_pic_here,0) as Number_of_pics
from member1 m left outer join
                            (select f.sender,f.title,count(*) as total_pic_here
                            from
                                (select po.sender,a.code,a.post_id,a.title
                                from post po inner join 
                                                   ( select t.code,p.post_id,t.title
                                                    from tookat t inner join photo p on p.code=t.code) a on po.post_id=a.post_id) f
                            group by f.sender,f.title) f1 on f1.sender=m.email
group by m.email,m.fname,m.lname,NVL(f1.title,'NO PIC TAKEN'),NVL(f1.total_pic_here,0)
order by Number_of_pics desc,m.fname asc,m.lname asc
                  
