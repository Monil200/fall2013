select t.code,t.title as title_of_top_5_popular_places
from tookat t
where t.title in (select a.place_title
                  from (select place_title,count(*) as checkedin_count
                        from checkedin
                        group by place_title
                        order by count(*) desc) a
                  where rownum<=5)
order by t.title asc