 create or replace trigger member_age
 before
 insert on member1
 for each row
 declare
 begin
:new.age:=extract(year from current_timestamp)-extract(year from :new.birthdate);
:new.birthmonth:=to_char(:new.birthdate,'MONTH');
end; 
 