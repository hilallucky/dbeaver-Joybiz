select * from users u 
where u.nama ilike '%makbul%';

-- ini query untuk tarik data point cash reward
select u.nama, ms.username, u.handphone, sum(jc.joy) as point_reward_joy, sum(jc.biz) as point_reward_biz, sum(jc.biz + jc.joy) AS total
	-- jc.joy,jc.biz, jc."date"-- 
from joy_point_reward_cashes jc
	join memberships ms on jc.owner = ms.uid 
	join users u ON ms.uid = u.uid
where jc."date" between  '2022-12-29'and '2023-12-07' and jc.deleted_at is null
and jc.deleted_at is null
and u.username ilike 'agusev020889' 
group by u.nama, ms.username, u.handphone
order by  total desc;


select * from users u where username like 'muarif180323';
select * from memberships m where username like 'muarif180323';


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


-- CHECK QUALIFIKASI TURKIYE (PONT REWARDS) -- MIN PERINGKAT GAMMA, TOTAL POINT REWARDS MIN 250 -- POS 1
select ms.username, 
	u.nama, u.handphone, 
	sum(jp.joy) as point_reward_joy, sum(jp.biz) as point_reward_biz, sum(jp.biz + jp.joy) as total,
	case 
		when sum(jp.biz + jp.joy) between 250 and 499.999 then 'POS 1'
		when sum(jp.biz + jp.joy) >= 500 then 'POS 2'
	end
from joy_point_rewards jp
	join memberships ms on jp.owner = ms.uid 
	left outer join users u on ms.uid = u.uid or ms."owner" = u.uid 
where jp."date" BETWEEN '2022-12-29'and now()::date and jp.deleted_at is null
	and jp.deleted_at is null
--	and ms.username ='bessew210665'
group by ms.username, u.nama, u.handphone
having sum(jp.biz + jp.joy) >= 250 --between 200 and 249-- 
order by point_reward_joy asc;

-- CHECK QUALIFIKASI CASH REWARDS
select u.nama, ms.username, u.handphone, sum(jc.joy) as point_reward_joy, sum(jc.biz) as point_reward_biz, sum(jc.biz + jc.joy) AS total, 'CASH REWARD'
from joy_point_reward_cashes jc
	join memberships ms on jc.owner = ms.uid 
	left outer join users u on ms.uid = u.uid or ms."owner" = u.uid 
where jc."date" between '2022-12-29'and now()::date
--	and ms.username ='ridwan0807538'
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
    WHERE lower(m1.username) = lower('esters040219') --jbid = 26
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


select * from users u where username ='nuryan171272';

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
    lower(u1.username) = lower('Laodep160554')
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
    WHERE lower(u1.username) ilike 'humaidi%' -- in ('humaidi0908411')
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
    WHERE lower(u1.username) in ('humaidi0908411')
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



-- LIST POLA TURBO
SELECT 
--		ROW_NUMBER() OVER (order by sr.srank, ms.activated_at desc) as "No", 
		ms.username as "Username", u.nama as "Nama", sr.srank as "Rank", 
		ms.activated_at as "Activated At", AGE(ms.activated_at) as "Joint Duration",
		case 
			when AGE(now(), ms.activated_at) > INTERVAL '3 months' then '> 3 months' 
			else null 
		end as "Remarks"
--		,(DATE_PART('YEAR', now()::DATE) - DATE_PART('YEAR', ms.activated_at::DATE)) * 12
--		+ (DATE_PART('Month', now()::DATE) - DATE_PART('Month', ms.activated_at::DATE)) AS month_diff
--		,ms.spid, ms.jbid 
FROM memberships ms
	join users u on u.username = ms.username 
	JOIN sranks sr ON ms.jbid = sr.jbid
WHERE ms.spid = (select m.jbid from memberships m where lower(m.username) = lower('muhamm2003691'))
	--22115186779 --= 23075375780 --nama ilike '%qurrotun%'
	 AND sr.srank >= 1 
--	and AGE(now(), ms.activated_at) < INTERVAL '3 months' 
	 or lower(ms.username) -- ILIKE ANY(ARRAY[
	 in (
	 lower('muhamm2003691')
)
--	])
ORDER BY case 
			when AGE(now(), ms.activated_at) > INTERVAL '3 months' then '> 3 months' 
			else null 
		end ,
	ms.jbid, sr.srank, ms.activated_at desc;

select 5500*1500

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


-- UBAH SPONSOR/ALAMAT
select ID,nama,  username, email, handphone, alamat, kelurahan, kecamatan, kota_kabupaten, provinsi, status , no_npwp, 
	id_bank_fk, bank_name, bank_acc_num, bank_acc_name, created_at, activated_at 
from users u 
where 
	username in ('mellag0501311') -- or 
--	username ilike 'zalimi0301211' -- or username ilike 'andang0812121%' or username ilike 'budisa0812841%'; 
--	 email in ('atisanti77@gmail.com','daraesanr@gmail.com','yanakayaraya@gmail.com','iamulyaningsih262@gmail.com','agusmpasya@gmail.com');
;

select * 
from users u  
where username ilike '%delete'
--	username in ('erlian0712901','annisa2111341', 'bintan1511651')
	username in ('annisa2111341') or 
	username ilike 'dewire0812211%' or username ilike 'andang0812121%' or username ilike 'budisa0812841%' 
order by id ;

select u.username, u.nama, u.activated_at::date
from users u 
where u.username in ('muksin3012511',
'indrak29117013'
);

