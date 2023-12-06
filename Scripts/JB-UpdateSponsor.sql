
select m.id, m."owner", m.username, m.jbid, m.spid, m.upid, "left", "right", m.deleted_at
from memberships m 
where username ilike 'dwikam1611181';

select m.id, m."owner", m.username, m.jbid, m.spid, m.upid, "left", "right", 
		(select username from memberships m2 where m2.upid = m.jbid order by m2.id asc limit 1) as "left", 
		(select username from memberships m3 where m3.upid = m.jbid order by m3.id desc limit 1) as "right", 
		m.deleted_at 
from memberships m 
where m.jbid = (select m4.jbid from memberships m4 where m4.username='enriad0311211');




UPDATE memberships m1
SET 
  "left"  = (select m2.jbid  from memberships m2 where m2.upid = m1.jbid order by m2.id asc limit 1),
  "right" = (select m3.jbid from memberships m3 where m3.upid = m1.jbid order by m3.id desc limit 1)
WHERE m1.username  in (
);

 
select * from memberships m where created_at >= '2023-11-19 20:25:00';

select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at 
from memberships m 
where upid = 23115556979;

--update memberships set username = replace(username, '-deleted-deleted', ''), deleted_at = null
-- HAPUS HU/HAK USAHA 2-7
select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at 
from memberships m 
where 
--username ilike 'marian01%' or 
--	jbid in ('23105493586')
username ='sitinu3011741' 
	or owner ='7430a88f-05b3-490b-9e0b-2303268f3c91'
--where m."left" is null and m."right" is null
order by id;

select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at 
from memberships m 
where "left" in (23105493586);



select * from sranks s 

/*
 * 
update memberships 
set "left" = null, "right" =null, username = concat(username, '-deleted'), deleted_at = now()
where username ='pinkir0110141' 
	or owner ='96867ffc-936f-46e7-a37e-d5dd1bf0b66a'
from memberships m 
*/


select * from memberships m where m.username ='mohammad171260';




DO $$ 
DECLARE
    xusername text := 'arwiti1911141';
    new_upline_username text := 'atmoja08053613';
    jbid_user bigint;
    jbid_upline bigint;

   BEGIN
	-- Find correct jbid for new sponsor
    SELECT jbid INTO jbid_user FROM memberships WHERE username = xusername;
    SELECT jbid INTO jbid_upline FROM memberships WHERE username = new_upline_username;
   
   	update memberships set upid = jbid_upline where username = xusername;
	update sranks set upid = jbid_upline where jbid = jbid_user;
  
    -- Display the values (you can replace this with your actual update statement)
    RAISE NOTICE 'Result: xusername = %, new_upline_username = %, jbid_upline = %', xusername, new_upline_username, jbid_upline;

END $$;


select id, jbid, spid, upid from memberships where username = 'arwiti1911141';
select id, jbid, spid, upid from sranks where jbid = 123234234;

select * from users u where nama ilike 'Mohammad Rasyid';
select * from memberships m where username like 'marian0110121%';
select * from memberships m where uid = '96867ffc-936f-46e7-a37e-d5dd1bf0b66a' or "owner" ='96867ffc-936f-46e7-a37e-d5dd1bf0b66a' order by id;


select * from users u where nama ilike 'Mohammad Rasyid';
SELECT id FROM users WHERE strpos('Mohammad Rasyid', nama) > 0;




/*

--@set var_name = 'John Doe'
@set var_name = (SELECT username FROM users WHERE username = 'atmoja08053613')
SELECT * FROM memberships m WHERE username  = :var_name;

-- UPDATE SPONSOR 
begin;
	
	-- Find correct jbid for new sponsor
	@set username = 'arwiti1911141'
	@set new_upline_username = 'atmoja08053613'
	@set jbid_upline = (SELECT jbid FROM memberships WHERE username = :new_upline_username)
    jbid_upline integer;

--	update memberships set upid = :jbid_upline where username = :username
	select :username, :new_upline_username, :jbid_upline; -- from memberships m where jbid = :jbid_upline;

--
--select id, username, jbid, spid, upid 
--from memberships m 
--where username in ('atmoja08053613','sitime2011581','mohamm120383') or jbid in (36077);
--
--select id, jbid, spid, upid  from sranks s where  jbid = 23115557679;



--	update user 

end;
/*
   
   
-- UPDATE NAME 
begin;
	
	WITH cte_param1 AS (
	    SELECT username as param1, 'test' as param2
	    FROM users
	    where username = 'arwiti1911141'
	)

	SELECT id, username, jbid, spid, upid  
	FROM memberships m 
	JOIN cte_param1 ON m.username = param1;


select id, username, jbid, spid, upid 
from memberships m 
where username in ('atmoja08053613','sitime2011581','mohamm120383') or jbid in (36077);

select id, jbid, spid, upid  from sranks s where  jbid = 23115557679;



--	update user 

end;
   
   
   
   
   
rollback;
begin;
-- define variable
@set old_username='arwiti1911141' 
@set old_name='arwiti1911141' 
@set new_name='Arwiti'
--@set new_username= 
--(select concat(substring(lower(replace(:new_name, ' ', '')) from 1 for 6), 
--		substring(username from 7 for LENGTH(username))) as new_username
--from users 
--where username = :old_name
--);
-- 'arwiti1911141'
@set param1 = (select username from users where username = 'rudiya1509631');

SELECT param1 INTO @result;
SELECT @result as param1, * FROM memberships m 
WHERE username = :param1;




--select current_setting('new_username') as new_usernamexx;

--select :new_username as new_usernamex, username, 
--		concat(substring(lower(replace(:new_name, ' ', '')) from 1 for 6), 
--		substring(username from 7 for LENGTH(username))) as new_username, 
--		:new_name as new_name, nama  
--from users 
----where username = :old_name;
--limit 1;

commit;

DO $$
DECLARE foo TEXT;
BEGIN
  foo := 'bar' ;
  SELECT foo;
END $$;


declare
	_username text := (select username from memberships m where username = 'arwiti1911141');
begin
	select nama, username from users u where username = _username;
end
/*
 * 
-- call variable
select :new_username, username, 
		concat(substring(lower(replace(:new_name, ' ', '')) from 1 for 6), 
		substring(username from 7 for LENGTH(username))) as new_username, 
		:new_name, nama  
from users 
where username = :new_username;
--update users set nama = 

-- UPDATE USERNAE
update users 
set nama = :new_name, 
	username = concat(
					  substring(lower(replace(:new_name, ' ', '')) from 1 for 6), 
					  substring(username from 7 for LENGTH(username))
					  )
where username = :old_username;

update membership
set username = concat(
					  substring(lower(replace(:new_name, ' ', '')) from 1 for 6), 
					  substring(username from 7 for LENGTH(username))
					  )
where username = :old_username;

 */

commit;
*/