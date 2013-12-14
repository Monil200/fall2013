select m.fname,m.lname
from member1 m inner join
(select a.email2 from 
((select email2
from friendship where email1='angelina@csci585.edu')
union
(select email1
from friendship where email2='angelina@csci585.edu')) a inner join
((select email2
from friendship where email1='niki@csci585.edu')
union
(select email1
from friendship where email2='niki@csci585.edu')) b on a.email2=b.email2) c on m.email=c.email2

--remove email
