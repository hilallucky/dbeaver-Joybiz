select * from users u where username ilike 'mula';


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


select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at 
from memberships m 
where "left" = 24025667435 or "right" = 24025667435;

update memberships set "left" = null 
where "left" = 24025667435;

--update memberships set username = replace(username, '-deleted-deleted', ''), deleted_at = null
-- HAPUS HU/HAK USAHA 2-7
select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at, created_at
from memberships m 
where 
--username ilike 'marian01%' or 
--	jbid in ('heldim1401751')
username ilike 'desiya0202281' 
	or owner ='751f4989-9b2d-4f62-8173-681010c8865d'
--	or jbid in (24015633590,24015633590)
--	or "left" = 24015633344 or "right" = 24015633344
--where m."left" is null and m."right" is null
order by id;

select * from lmh_remove_units('samsi0203281');
select * from memberships m where username ilike 'mjefry1202711%';

/*  ==================================================================================================================================
 *  START UPDATE HAPUS HU
 *  ==================================================================================================================================
 */



DO $$ 
DECLARE
	row_id integer;
    xusername text := 'mjefry1202711';
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
	update memberships 
	set "left" = case when (select position('-delete' in lower(m2.username)) from memberships m2 where m2.jbid = memberships."left") > 0 then null else memberships."left" end,
		"right" = case when (select position('-delete' in lower(m2.username)) from memberships m2 where m2.jbid = memberships."right") > 0 then null else memberships."right" end
	where username = xusername;

--	select * from sranks s where s.jbid = 24015626112;

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


select * from users u where username in ('evaher0403371','evaher0403691');
select * from memberships m where username in ('evaher0403371','evaher0403691');



select username, jbid, spid, upid, "left", "right", activated_at, created_at 
from memberships m 
where "left" = "right" and "left" is not null and "right" is not null ;

select username, jbid, spid, upid, "left", "right", updated_at  
from memberships m 
where m.username in ('marlin1309511',
'ramlan1109281'
);

select * from sranks m where m.jbid in (24035673713);



update memberships 
set "right"  = null --case "right" IS NULL then 
where username in ('saepul0703901');


update sranks  
set upid = null
where jbid in ('24025666827');



select id, "owner", username, jbid, spid, upid, "left", "right", deleted_at 
from memberships m 
where "left" = 24035673592 or "right" = 24035673592;

update memberships set "left" = null 
where "left" = 24035673592;

update memberships set "right" = null, "left" = 24035673592 where jbid = 24035674466;


	-- Check if this member belongs to left/right someone (upline)
	SELECT m.username, m."left", m."right"
	FROM memberships m 
		 inner join memberships m2 on m."left" = m2.jbid or m."right" = m2.jbid  
	WHERE m2.username  ='marlin1309511';









select username, jbid, spid, upid, "left", "right", updated_at  
from memberships m 
where m."left"  = m."right" and "right" is not null and "left" is not null
order by updated_at desc ;

update memberships set "right" = null where username = 'dewapu2009561';

select * from users u where username = 'marham1903331' or nama ='Marhamah';

select username, jbid, spid, upid, "left", "right", updated_at, status, activated_at 
from memberships m 
where m.username in ('marham1903331','marham1903291');

update memberships set "right" = null where username in ('noahkl2708631') and "right" = 24035683282000;

select username, jbid, spid, upid, "left", "right", updated_at  
from memberships m 
where m.upid in (24035680055);


select username, jbid, spid, upid, "left", "right", updated_at, status, activated_at 
from memberships m 
where m.right in (24035683282000);

select * from users s where username ilike '%mulast%';
select * from memberships m where username in ('mulast1803661','nasria2302811')  or jbid  in (24035683282,22014939977);
select * from sranks s where s.jbid in (24035683282);
select * from "transaction" t where t.id_cust_fk  in (24035683282);

-- UPDATE UPLINE & SPONSOR WITH FUNCTION
-- lmh_update_upline_sponsor(:p_username, :p_new_upline, :p_change_sponsor_also, :p_new_sponsor)
select * from lmh_update_upline_sponsor('adrike1603461', 'ramlan11092815', true, 'ramlan1109281');
select * from lmh_update_upline_sponsor('gitonu1902681', 'gitonu1902681', false, '');

--
--#	username	jbid	spid	upid	left	right	updated_at	status	activated_at
--1	"achmat2101171"	"22,014,939,977"	"21,074,713,651"	"22,014,934,120"	"22,024,985,928"	"22,085,097,593"	"2022-08-02 12:05:14.000"	"1"	"2022-01-22"
--2	"mulast1803661"	"24,035,683,282,000"	"21,074,713,651"	"[NULL]"	"[NULL]"	"[NULL]"	"2024-03-19 13:07:00.000"	"1"	"2024-03-18"

