select * from users u 
where u.username  ilike 'lauren200170';

-- ini query untuk tarik data point cash reward
select u.nama, ms.username, u.handphone, sum(jc.joy) as point_reward_joy, sum(jc.biz) as point_reward_biz, sum(jc.biz + jc.joy) AS total
	-- jc.joy,jc.biz, jc."date"-- 
from joy_point_reward_cashes jc
	join memberships ms on jc.owner = ms.uid 
	join users u ON ms.uid = u.uid
where jc."date" between  '2023-12-28'and current_date and jc.deleted_at is null
and jc.deleted_at is null
and u.username ilike 'indram0911961' 
group by u.nama, ms.username, u.handphone
order by  total desc;

select * from fee_pucs fp order by "date" desc;

select to_char(now(), 'YYYY-MM-DD');

select * from users u where username like 'muarif180323';
select * from memberships m where username like 'budiwa0409571';
update memberships set deleted_at = now() where username = 'budiwa0409571';


select jbid,upid,ppv,pbv,ppvj,pbvj,erank
from prepared_data_joys pdj  
where wid=307;

select *, pbvj+gbvj as ppvplus --where wid=ct
from prepared_data_joys pdj 
where jbid ='30237'
	 and wid in (307)
	 and upid = 20069
order by wid desc limit 10;

select *
from prepared_data_joys pdj 
where jbid ='30237'
	 and wid in (307)
order by wid desc limit 10;


select * from week_periodes wp where id in (306, 307, 308) order by id;

select * from joy_point_rewards jpr where owner='6255b234-3121-49ef-a1ca-9347cf8412be' order by date desc;



-- GET EVERY NEXT 7 DAY BETWEEN 2 DATES
select count(1) 
from 
  (
  	select '2023-12-28'::date + s*'7day'::interval as datum 
  	from generate_series(0,current_date::date - '2023-01-28'::date) s
  ) foo 
where extract(dow from datum)=0;


select u.username, u.created_at, u.activated_at from users u where u.username = 'indram0911961';

-- CHECK QUALIFIKASI TURKIYE (PONT REWARDS) -- MIN PERINGKAT GAMMA, TOTAL POINT REWARDS MIN 250 -- POS 1
select 
	u.activated_at, 
	case
		when u.activated_at::date <= '2023-12-27' then (current_date::date - '2023-12-28'::date)/7 -- jika join di bawah tanggal 27 des 2023, maka hitung kamis mulai dari tanggal 28-23-2023
		else (current_date::date - u.activated_at::date)/7 -- hitung kamis dari tanggal join
	end	as "aging",
	ms.username, 
	u.nama, u.handphone, 
	sum(jp.joy) as point_reward_joy, sum(jp.biz) as point_reward_biz, sum(jp.biz + jp.joy) as total, s.srank, r.short_name,
	case 
		when sum(jp.biz + jp.joy) between 100 and 549 then 'POS 1' -- 250 and 499.999 (2023)
		when sum(jp.biz + jp.joy) between 550 and 4099 then 'POS 2' -- 500 (2023)
		when sum(jp.biz + jp.joy) >= 4100 then 'POS 3'
	end
from joy_point_rewards jp
	join memberships ms on jp.owner = ms.uid 
	left outer join users u on ms.uid = u.uid or ms."owner" = u.uid 
	left outer join sranks s on ms.jbid = s.jbid 
	left outer join ranks r on s.srank = r.id 
where 
	jp."date" BETWEEN '2023-12-28'and now()::date and jp.deleted_at is null
--	jp."date" between  '2023-12-28'and current_date and jp.deleted_at is null
	and jp.deleted_at is null
--	and ms.username ='indram0911961'
group by 
	u.activated_at, 
	ms.username, u.nama, u.handphone, s.srank, r.short_name
having sum(jp.biz + jp.joy) >= 50 --between 200 and 249-- 
order by point_reward_joy asc;

-- CHECK QUALIFIKASI CASH REWARDS
select u.nama, ms.username, u.handphone, sum(jc.joy) as point_reward_joy, sum(jc.biz) as point_reward_biz, sum(jc.biz + jc.joy) AS total, 'CASH REWARD'
from joy_point_reward_cashes jc
	join memberships ms on jc.owner = ms.uid 
	left outer join users u on ms.uid = u.uid or ms."owner" = u.uid 
where jc."date" between '2023-12-29'and now()::date
	and ms.username ='indram0911961'
	and jc.deleted_at is null
--	and jc.deleted_at is null 
group by u.nama, ms.username, u.handphone
having sum(jc.biz + jc.joy) >= 100 --between 60 and 99 -- 
order by total desc;

-- CHECK NETWORK BASED ON MEMBER NAME ETC...
SELECT ('A' ILIKE ANY(ARRAY['A','S'])) as logical_test ;

select * from memberships m where jbid in (21042801174,21072801115);
select * from users u where username in ('esters0402196','esters0402198','esters040219');

select 	u.username , u.nama, m.jbid, 
		m.spid, sp.username, sp.jbid as sp_jbid, usp.nama as sp_nama,
		m.upid, mp.username as up_username, up.nama as up_nama
from users u 
	 join memberships m on u.username = m.username 
	 left outer join memberships sp on m.spid = sp.jbid
	 left outer join users usp on sp.username = usp.username 
	 left outer join memberships mp on m.upid = mp.jbid
	 left outer join users up on mp.username = up.username 
where u.username ilike --; '%Daniel catur agus setiawan%';
--ALL({'%Effendi Bahri Anak%','%Daniel catur agus setiawan%'});
ANY(array[
'effend1808501',
'haname2709531',
'daniel0308121',
'afriya2210861',
'safnam1804591'
])
order by u.nama, m.username, u.id;

/*
Effendi Bahri Anak 
Daniel catur aguss etiawan 
Hana Mei Kristina 
Apriyanti Elisabet 
sapna anggraeni
Marinta 
witdia Nasution
sudar Yono Rosita Sitepu
arim
*/

select * from memberships m where username ilike'pinkir011014%';

    SELECT m1.*
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    WHERE m1.username in ('mohammad171260','mohammad1712603');
   select * from memberships m 
  where 
-- 		username in ('mohammad171260','mohammad1712603','mohammad1712605')
 		jbid  = 26
 		;
   
   select * from users u where username in ('mohammad171260','mohammad1712603','mohammad1712605');
    

-- SHOW ALL DOWNLINE BASED ON ID MEMBER
WITH RECURSIVE downline_cte AS (
    SELECT m1.id, m1.username, m1.jbid, m1.spid, m1.upid, m1."left", m1."right", u1.nama
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    WHERE lower(m1.username) = lower('meilan0502321') --jbid = 26
    UNION
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, m2."left", m2."right", u2.nama
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
	    JOIN downline_cte ucte ON m2.upid = ucte.jbid
)
SELECT id, '', username, jbid, spid, upid, "left", "right", nama 
FROM downline_cte 
--where username like 'mohammad17%'
order by jbid;



