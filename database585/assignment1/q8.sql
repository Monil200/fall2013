select a.email,fname,lname--,a.Total_places_visited
from member1 m inner join
(select email,count(distinct place_title) as total_places_visited
from checkedin
group by email
having count( distinct place_title)=(select count(ptitle) from place)) a on a.email=m.email 