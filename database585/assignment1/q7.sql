select m.email,m.fname,m.lname,b.rating as Rating_greater_than_avg_rating,c.avg_rating--,c.movie_id
from member1 m inner join
(select w.rating,w.email 
from watched w,
(select movie_id,count(*) as times_watched,avg(rating) as avg_rating
from watched
group by movie_id--to get movie_times watched
having count(*)=(select max(count(*)) from watched group by movie_id)) a--to get movie watched max times
where w.rating>=a.avg_rating and w.movie_id=a.movie_id) b on m.email=b.email,
(select movie_id,count(*) as times_watched,avg(rating) as avg_rating
from watched
group by movie_id--to get movie_times watched
having count(*)=(select max(count(*)) from watched group by movie_id)) c
order by m.fname,m.lname--to get user with hig rating than avg.)