-- SHOW ALL DOWNLINE BASED ON ID MEMBER
WITH RECURSIVE downline_cte AS (
    SELECT m1.id, m1.username, m1.jbid, m1.spid, m1.upid, m1."left", m1."right", u1.nama
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    WHERE lower(m1.username) = lower('meilan0502321') --jbid = 26
    UNION
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, m2."left", m2."right", u2.nama
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
	    JOIN downline_cte ucte ON m2.spid = ucte.jbid
)
SELECT id, '', username, jbid, spid, upid, "left", "right", nama 
FROM downline_cte 
--where username like 'mohammad17%'
order by jbid;


select * from users u where username ='nuryan171272';
select * from memberships m  where username ='mamans29077613';

SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level
FROM memberships m1
	left outer join users u1 on m1.owner = u1.uid
WHERE lower(m1.username) = lower('mamans29077613')


-- SHOW ALL DOWNLINE BASED ON ID MEMBER AND PRINTED TO PAPER
-- Step 1: Create the temporary table
CREATE TEMPORARY TABLE tree_path (
    row_num int8,
    id int8,
    username VARCHAR,
    nama VARCHAR,
    jbid int8,
    spid int8,
    upid int8,
    upline_name VARCHAR,
    upline_no int8,
    level int8
);

-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    WHERE 
    lower(u1.username) = lower('mamans29077613')
--    m1.jbid = 14922

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
    	JOIN hierarchy_cte h ON m2.upid = h.jbid
--    where h.level < 3
)
INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level)
SELECT
    ROW_NUMBER() OVER (order by level, upline_name, upid, id) AS row_num,
    id, username, nama, jbid, spid, upid, upline_name, upline_no, level
FROM hierarchy_cte
ORDER BY level, upline_name, upid, id;

-- Step 3: Query the temporary table to retrieve the results
SELECT tp.row_num, tp.id, tp.username, tp.nama, tp.jbid, tp.spid, tp.upid, tp.upline_name, (select t.row_num from tree_path t where t.jbid = tp.upid) as upline_no, tp.level
FROM tree_path tp
--where username = 'nuryan171272'
ORDER BY tp.row_num;  

-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;

-- END NETWORK




-- SHOW ALL DOWNLINE BASED ON ID MEMBER AND PRINTED TO PAPER
-- Step 1: Create the temporary table
CREATE TEMPORARY TABLE tree_path (
    row_num int8,
    id int8,
    username VARCHAR,
    nama VARCHAR,
    jbid int8,
    spid int8,
    upid int8,
    upline_name VARCHAR,
    upline_no int8,
    level int8
);

-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level
    FROM memberships m1
    	left outer join users u1 on m1.owner = u1.uid
    WHERE lower(m1.username) = lower('mamans2907761')
--    m1.jbid = 14922

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1
    FROM memberships m2
    	left outer join users u2 on m2.owner = u2.uid
    	JOIN hierarchy_cte h ON m2.spid = h.jbid
--    where h.level < 3
)
INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level)
SELECT
    ROW_NUMBER() OVER (order by level, upline_name, upid, id) AS row_num,
    id, username, nama, jbid, spid, upid, upline_name, upline_no, level
FROM hierarchy_cte
ORDER BY level, upline_name, spid, id;

-- Step 3: Query the temporary table to retrieve the results
SELECT tp.row_num, tp.id, tp.username, tp.nama, tp.jbid, tp.spid, tp.upid, tp.upline_name, (select t.row_num from tree_path t where t.jbid = tp.upid) as upline_no, tp.level
FROM tree_path tp
--where username = 'nuryan171272'
ORDER BY tp.row_num;  

-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;

-- END NETWORK






WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, m1.jbid, m1.spid, m1.upid, u1.nama, 0 AS upline_no
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    WHERE m1.jbid = 14922
    
    UNION ALL

    select m2.id, m2.username, m2.jbid, m2.spid, m2.upid, u2.nama, h.upline_no + 1
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
	    JOIN hierarchy_cte h ON m2.upid = h.jbid
)
SELECT ROW_NUMBER() OVER () AS no, id, jbid, username, nama, upid, COALESCE(upline_no, 0) AS upline_no
FROM hierarchy_cte
ORDER BY no;

select * from users u where username ilike 'humaid%';

-- SHOW ALL UPLINES ONLY BASED ON ID MEMBER -- OPTION 1
WITH RECURSIVE upline_cte AS (
    select  m1.id, m1.username, m1.jbid, u1.nama, 
    		m1.spid, 
    		m1.upid -- mup1.username as up_username, sup1.nama as up_nama,
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    	-- left outer join memberships mup1 on mup1.jbid = m1.upid
    	-- left outer join users sup1 on mup1.username = sup1.nama
    WHERE lower(u1.username) ilike 'dessyn040231%' -- in ('humaidi0908411')
    UNION
    SELECT 	m2.id, m2.username, m2.jbid, u2.nama, 
		    m2.spid, 
		    m2.upid, -- mup2.username as up_username, sup2.nama as up_nama,
		    t2.transaction_date, t2.bv_total,
    		ROW_NUMBER() OVER (PARTITION BY m2.id ORDER BY t2.transaction_date DESC) AS row_num
    FROM memberships m2
    	join users u2 on m2.username = u2.username
	    JOIN upline_cte ucte ON m2.jbid = ucte.upid
    	join transaction t2 on t2.id_cust_fk = m2.jbid
    	-- left outer join memberships mup2 on mup2.jbid = m2.upid
    	-- left outer join users sup2 on mup2.username = sup2.nama
    WHERE t2.transaction_date is not null
)

select 	U.row_num, u.id, u.username, u.jbid, u.nama, 
--		u.spid, 
--		u.upid,--  u.up_username, u.up_nama,
		u.transaction_date, u.bv_total
FROM upline_cte u 
where u.row_num = 1
ORDER BY u.username, u.transaction_date DESC;



-- SHOW ALL UPLINES BASED ON ID MEMBER -- OPTION 2
WITH RECURSIVE upline_cte AS (
    select  distinct  on (m1.username) m1.id, m1.username, m1.jbid, m1.spid, m1.upid, u1.nama, t1.transaction_date, t1.bv_total
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    	join transaction t1 on t1.id_cust_fk = m1.jbid 
    WHERE lower(u1.username) in ('dessyn040231')
		and t1.transaction_date is not null
    UNION
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, u2.nama, t2.transaction_date, t2.bv_total
    FROM memberships m2
    	join users u2 on m2.username = u2.username
	    JOIN upline_cte ucte ON m2.jbid = ucte.upid
    	join transaction t2 on t2.id_cust_fk = m2.jbid
    WHERE t2.transaction_date is not null
)
select distinct on (u.username) *
FROM upline_cte u 
ORDER BY u.username, u.transaction_date DESC;






