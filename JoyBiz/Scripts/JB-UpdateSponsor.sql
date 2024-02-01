
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
select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at, created_at
from memberships m 
where 
--username ilike 'marian01%' or 
--	jbid in ('23105493586')
username ilike 'annaas2201361' 
--	or owner ='48057484-e096-4dc2-91f2-630850669e61'
	or jbid in (24015633590,24015633590)
	or "left" = 24015633344 or "right" = 24015633344
--where m."left" is null and m."right" is null
order by id;

/*  ==================================================================================================================================
 *  START UPDATE HAPUS HU
 *  ==================================================================================================================================
 */

DO $$ 
DECLARE
	row_id integer;
    xusername text := 'henimi2201601';
    xowner text;
    add_username text := '-delete';

   BEGIN
		row_id := 1;
		
		-- UPDATE HU
		update memberships 
		set username = concat(username, add_username), deleted_at = now()
		where username in (
			select m.username
			from memberships m
				 left outer join users u on u.username = m.username
			where m.username ilike xusername ||'%' and m.username is not null and u.username is null
		);
	
	
--	UPDATE HU 1 left & right
--	update memberships 
--	set "left" = case when (select position('-delete' in m2.username) from memberships m2 where m2.jbid = memberships."left") > 0 then null else memberships."left" end,
--		"right" = case when (select position('-delete' in m2.username) from memberships m2 where m2.jbid = memberships."right") > 0 then null else memberships."right" end
--	where username = 'pardi3012521';

END $$;

/*  ==================================================================================================================================
 *  END UPDATE HAPUS HU
 *  ==================================================================================================================================
 */



/*
 * 
update memberships 
set "left" = null, "right" =null, username = concat(username, '-deleted'), deleted_at = now()
where username ='pinkir0110141' 
	or owner ='96867ffc-936f-46e7-a37e-d5dd1bf0b66a'
from memberships m 
*/


select username, jbid, spid, upid, "left", "right" 
from memberships m 
where m.username in ('novaro1811921', 'aidils0710981');

select * from sranks m where m.jbid in (23125605298,24015633344,24015633590);




DO $$ 
DECLARE
    xusername text := 'aidils0710981';
    new_upline_username text := 'novaro1811921';
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
select * from memberships m where username = 'sukart010728';

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

*/
select * 
from memberships m 
where m.username in ('nyoman300763',
'nobell050130',
'luhary1805341',
'dayuka050191',
'niputu061072');

-- check G1 & SC
select d1."LEVEL", d1.flag, count(d1."LEVEL") as "total"
from 
	(
		select 
			case 
				when m.spid = 40061 and m.flag =1 then 'G1-JB'
				when m.spid = 40061 and m.flag =2 then 'G1-SC'
				else 'JOYBIZER'
			end as "LEVEL",
--			(
--				select sum(t.pv_total) as pv
--				from "transaction" t 
--				where m.jbid = t.id_cust_fk 
--					and t.status in('PC', 'S', 'A', 'I') -- PAID
--					and to_char(t.transaction_date, 'YYYY-MM') between '2023-09' and '2023-12'
--			) as pv,
			m.flag, m."owner", m.username, m.jbid, m.spid, m.upid, m."left", m."right", m.deleted_at, m.created_at
		from memberships m 
		where m.username = 'sukart010728'
			 or m.spid = 40061
		group by m.flag, m."owner", m.username, m.jbid, m.spid, m.upid, m."left", m."right", m.deleted_at, m.created_at
		order by m.flag
	) d1
group by d1."LEVEL", d1.flag
;

select m.username, to_char(t.transaction_date, 'YYYY-MM') as "Period", sum(t.pv_total) as pv,
		(select count(*) from memberships m2 where m2.spid = m.jbid and m2.flag = 1) as "G1",
		(select count(*) from memberships m2 where m2.spid = m.jbid and m2.flag = 2) as "SC"
from memberships m
	 join "transaction" t on m.jbid = t.id_cust_fk 
where m.username = 'sukart010728'
	and t.status in('PC', 'S', 'A', 'I') -- PAID
	and to_char(t.transaction_date, 'YYYY-MM') between '2023-09' and '2023-12'
group by m.username, to_char(t.transaction_date, 'YYYY-MM'), m.jbid
order by to_char(t.transaction_date, 'YYYY-MM')
;

select * from "transaction" t 
where t.id_cust_fk  = 22115190443
	and t.status in('PC', 'S', 'A', 'I') -- PAID
	and to_char(t.transaction_date, 'YYYY-MM') between '2023-09' and '2023-12'
;



select * from users u where username = 'muarif180323';
select * from memberships m where username = 'muarif180323';



select * from "transaction" t where transaction_date is not null order by transaction_date desc;