select username, jbid, spid, upid, "left", "right" , "owner" ,created_at, activated_at, status,flag, deleted_at 
from memberships m 
where 
--	username ilike 'kari0512711' -- or username ilike 'dewire2206881%' or username ilike 'andang2508341%' -- old
--	username ilike 'Surian0712541' --or username ilike 'andang0812121%' or username ilike 'budisa0812841%' -- new
--	username ilike'esters0412451%' -- or username  = 'liamul0112761'
--	or 
--	username in ('esters0412451','effend0412251','daniel0412291','afriya0412581') -- or jbid = 23105527852
	username in ('mellag0501311','lusian1112541') 
--	or jbid in (23115572236)
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

select jbid, spid, upid, appv, srank, created_at, updated_at  
from sranks s 
where  jbid in (23125575615,24015613640
) 
order by jbid ;

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
select  * from "transaction" t where code_trans ilike 'NU9ZDM%';
select  * from transaction_detail td where id_trans_fk in (144854);


select * from barang b where nama ilike lower('%Free Joy Coffee%');

select * from transaction t where t.code_trans ilike 'CUFOZQ%' order by id;
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
select id, code_trans, transaction_date, courier, deleted_at, status from "transaction" t where code_trans in ('1WM4UF');
select * from transaction_detail td where id_trans_fk =145268;

select t.code_trans, status, is_pickup, shipping_name, shipping_phone, shipping_address,
		shipping_city, shipping_province, shipping_village, shipping_district, shipping_cost 
from "transaction" t where t.code_trans in ('BBE2P0','VSEWCP','5CZDBF','PAIH7Z','MW4LOC','VE2K3H','LXPXED') ;
--select * from alamat_provinsi ap;
select * from alamat_kabupaten ak2 where kabupaten ilike '%depok%'; ;--id in (3209, 3404);--
select * from alamat_kecamatan ak where id_kabupaten in (3276);-- kecamatan ilike '%depok%';
select * from alamat_kelurahan ak where id_kecamatan = 3276050; -- kelurahan ilike 'beji';

-- UBAH NO REKENING
select * from memberships m where username ='desriy2803141';
select id, username, nama, id_bank_fk, bank_name , bank_acc_name, bank_acc_num, no_npwp  from users u where username ilike 'desriy2803141'; -- in ('desry2803141');
select * from bank b;

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
select code_trans, status, is_pickup, pickup_stock_pack  from "transaction" t where code_trans = 'ULXU7K';


-- UBAH NO HP PENGIRIMAN
select * from users u where username ='mambau1211961';
select * from "transaction" t where code_trans = 'ZVSA4H';
select * from transaction_detail td where id_trans_fk = '144376';
select * from tra td where id_trans_fk = '144376';

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
select u.id, u.username, u.email, u.no_ktp, u.handphone, u.bank_name, u.bank_acc_num, u.disabled, u.activated_at, u.status  
from users u
where 

u.username in ('esters0412451') or u.username ilike 'irnide0511461%'; 

select m.id, m.username, m.jbid, m.spid, m.upid, m."left", m."right", m.activated_at, m.status  
from memberships m 
where m.username in ('dewire08122112','dewire08122113')
--	m.username in ('daniel0412291', 'effend0412251') or m.username ilike 'esters0412451%' or m.username ilike 'afriya0412581%'
order by m.id;

select * from sranks s where jbid in ('23125583242','23125583276');
select * from eranks e where jbid in ('23125583232','23125583376');

23125583276 23125583232	23125583232

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

select * from "transaction" t where code_trans ='DDPDMC';
select * from barang where nama ilike '%Joybizer (J31%'; --1063 R05J31	Joybizer (J31)
select * from transaction_detail td where id_trans_fk in (144756);


select id, code_trans, deleted_at, transaction_date  from "transaction" t where code_trans in ('UBGBVN','GOGR5F');
select * from transaction_detail td where id_trans_fk =145713;



select * from "transaction" t where id_cust_fk = 4 order by created_at desc;



-- START CHECK TIKET ACARA TERJUAL
SELECT tr.code_trans, tr.transaction_date, ms.username AS Buyer, td."name" AS barang , tr.status, td.qty 
FROM "transaction" tr
	JOIN transaction_detail td ON tr."id" = td.id_trans_fk
	JOIN memberships ms ON tr.id_cust_fk = ms.jbid
WHERE td.id_barang_fk IN(1625) 
	AND tr.transaction_date BETWEEN '2022-03-01' AND '2024-01-02' 
	AND tr.transaction_date IS NOT NULL 
	AND tr.deleted_at IS NULL
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



select * from week_periodes wp ;

select username, uid  
from memberships m  
where m.username in ( 'joy201741');

select "owner", wid, total, voucher, ppn, total_transfer 
from bonus_weeklies bw 
where wid = 314
	and "owner" in ( '38d2d0af-14bd-4f38-bd44-5e708dac8026')
 order by id, "owner" 
;
select * --"owner", wid, total, voucher, tax, transfer, year_end 
from joy_bonus_summaries jbs 
where wid = 314
	and "owner" in ( '38d2d0af-14bd-4f38-bd44-5e708dac8026')
	and deleted_at is null
order by id, "owner", total ; 



-- HAPUS SHHIPING COST
select code_trans,shipping_cost
from "transaction" t 
where code_trans in ('UTXFNP', 'NFNECR', '9VSGHI', 'IVX4O1');

update "transaction" 
set shipping_cost = 0
where code_trans in ('UTXFNP', 'NFNECR', '9VSGHI', 'IVX4O1');