-- SHOW ALL SPONSORS BASED ON ID MEMBER -- OPTION 2
WITH RECURSIVE upline_cte AS (
    select  distinct  on (m1.username) m1.id, m1.username, m1.jbid, m1.spid, m1.upid, u1.nama, t1.transaction_date, t1.bv_total
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    	join transaction t1 on t1.id_cust_fk = m1.jbid 
    WHERE lower(u1.username) in ('dessyn040231')
		and t1.transaction_date is not null
    UNION
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, u2.nama, t2.transaction_date, t2.bv_total
    FROM memberships m2
    	join users u2 on m2.username = u2.username
	    JOIN upline_cte ucte ON m2.jbid = ucte.upid
    	join transaction t2 on t2.id_cust_fk = m2.jbid
    WHERE t2.transaction_date is not null
)
select distinct on (u.username) *
FROM upline_cte u 
ORDER BY u.username, u.transaction_date DESC;




-- START CHECK CJ ---
-- 800BV LAST 3 MONTHS, SC = 10
select m2.jbid from memberships m2 where m2.username = 'hennym2707611';
select username , jbid, spid, activated_at 
from memberships m 
where spid = (select m2.jbid from memberships m2 where m2.username = 'hennym2707611')
--	 and username = 'hennym2707611'
	and flag = 2 -- SC
	;

select COUNT(X.*) as "bv_800"
from (
	select to_char(t.transaction_date, 'YYYY-MM'),  id_cust_fk, m.username, sum(bv_total) as "sum_bv_total", sum(bv_plan_joy) as sum_bv_plan_joy, sum(bv_plan_biz) as sum_bv_plan_biz 
	from "transaction" t 
		  inner join memberships m on t.id_cust_fk = m.jbid
	where id_cust_fk = 23075398567
			and t.deleted_at is null
			and t.status in('PC', 'S', 'A', 'I') -- PAID
			and to_char(t.transaction_date, 'YYYY-MM') between '2023-11' and '2024-02'
	group by to_char(t.transaction_date, 'YYYY-MM'),  id_cust_fk, m.username
	having sum(bv_total) >= 800 OR sum(bv_plan_joy) >= 800 OR sum(bv_plan_biz) >= 800 
	order by to_char(t.transaction_date, 'YYYY-MM'),  id_cust_fk
) as X
;
-- END CHECK CJ ---




-- LIST POLA TURBO
SELECT 
--		ROW_NUMBER() OVER (order by sr.srank, ms.activated_at desc) as "No", 
		ms.username as "Username", u.nama as "Nama", sr.srank as "Rank", 
		ms.activated_at as "Activated At", AGE(ms.activated_at) as "Joint Duration",
		case 
			when AGE(now(), ms.activated_at) > INTERVAL '3 months' then '> 3 months' 
			else '' --null 
		end as "Remarks"
--		,(DATE_PART('YEAR', now()::DATE) - DATE_PART('YEAR', ms.activated_at::DATE)) * 12
--		+ (DATE_PART('Month', now()::DATE) - DATE_PART('Month', ms.activated_at::DATE)) AS month_diff
--		,ms.spid, ms.jbid 
FROM memberships ms
	join users u on u.username = ms.username 
	JOIN sranks sr ON ms.jbid = sr.jbid
WHERE ms.spid = (select m.jbid from memberships m where lower(m.username) = lower('mamans2907761'))
	--22115186779 --= 23075375780 --nama ilike '%qurrotun%'
	 AND sr.srank >= 1 
--	and AGE(now(), ms.activated_at) < INTERVAL '3 months' 
	 or lower(ms.username) -- ILIKE ANY(ARRAY[
	 in (
	 lower('mamans2907761')
)
--	])
ORDER BY case 
			when AGE(now(), ms.activated_at) > INTERVAL '3 months' then '> 3 months' 
			else null 
		end ,
	ms.jbid, sr.srank, ms.activated_at desc;

--select 5500*1500

SELECT now(), '2023-01-06', AGE(now(), '2023-01-06 00:00:00') as "ages", 
case 
	when AGE(now(), '2021-11-06 00:00:00') > INTERVAL '4 months' then 'lewat dari 4 bulan' 
	else null 
end as "test"
WHERE AGE(now(), '2023-01-06 00:00:00') > '4 months';

select * from bank b ;
select * from alamat_kelurahan ak;
--select * from alamat_kecamatan ak where id in (3205190,6308011);

-- CHECK BONUS XPRESS
select t.created_at, t.transaction_date, t.id_cust_fk, m.jbid, m.username, u.nama , t.code_trans, t.bv_total, be.wid, be.amount, be."date" 
from "transaction" t
	join memberships m  on t.id_cust_fk = m.jbid 
	join users u on m.username = u.username 
	join bonus_expresses be on t.code_trans = be.code_trans
where m.username in ('rranik0811351','yayady2211701');
select * from bonus_expresses limit 1;

select * from alamat_kecamatan ak;
select * from alamat_kelurahan ak;

-- CEK TOTAL UNIT BERDASARKAN USERNAME
select m.username, u.nama, u.uid, m.jbid, m.upid, m2.username as up_username, (select count(*) from memberships m3 where m3.owner = u.uid) as "unit"
from users u 
	 join memberships m on m.username  = u.username
	 join memberships m2 on m.upid = m2.jbid 
where u.username in ('daniel0412291', 'effend0412251','esters0412451','afriya0412581')
order by m.id;

select * from alamat_provinsi ap where provinsi ilike '%sul%sel%';
select * from alamat_kabupaten ak2 where id_provinsi in (73) and kabupaten ilike '%makassar%'; ;--id in (3209, 3404);--3172
select * from alamat_kecamatan ak where id_kabupaten in (7371); -- kecamatan ilike '%jember%';-- id_kabupaten in (1802);--3673060 --
select * from alamat_kelurahan ak where kelurahan ilike '%ramatwatu%'; -- 3673060001 id_kecamatan = 1802043; -- 7371031001 id_kecamatan in (7371031); --


-- UBAH SPONSOR/ALAMAT
select ID,nama,  username, email, handphone, alamat, kelurahan, kecamatan, kota_kabupaten, provinsi, status , no_npwp, 
	id_bank_fk, bank_name, bank_acc_num, bank_acc_name, created_at, activated_at, uid 
from users u 
where 
	username ilike ('abdulm1310721') -- or 
--	username ilike 'zalimi0301211' -- or username ilike 'andang0812121%' or username ilike 'budisa0812841%'; 
--	 email in ('atisanti77@gmail.com','daraesanr@gmail.com','yanakayaraya@gmail.com','iamulyaningsih262@gmail.com','agusmpasya@gmail.com');
;

select * 
from users u  
where username ilike '%delete'
--	username in ('erlian0712901','annisa2111341', 'bintan1511651')
	username in ('drsrus2801931') or 
	username ilike 'drs.mu10117%' --or username ilike 'andang0812121%' or username ilike 'budisa0812841%' 
order by id ;

select u.username, u.nama, u.activated_at::date
from users u 
where u.username in ('widyan2002721',
'drs.mu10117'
);


select username, jbid, spid, upid, "left", "right" , "owner" ,created_at, activated_at, status,flag, deleted_at from memberships m where jbid is null and deleted_at is null order by created_at desc;