--hennie0911641	23115544555	23115544372	23115544372	23125587937	24015616535	2024-01-05 19:12:45.000	1	2023-11-09
--suward1210911	22105148740	21094795076	21094795053	22115170729		2024-03-15 13:47:09.000	1	2022-10-12


-- ===============================================================================================================
-- START UPDATE UPLINE
-- ===============================================================================================================
DO $$ 
DECLARE
    xusername text := 'marlin1309511';
    new_upline_username text := 'ramlan11092815';
   	change_sponsor_also boolean := true;
    new_sponsor_username text := 'ramlan11092815';
    jbid_user bigint;
    jbid_upline bigint;
    jbid_sponsor bigint;
   	right_downline bigint;
   	left_downline bigint;
   	upline_existing text;
   	right_existing bigint;
   	left_existing bigint;

   begin
		
	-- Check if this member belongs to left/right someone (upline)
	SELECT m.username, m."left", m."right" into upline_existing, left_existing, right_existing
	FROM memberships m 
		 inner join memberships m2 on m."left" = m2.jbid or m."right" = m2.jbid  
	WHERE m2.username  = xusername;

	-- update to null for existing upline
	if left_existing is not null then
		update memberships set "left" = null, updated_at = now() where username = upline_existing;
	elseif right_existing is not null then
		update memberships set "right" = null, updated_at = now() where username = upline_existing;
	end if;
	
	   
	-- Find correct jbid for new upline
    SELECT jbid INTO jbid_user FROM memberships WHERE username = xusername;
    SELECT jbid, "right", "left" INTO jbid_upline, right_downline, left_downline FROM memberships WHERE username = new_upline_username;
	
   if left_downline is null then
   		update memberships set upid = jbid_upline, updated_at = now() where username = xusername;
		update sranks set upid = jbid_upline, updated_at = now() where jbid = jbid_user;
		update memberships set "left" = jbid_user, updated_at = now() where username = new_upline_username;
	elseif right_downline is null then
   		update memberships set upid = jbid_upline, updated_at = now() where username = xusername;
		update sranks set upid = jbid_upline, updated_at = now() where jbid = jbid_user;
		update memberships set "right" = jbid_user, updated_at = now() where username = new_upline_username;
  	end if;
  
  	-- If also want to change sponsor
	if change_sponsor_also = true then
    	SELECT jbid INTO jbid_sponsor FROM memberships WHERE username = new_sponsor_username;
    
		update memberships set spid = jbid_sponsor, updated_at = now() where username = xusername;
		update sranks set spid = jbid_sponsor, updated_at = now() where jbid = jbid_user;
	end if;
  	
    -- Display the values (you can replace this with your actual update statement)
    RAISE NOTICE 'Result: xusername = %, existing_upline_username = %, new_upline_username = %, jbid_upline = %', 
   				xusername, upline_existing, new_upline_username, jbid_upline;

END $$;
-- ===============================================================================================================
-- END UPDATE UPLINE
-- ===============================================================================================================



	SELECT m.username, m.jbid, m.spid 
	FROM memberships m   
	WHERE m.username  = 'titina0103241';


-- ===============================================================================================================
-- START UPDATE SPONSOR
-- ===============================================================================================================
DO $$ 
DECLARE
    xusername text := 'titina0103241';
    new_sponsor_username text := 'esters04124518';
    jbid_user bigint;
    new_jbid_sponsor bigint;
   	sponsor_existing text;
   	right_existing bigint;
   	left_existing bigint;

   begin
		
	-- Check jbid for new sponsor
	SELECT m.username, m.jbid into new_sponsor_username, new_jbid_sponsor
	FROM memberships m 
	WHERE m.username  = new_sponsor_username;
	
	update memberships set spid = new_jbid_sponsor, updated_at = now() where username = xusername;
	update sranks set spid = new_jbid_sponsor, updated_at = now() where jbid = (select jbid from memberships where username = xusername);

    -- Display the values (you can replace this with your actual update statement)
    RAISE NOTICE 'Result: xusername = %, new_sponsor_username = %, new_jbid_sponsor = %', xusername, new_sponsor_username, new_jbid_sponsor;

END $$;
-- ===============================================================================================================
-- END UPDATE SPONSOR
-- ===============================================================================================================



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





select * from fee_pucs fp order by fp."date" desc;


/*
ic.test(
		p_username text,
		p_new_upline text,
		p_change_sponsor_also boolean,
		p_new_sponsor text
*/

select username, jbid, spid, upid, "left", "right", updated_at  
from memberships m 
where m.username in ('marlin1309511',
'ramlan11092815'
);


select * from test('marlin1309511', 'ramlan11092815', true, 'ramlan11092815');



select * from memberships m where username = 'ramlan11092815');