select username, jbid, spid, upid, "left", "right" , "owner" ,created_at, activated_at, status,flag, deleted_at 
from memberships m 
where 
--	username ilike 'suliha0901171%' -- or username ilike 'dewire2206881%' or username ilike 'andang2508341%' -- old
--	username ilike 'Surian0712541' --or username ilike 'andang0812121%' or username ilike 'budisa0812841%' -- new
--	username ilike'esters0412451%' -- or username  = 'liamul0112761'
--	or 
--	username in ('esters0412451','effend0412251','daniel0412291','afriya0412581') -- or jbid = 23105527852
	username in ('widyan2002721','effend0412251') 
--	or jbid in (22065077731)
--	"owner" = '0fe96839-aeb2-412b-a3bf-4dd15eaf566b'
order by id, username, id ;
--
--select username, jbid, spid, upid, "left", "right" , activated_at, status 
--from memberships m 
--where --username ilike'agusmu0112791%' or username  = 'liamul0112761'
--username in ('yanasu01121312') --,'daraes0112221','yanasu0112131','liamul0112761','agusmu0112791')
----or jbid in (23125573229,23125573236)
--order by id ;

--select id, username, jbid, spid, upid, "left", "right" 
--from memberships m 
--where username in ('santis0112981'); -- or id = 56005 --'suhaen1511461','yuslia0910461', 
----	or jbid in (23105511824, 23105511824) --or "right" in (23105520652)	
--;
-- select * from users u where username in ('dewire08122112','dewire08122113');
select * from memberships m  where username in ('dewire08122112','dewire08122113');

select * -- jbid, spid, upid, appv, srank, created_at, updated_at  
from sranks s 
where  jbid in (23125576470,
24025664182
) 
order by jbid ;

#	username	jbid	spid	upid	left	right	owner	created_at	activated_at	status	flag	deleted_at
1	"estipu0101831"	"24,015,612,541"	"42,758"	"22,105,146,945"	"24,015,612,689"	"[NULL]"	"3ee7183e-6e36-4d31-980b-140b0ae3c70f"	"2024-01-01 20:15:59.000"	"[NULL]"	"0"	"1"	"[NULL]"
2	"aswant0101551"	"24,015,612,689"	"24,015,612,541"	"24,015,612,541"	"[NULL]"	"[NULL]"	"9be4dcab-e963-452b-b55d-02cbb4a5df34"	"2024-01-01 20:26:23.000"	"2024-01-30"	"1"	"1"	"[NULL]"

select s.jbid, s.spid, m.spid as m_spid, s.upid, m.upid as m_upid, s.appv, s.srank, s.created_at, s.updated_at  
from sranks s 
	 join memberships m on s.jbid = m.jbid 
where  s.jbid in () 
and (s.spid <> m.spid or s.upid <> m.upid)
order by s.jbid ;

select s.id, m.username, s.jbid, s.srank, s.spid, s.upid 
from sranks s
	 join memberships m on m.jbid = s.jbid 
where m.username in ('fanian2611901', 'agusti1711761', 'agussu2707481'); 
--s.upid 

select * from "transaction" t where id_cust_fk = 23125582013;

-- UBAH NAMA
select * from users u where u.username in ('saswin0512941','wenzir050324','esters0412451',
'effend0412251',
'daniel0412291',
'afriya0412581') ilike 'saswin0512941' ;-- email in ('mohammad97@gmail.com','sumarni75@gmail.com');
select * from memberships m where username in  ('saswin0512941','wenzir050324','esters0412451',
'effend0412251',
'daniel0412291',
'afriya0412581') or jbid = 23115574321;

update u
from users u 
	join memberships m on u.usernam = m.username
where u.username = 'artiwi1911141';


select concat(substring(lower(replace('Arwiti', ' ', '')) from 1 for 6), 
		substring(username from 7 for LENGTH(username))) as new_username
from users 
where username = 'arwiti1911141';

-- HAPUS ITEM PRODUCT
select  * from "transaction" t where code_trans ilike '2NW8DT';
select  * from transaction_detail td where id_trans_fk in (146113);


select id, kode , nama, status, is_show, is_show_sc, updated_at , deleted_at 
from barang b 
where nama ilike lower('%Free Joy Coffee%') 
	or kode in ('I005J39','JOBVBP001J39','GGBVB001J40','SUP001J40','SUT001J40','I005PLJ40')
	or nama ilike 'JoyVit-C (J39)'
	;
--	or status = 'I';

select * from 


select * from transaction t where t.code_trans ilike 'PO9WB9%' order by id;
select * 
from transaction_detail td 
where td.id_trans_fk in (144776
--,144776
--,144777
--,144778
--,144779
--,144780
--,144781
--,144782
) 
order by id_trans_fk , id_barang_fk;


select * from memberships m where username ='anissa09121918';

-- UBAH ALAMAT PENGIRIMAN
select * from users u where username ='karint0212601';

-- UBAH EXPEDISI
--  4 untuk JNE dan 7 untuk TIKI
select id, code_trans, transaction_date, courier, deleted_at, status 
from "transaction" t 
where code_trans in ('QPIGGN');
select * from transaction_detail td where id_trans_fk =145757;

select t.code_trans, status, is_pickup, shipping_name, shipping_phone, shipping_address,
		shipping_city, shipping_province, shipping_village, shipping_district, shipping_cost 
from "transaction" t where t.code_trans in ('NMQMAF') ;

update "transaction" 
set shipping_name= null, shipping_phone= null, shipping_address= null, courier = null,
		shipping_city= null, shipping_province= null, shipping_village= null, shipping_district= null
where code_trans = 'C815TA';

select * from "transaction" t where t.code_trans in ('L6EBTX','J56TOJ','C815TA','SF7F7F') ;

select * from stock_packs sp ;


select * from alamat_provinsi ap where provinsi ilike '%sul%sel%';
select * from alamat_kabupaten ak2 where id_provinsi in (73) and kabupaten ilike '%makassar%'; ;--id in (3209, 3404);--3172
select * from alamat_kecamatan ak where id_kabupaten in (7371); -- kecamatan ilike '%jember%';-- id_kabupaten in (1802);--3673060 --
select * from alamat_kelurahan ak where id_kecamatan in (7371031); --kelurahan ilike 'jember'; -- 3673060001 id_kecamatan = 1802043; -- 7371031001

-- UBAH NO REKENING
select * from memberships m where username ='karima0608691';
select id, username, nama, email, id_bank_fk, bank_name , bank_acc_name, bank_acc_num, no_npwp, handphone 
from users u where username in ('triwin250412'); --ilike 'abdulm2212951'; -- 
select * from bank b;

update users set id_bank_fk = null, bank_name = null, bank_acc_name = null, bank_acc_num = null  where username in ('nurhas050175','waliya0905761');

-- Tarik data transaksi
SELECT transaction_date , code_trans, m.jbid, m.username, u.nama, sp."name" 
FROM "transaction" t
	 join memberships m on t.id_cust_fk = m.jbid 
	join users u on m.username =u.username 
	join stock_packs sp on t.pickup_stock_pack =sp.code 
where t.is_pickup =1 and t.status = 'PC' and t.pickup_stock_pack ='MPUC001'
order by t.created_at ;
	 and t.code_trans = 'EFMK3Y';

select * from stock_packs sp ;

select * from users u where email ilike 'hilal%';
select * from memberships m where username in ('hilalt2311241','hilal02311451');


select * from delivery_orders do2 where do2.wid <> 1;

select * from users u where nama ilike 'lia%tres%'; 
select * from user_admins ua where id_user_fk in (28609,28610); 
select * from stock_packs sp;
select * from stock_pack_top_ups sptu;
select * from stock_pack_top_up_details sptud;
select * from stock_pack_officers spo ;
select * from stock_pack_deliveries spd ;
select * from stock_pack_delivery_details spdd ;
select * from stock_pack_pickeds spp ;

select code, "name"  from stock_packs sp where sp.code = 'PUC003';

select sps.*
from stock_pack_stocks sps 
where jspid = 'PUC003';


select sps.*, b.nama
from barang b 
	 left outer join stock_pack_stocks sps on sps.pcode = b.kode -- and b.nama is null and sps.pcode is null
where jspid = 'PUC003';

select * from barang b ;

-- UPDATE PICKUP KE SHIPPING ATAU SEBALIKNYA
select * from stock_packs sp;
select code_trans, status, is_pickup, pickup_stock_pack  from "transaction" t where code_trans in ('05AQMY','TN1ZD3');


-- UBAH NO HP PENGIRIMAN
select * from users u where username ='mambau1211961';
select id, code_trans, transaction_date, created_at, purchase_cost, shipping_cost, subsidi_shipping, gross_shipping
from "transaction" t 
where code_trans in ('ORJ3JL');
select * from transaction_detail td where id_trans_fk = '144918';
select * from transaction_detail td where id_trans_fk = '144376';


UPDATE "transaction"
SET shipping_cost = gross_shipping, subsidi_shipping = 0
WHERE code_trans in (' 9VCYJM',
'OCE3EZ',
'JD9F1M',
'RTZZXQ',
'YHLIU5',
'3NUGP1',
'XZWNPS',
'MUOKVR',
'NHVMOO','WJRB5W','4ERE6N',
'IVZZHO');

-- CHECK TRANSAKSI MEMBER
select m.id, m.jbid, m.username, m.spid, m.upid, 
	t.transaction_date, t.created_at, t.code_trans, t.pv_total, t.bv_total, 
	t.deleted_at, t.status 
from "transaction" t 
	  join memberships m on t.id_cust_fk = m.jbid 
where 
	t.code_trans in ('HEXDPS')
--t.status in('PC', 'S', 'A', 'I') -- PAID
--	 and m.username in ('andrie2211191')
--	 and t.transaction_date >= '2023-11-07'
order by m.username, t.transaction_date desc ;

-- TERMINATE USERS
select -- u.id, u.username, 
	u.email, u.nama,
	u."password" , 
	u.no_ktp, u.handphone, u.bank_name, u.bank_acc_num, 
	u.provinsi,
	u.disabled, u.activated_at, u.status 
from users u
where u.username in ('bahija300967'); 

select m.id, m.username, m.jbid, m.spid, m.upid, m."left", m."right", m.activated_at, m.status 
from memberships m 
where m.username in ('manan1011961','arikha2011201') or jbid in (23115538056,24025648483)
--	m.username in ('daniel0412291', 'effend0412251') or m.username ilike 'esters0412451%' or m.username ilike 'afriya0412581%'
order by m.id;

select * from sranks s where jbid in ('23125583242','23125583276');
select * from eranks e where jbid in ('23125583232','23125583376');

23125583276 23125583232	23125583232;

('afriya2210861',
'afriya22108612',
'afriya22108613',
'haname2709531',
'haname27095312',
'haname27095313',
'daniel0308121',
'effend1808501'
);



('esters040219', --ilike 'esters040219%' 
'esters0402192',
'esters0402193',
'esters0402194',
'esters0402195',
'esters0402196',
'esters0402197',
'esters0402198',
'esters0402199',
'esters04021910');




--select username, jbid, upid, "left", "right", deleted_at 
--from memberships m 
--where username ilike 'tanmei0112741%' or username ilike '%delete'
--order by id ;

select m.username, m.jbid, s.jbid, s.*
from memberships m 
	join sranks s on m.jbid = s.jbid 
where m.username = 'yudian0108151';


select * from memberships m where username in ('nandio2111871','masrif2507821');
select * from sranks s where jbid in (23075396017,23115560963);



-- CHECK TOTAL BV MEMBER DALAM SETAHUN TERAKHIR
select m.username, u.nama, m.activated_at,
		coalesce(sum(t.pv_total), 0) as "pv", max(t.transaction_date) "latest_date",
		coalesce(AGE(now(), max(t.transaction_date))) as "transaction_age"
from  
	memberships m  
	left join users u on m.username = u.username
	left outer join "transaction" t on t.id_cust_fk  = m.jbid and t.st;atus in('PC', 'S', 'A') -- , 'I') -- PAID
where m.username in ('dayuka050191', 'triawa2604561')
group by m.username, u.nama,  m.activated_at;

select * from users u where username ilike '510806%' or email ilike 'mertagede%';

select * from memberships m where m.uid in ('1f5ed8d1-1b1c-4145-aae8-299448651c5e'); 

select * from "transaction" t where code_trans ='6M515P';
select * from barang where nama ilike '%Joybizer (J31%'; --1063 R05J31	Joybizer (J31)
select * from transaction_detail td where id_trans_fk in (144756);


select id, code_trans, created_at, deleted_at, transaction_date  from "transaction" t where code_trans in ('J68PTY','WJULNN');
select * from transaction_detail td where id_trans_fk in (145654, 145655);



select * from "transaction" t where id_cust_fk = 4 order by created_at desc;

select * from transaction_detail td 


-- START CHECK TIKET ACARA TERJUAL
SELECT tr.code_trans, tr.transaction_date, ms.username AS Buyer, u.nama ,
		td.id_barang_fk , td."name" AS barang , tr.status, td.qty 
FROM "transaction" tr
	JOIN transaction_detail td ON tr."id" = td.id_trans_fk
	JOIN memberships ms ON tr.id_cust_fk = ms.jbid
	JOIN users u ON ms."owner" = u.uid 
WHERE td.id_barang_fk IN(1625) 
	AND tr.transaction_date BETWEEN '2023-03-01' AND now()::date
	AND tr.transaction_date IS NOT NULL 
	AND tr.deleted_at IS null
--	or tr.code_trans in ('XO1T8X')
ORDER BY tr.transaction_date;
-- END CHECK TIKET ACARA TERJUAL


select m.username, m.created_at, m.activated_at, "owner" 
from memberships m 
where username ilike 'wendri290683'
order by username ;


select * from bonus_matchings bm ;



select 	u.uid, u.username , u.nama, u.handphone, u.email,
--		jbs.id, 
--		jbs.date, 
		jbs.wid, 
		jbs.owner, 
		sum(jbs.xpress) as xpress, 
		sum(jbs.bgroup) as bgroup,
		sum(jbs.leadership) as leadership, 
		sum(jbs.total) as total,
		sum(jbs.tax) as tax,
		sum(jbs.voucher) as voucher,
		sum(jbs.transfer) as transfer, 
		jbs.confirmed, 
		jbs.published, 
--		jbs.vouchered, 
		jbs.transfered, 
--		jbs.created_at, 
--		jbs.updated_at, 
		jbs.user_id, 
		jbs.deleted_at, 
		sum(jbs.year_end) as year_end
from joy_bonus_summaries jbs 
	 left outer join users u on jbs."owner" = u.uid  
where 
--	jbs."date" ='2023-12-27' and
	jbs.wid = 314
	and jbs.deleted_at is null 
	and jbs."owner" ='38d2d0af-14bd-4f38-bd44-5e708dac8026'
group by u.uid, u.username , u.nama, u.handphone, u.email,
--		jbs.id, 
--		jbs.date, 
		jbs.wid, 
		jbs.owner, 
		jbs.confirmed, 
		jbs.published, 
--		jbs.vouchered, 
		jbs.transfered, 
--		jbs.created_at, 
--		jbs.updated_at, 
		jbs.user_id, 
		jbs.deleted_at; 
	
	


select 	
	u.uid, u.username , u.nama, u.handphone, u.email,
--		jbs.id, 
--		jbs.date, 
		jbs.wid, 
--		jbs.owner, 
		sum(jbs.xpress) as xpress, 
		sum(jbs.bgroup) as bgroup,
		sum(jbs.leadership) as leadership, 
		sum(jbs.total) as total,
		sum(jbs.tax) as tax,
		sum(jbs.voucher) as voucher,
		sum(jbs.transfer) as transfer, 
		jbs.confirmed, 
		jbs.published, 
--		jbs.vouchered, 
		jbs.transfered, 
--		jbs.created_at, 
--		jbs.updated_at, 
		jbs.user_id, 
		jbs.deleted_at, 
		sum(jbs.year_end) as year_end
from joy_bonus_summaries jbs 
	 left outer join users u on jbs.user_id  = u.uid  
where 
--	jbs."date" ='2023-12-27' 
	jbs.wid = 314
	and jbs.deleted_at is null 
--	and (jbs."owner" ='fadea2f8-8ac0-4b52-931e-70af373b9056'
--	or jbs.user_id = 'fadea2f8-8ac0-4b52-931e-70af373b9056')
--	and "owner" = ';38d2d0af-14bd-4f38-bd44-5e708dac8026'
group by 
	u.uid, u.username , u.nama, u.handphone, u.email,
--		jbs.id, 
--		jbs.date, 
		jbs.wid, 
--		jbs.owner, 
		jbs.confirmed, 
		jbs.published, 
--		jbs.vouchered, 
		jbs.transfered, 
--		jbs.created_at, 
--		jbs.updated_at, 
		jbs.user_id, 
		jbs.deleted_at; 



select jbs."owner", u.uid, u.username , u.nama, jbs.*
from joy_bonus_summaries jbs 
	 left outer join users u on jbs."owner" = u.uid 
where
--	jbs."date" ='2023-12-27' 
	jbs.wid = 314
	and jbs.deleted_at is null 
	and jbs."owner" ='02eeb3de-3538-421a-b22a-02467558e59d'; 



select * from week_periodes wp where to_char("sDate", 'YYYY-MM') between '2024-01' and '2024-02' order by id desc;

select * from "transaction" t where code_trans in ('ES9BKU');


-- ============================================================================================
-- START UPDATE TAX/PPH
-- ============================================================================================
	select * from memberships m where username in ('abidin1511131','abidin15111312');
	select * from bonus_weeklies bw where wid=325 and "owner" in ('13668f78-2fc5-4370-a4b9-159bf0687b6c','9aae7326-21de-40d5-95c5-c91fdcbf66ee','13668f78-2fc5-4370-a4b9-159bf0687b6c');
	
	--	START UPDATE PPH BONUS BIZPLAN
	select m.username, bw.user_id, bw."owner", bw.wid, bw.total, bw.voucher, bw.ppn, bw.total_transfer 
	from bonus_weeklies bw 
--		left outer join memberships m on bw.user_id = m.uid and bw."owner" = m."owner"  
		left outer join memberships m on bw.user_id = m.uid and bw.user_id  = m."owner"  
	where bw.wid = 325
		 and m.username in ('joy201741',
							'winadi0207861',
							'endang0909701',
							'abidin1511131',
							'indra120289',
							'imaded2804811',
							'ipanka1111751',
							'diniwi230132',
							'zalufi2606521',
							'diyana121271',
							'indram0911961',
							'supriy15053',
							'inyoma140279',
							'maryan150349',
							'dedemu0409731',
							'rinama220118',
							'ekasem110394',
							'igeded270163',
							'nuryan171272',
							'sukart010728',
							'karwat1602461',
							'mamans2907761'
						)
	 order by bw."owner", bw.total;

	select * from memberships m where username ='endang220246';
select * from bonus_weeklies bw where "owner" = '0ad45beb-c1be-4377-8f42-c94cbe486b1c' and wid = 323;
--	select * from week_periodes wp where wp.id > 321 order by id ;
	
	select "owner", user_id , wid, total, voucher, ppn, total_transfer 
	from bonus_weeklies bw 
	where wid = 325
		and user_id  in (   
						select m.owner
						from memberships m 
						where m.username in ('indra120289',
											'sukart010728',
											'indram0911961',
											'abidin1511131',
											'mamans2907761',
											'rinama220118',
											'ekasem110394',
											'diyana121271',
											'maryan150349',
											'igeded270163',
											'joy201741',
											'inyoma140279',
											'supriy15053',
											'karwat1602461',
											'endang0909701',
											'winadi0207861',
											'zalufi2606521',
											'nuryan171272',
											'diniwi230132',
											'ipanka1111751',
											'imaded2804811',
											'dedemu0409731'
											)
					)
	 order by "user_id", total;
	--	END UPDATE PPH BONUS BIZPLAN
	
	select * from bonus_weeklies bw where wid = 323 and "owner" = '06b72e95-c214-4a96-b569-299f46fd7b93';
	select * from prepared_data_joys pdj where wid = 323 ;
	
	select * from memberships m where username in ('darwin020280');
	select * from joy_bonus_summaries jbs where "owner" = '04ed68ce-1279-452a-8846-3c216119d7be' and wid = 325;
	
	--	START UPDATE PPH BONUS JOYPLAN	
	select * from joy_bonus_summaries jbs where "owner" = '026d38b1-10ef-4104-ab15-6ef16e0b6a01' and wid =323;
	select m.username, count(m.username) as "qty", jbs.user_id, jbs."owner", jbs.wid, 
			sum(jbs.xpress) as "xpress", sum(jbs.bgroup) as "bgroup", 
			sum(jbs.leadership) as "leadership", sum(jbs.year_end) as "year_end", 
			sum(jbs.voucher) as "voucher", sum(jbs.tax) as "tax", 
			sum(jbs.total) as "total", sum(jbs.transfer) as "transfer" -- , jbs."date"
	from joy_bonus_summaries jbs  
		left outer join memberships m on jbs.user_id = m.uid and jbs."owner" = m."owner"  
	where jbs.wid = 325
		 and m.username in ('dewapu2009561',
								'holil0412631',
								'mamans2907761',
								'waqiah0809391',
								'joy201741',
								'indram0911961',
								'pauzia211022',
								'margar1611501',
								'mamans2907761',
								'ahmada2104591',
								'esters0412451',
								'darwin020280',
								'rosmay0811311',
								'triwin250412',
								'hasisa1801421',
								'joy201741',
								'pebip.200264',
								'bahija1003871',
								'rosfin1105421',
								'joy201741',
								'mamans2907761',
								'pauzia211022',
								'widian2308561',
								'muhamm0502541',
								'maryan150349',
								'myusri0104951',
								'diniwi230132',
								'joy201741',
								'abidin1511131',
								'dedesa0912191',
								'indra120289',
								'nuryan171272',
								'mamans2907761',
								'mamans2907761',
								'abubak0208201',
								'mocham0409911',
								'suward2512921',
								'suward2512921',
								'muhidi1404991',
								'meilan0502321',
								'joy201741',
								'yuliar310734',
								'jonels1709751',
								'rutpin301034',
								'indram0911961',
								'indram0911961',
								'nining2507921',
								'yohana1303861',
								'joy201741',
								'niakur0309531',
								'supriy15053',
								'meilan0502321',
								'indram0911961',
								'sukart010728',
								'indram0911961',
								'muarif180323',
								'ekasem110394',
								'meilan0502321',
								'burhan250557',
								'meilan0502321',
								'naomip140597',
								'dedesa0912191',
								'ponowi130234',
								'yulian090644',
								'seseko270352',
								'darwin020280',
								'sobihi1001191',
								'soeron0910721',
								'putude2806311',
								'kadekk300756',
								'endang220246',
								'endang220246',
								'dedeku2901131',
								'herna301068',
								'yulian2106521',
								'jonels1709751',
								'karwat1602461',
								'karwat1602461',
								'nurakb0602121',
								'herlin170253',
								'mardia1308971',
								'effend0412251',
								'moch140540',
								'burhan250557',
								'herna301068',
								'hjadem0502951',
								'noviya0502201',
								'mamans0502831',
								'mamans0502831',
								'widian2308561',
								'joysup100919',
								'muarif180323',
								'joy201741',
								'joysup100919',
								'erwin0311861',
								'joysys16',
								'enriad0311211',
								'saiful0606871',
								'joysup100919',
								'enriad0311211',
								'joysup100919',
								'joysup100919',
								'ananda2807901',
								'suli1409721',
								'fikrin0107721',
								'suyitn3010141',
								'hashif2003721',
								'khusnu1209421',
								'erwin0311861',
								'joysys16',
								'joysys16',
								'erwin0311861',
								'enriad0311211',
								'erwin0311861',
								'joysys16',
								'alfrid0407851',
								'pebip.200264',
								'ipanka1111751',
								'mohamm160986',
								'rizkyn12092',
								'enriad0311211',
								'baguse2408721',
								'erwin0311861',
								'asmara070862',
								'agussu180450',
								'ananda2807901',
								'alfrid0407851',
								'asmara070862',
								'franky1110191',
								'desakn240694',
								'inyoma140279',
								'ananda2807901',
								'ananda2807901',
								'joysup100919',
								'enriad0311211',
								'joysys16',
								'khairu191098',
								'nurhas211126',
								'waoder051134',
								'ipanka1111751',
								'supriy15053',
								'sastri141029',
								'ekobud071247',
								'ipanka1111751',
								'pebip.200264',
								'ananda2807901',
								'rahman0208931',
								'abuwah290275',
								'wahida121256',
								'nurhas211126',
								'agussu180450',
								'anwar210186',
								'abuwah290275',
								'wahida121256',
								'asmara070862',
								'sastri141029',
								'bungar1201441',
								'rosita070293',
								'abuwah290275',
								'wahida121256',
								'nurhas211126',
								'agussu180450',
								'waoder051134',
								'nazili2705651',
								'rilyan0108161',
								'gilang1807741',
								'gilang1807741',
								'gilang1807741'
							)
	group by  m.username, jbs.user_id, jbs."owner", jbs.wid
--	having count(m.username) > 1
	 order by jbs."owner", sum(jbs.total);
	
	select * from joy_bonus_summaries jbs where "owner" in ('02dbb68d-de44-4466-8223-5bd8ac175541');
select * from memberships m where id=1;
	
	select -- * --"owner", wid, total, voucher, tax, transfer, year_end ;
		jbs.id, jbs."date", jbs.wid, jbs."owner", jbs.xpress, jbs.bgroup, jbs.leadership, jbs.year_end, jbs.total, jbs.voucher, jbs.tax, jbs.transfer
	from joy_bonus_summaries jbs 
	where jbs.wid = 325 
		and jbs."owner" in (
					select m."owner"
					from memberships m 
					where m.username in ('suyitn3010141',
									'indra120289',
									'meilan0502321',
									'meilan0502321',
									'meilan0502321',
									'meilan0502321',
									'darwin020280',
									'darwin020280',
									'sukart010728',
									'indram0911961',
									'indram0911961',
									'indram0911961',
									'indram0911961',
									'indram0911961',
									'endang220246',
									'endang220246',
									'hjadem0502951',
									'burhan250557',
									'burhan250557',
									'yulian090644',
									'abidin1511131',
									'mamans2907761',
									'mamans2907761',
									'mamans2907761',
									'mamans2907761',
									'mamans2907761',
									'kadekk300756',
									'yulian2106521',
									'waqiah0809391',
									'rutpin301034',
									'anwar210186',
									'ekasem110394',
									'muhidi1404991',
									'ahmada2104591',
									'widian2308561',
									'widian2308561',
									'seseko270352',
									'maryan150349',
									'joy201741',
									'joy201741',
									'joy201741',
									'joy201741',
									'joy201741',
									'joy201741',
									'joy201741',
									'inyoma140279',
									'jonels1709751',
									'jonels1709751',
									'ananda2807901',
									'ananda2807901',
									'ananda2807901',
									'ananda2807901',
									'ananda2807901',
									'pebip.200264',
									'pebip.200264',
									'pebip.200264',
									'holil0412631',
									'rilyan0108161',
									'joysup100919',
									'joysup100919',
									'joysup100919',
									'joysup100919',
									'joysup100919',
									'joysup100919',
									'hashif2003721',
									'dewapu2009561',
									'muarif180323',
									'muarif180323',
									'rosfin1105421',
									'saiful0606871',
									'sastri141029',
									'sastri141029',
									'nining2507921',
									'enriad0311211',
									'enriad0311211',
									'enriad0311211',
									'enriad0311211',
									'enriad0311211',
									'supriy15053',
									'supriy15053',
									'suward2512921',
									'suward2512921',
									'pauzia211022',
									'pauzia211022',
									'herna301068',
									'herna301068',
									'nurhas211126',
									'nurhas211126',
									'nurhas211126',
									'alfrid0407851',
									'alfrid0407851',
									'asmara070862',
									'asmara070862',
									'asmara070862',
									'khairu191098',
									'yuliar310734',
									'karwat1602461',
									'karwat1602461',
									'erwin0311861',
									'erwin0311861',
									'erwin0311861',
									'erwin0311861',
									'erwin0311861',
									'herlin170253',
									'ponowi130234',
									'myusri0104951',
									'waoder051134',
									'waoder051134',
									'rahman0208931',
									'bahija1003871',
									'niakur0309531',
									'mamans0502831',
									'mamans0502831',
									'putude2806311',
									'mohamm160986',
									'bungar1201441',
									'abuwah290275',
									'abuwah290275',
									'abuwah290275',
									'dedeku2901131',
									'ekobud071247',
									'nuryan171272',
									'mocham0409911',
									'yohana1303861',
									'diniwi230132',
									'rosmay0811311',
									'nazili2705651',
									'nurakb0602121',
									'desakn240694',
									'rizkyn12092',
									'dedesa0912191',
									'dedesa0912191',
									'effend0412251',
									'sobihi1001191',
									'naomip140597',
									'wahida121256',
									'wahida121256',
									'wahida121256',
									'agussu180450',
									'agussu180450',
									'agussu180450',
									'franky1110191',
									'esters0412451',
									'joysys16',
									'joysys16',
									'joysys16',
									'joysys16',
									'joysys16',
									'hasisa1801421',
									'triwin250412',
									'muhamm0502541',
									'rosita070293',
									'soeron0910721',
									'gilang1807741',
									'gilang1807741',
									'gilang1807741',
									'khusnu1209421',
									'mardia1308971',
									'baguse2408721',
									'abubak0208201',
									'noviya0502201',
									'margar1611501',
									'fikrin0107721',
									'suli1409721',
									'moch140540',
									'ipanka1111751',
									'ipanka1111751',
									'ipanka1111751'
)
							and jbs.id not in (114043,114000,114062)
							and jbs.total > 0
--							and m.username not in ('joysys18','andhik0601181','rilyan0108161','desi14047','mohammad171260','agusev020889')
		)
		and jbs.deleted_at is null
	order by jbs."owner", jbs.voucher, jbs.total ; --jbs.id, 
	--	END UPDATE PPH BONUS JOYPLAN

-- ============================================================================================
-- END UPDATE TAX/PPH
-- ============================================================================================



-- HAPUS SHHIPING COST
select code_trans,shipping_cost, status, transaction_date 
from "transaction" t 
where code_trans in ('GWFKQN',
'TFGMFC',
'WDF3MP',
'8SYLR9',
'67AOXO');

update "transaction" 
set shipping_cost = 0
where code_trans in ('UTXFNP', 'NFNECR', '9VSGHI', 'IVX4O1');

select * from "transaction" t where id_cust_fk = 37434 order by transaction_date ;


select * from memberships m where username ilike 'mjefry010838';

select *
from users u 
where username in ('mjefry010838');

select * from users u where nama ilike '%fer% arifin%';

select * from users u where alamat ilike lower('%KUANTAN REGENCY NOGOTIRTO NO. D1 JL. NOGOSAREN BARU%')

select * from "transaction" t where id_cust_fk in (28066);
	



select * from users u where username ilike '%suwono2901221%';
select * from memberships m where username ilike '%suwono2901221%';
select * from memberships m where spid  = 31839 order by activated_at  desc;


select * from users u  where username ilike '%didhin10591%';


select * from week_periodes wp order by id desc ;

select * from memberships m where username = 'indram0911961';



select * from barang b where nama ilike 'JoyCoffee (J39)';





select 
--		pdj.wid, 
		u.nama, 
--		pdj.wid , wp.id , 
--		wp."eDate", 
		to_char(wp."eDate", 'YYYY-MM') as "Period",
		pdj.jbid, pdj.omzet, 
		pdj.ppv, pdj.gpvj,
		pdj.ppv + pdj.gpvj total_pv
--		,wp."name" 
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.jbid = 22115169320 
order by pdj.wid  desc;

select max(jbid) from memberships m limit 1;

select * from week_periodes wp order by id desc;

select * from users u  where username ='eenrae0309121';
select * from memberships m where username ='eenrae0309121';

select * from sranks s where jbid =23095449551; -- old appv = 2376.00


select * from users u  
where username in ('muhamm2410591',
'hjehaj2411851',
'dedehs2812911',
'mamans2410801',
'dedesu2711411',
'saepul2701991',
'noviya3101551',
'hjadem0301341',
'meilan0502321',
'muhamm0502541',
'hjehaj0502401',
'dedehs0502571',
'mamans0502831',
'dedesu0502961',
'saepul0502481',
'noviya0502201',
'hjadem0502951'
);



select * from users u where nama = 'Hila Sc-001' or email ilike 'hilal%@%.com';

select * from memberships m where username in ('hilal21101611','hilasc0702251') or jbid in (23085429739);


select * from fee_pucs fp order by "date" desc ;
select t.id , t.code_trans , t.total_price, t.bv_total, td.id_barang_fk, td.qty, td.base_price, td.bv 
from "transaction" t 
	 inner join transaction_detail td on t.id = td.id_trans_fk 
where t.code_trans in ('J2KI7G');

select * from transaction t where pickup_code  in ('ZY8XMG'); 
select * from transaction_detail td where id_trans_fk in (133102); 

select * from stock_pack_pickeds spp where pick in ('ZY8XMG');

select * from stock_pack_stocks sps;


select * from budget_reserves br order by "date"  desc;



select * from users u where username in ('budiwa0409571','budiwa0502621') or nama ilike '%li%jemm%';

select * from memberships m where m.username = 'nuryan171272';

select * from joy_point_reward_cashes jprc where jprc."owner" = 'bbb318cd-2b1e-4c3b-a3d9-7419f9cfac38' order by "date" desc;








-- TERMINATE SOP
 -- DOWNGRADE to SC; from SSH
-- UDPDATE CARRY FORWARD
select * from joy_r_v_forwards jrvf --where "owner"::text ilike '808361%' order by id desc;
where jrvf."owner" IN (
	select * from memberships m where username ILIKE ANY(ARRAY['%mulast1803661','risno1309871'])
	or jbid in (21074713651,21074713782,21114860361)
);


select * from carry_forward_details cfd -- order by id desc;
where cfd."owner" IN (
	select *  from memberships m where username ILIKE ANY(ARRAY['%elfina0108261','%mulast1803661','%sitinu120226'])
);

select * from memberships m where "owner" = '808361ac-44f8-44ad-9d0e-3e70176f3b39' or uid ='808361ac-44f8-44ad-9d0e-3e70176f3b39';

select username, nama, no_ktp, email, "password", handphone 
from users u 
where username ILIKE ANY(ARRAY['%elfina0108261','%sitinu120226']);



-- UPDATE AKUMULASI BV
select id_cust_fk, sum(pv_total) as pv_total 
from "transaction" t 
where id_cust_fk in (select jbid from memberships m where username in ('risno1309871')) and transaction_date < now()
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID		
group by id_cust_fk ;

select * from sranks r 
where r.jbid  in (
	select  jbid  from memberships m where username ILIKE ANY(ARRAY['risno1309871']))


	
select * from "transaction" t where t.code_trans in ('OYMPG1');