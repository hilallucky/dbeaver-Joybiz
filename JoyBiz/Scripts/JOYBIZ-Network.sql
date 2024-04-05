
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
    level int8,
    bnsperiod varchar(10),
    amount numeric(20,0) default 0,
    bv int8 default 0,
    pv int8 default 0,
    xv int8 default 0,
    g_amount numeric(20,0) default 0,
    g_bv int8 default 0,
    g_pv int8 default 0,
    g_xv int default 0
);

-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level
--    		, null as month_period, 0 as bv, 0 as pv, 0 as xv
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
--    	left outer join "transaction" t1 on m1.jbid = t1.id_cust_fk
    WHERE 
    u1.username = 'nizani0602211'
--    m1.jbid = 14922

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1
--    		, h.month_period, h.bv, h.pv, h.xv
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
    	JOIN hierarchy_cte h ON m2.upid = h.jbid
--    	left outer join "transaction" t2 on m2.jbid = t2.id_cust_fk
--    where h.level < 3
)
INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level)
--			, bnsperiod, amount, bv, pv, xv, g_amount, g_bv, g_pv, g_xv)
SELECT
    ROW_NUMBER() OVER (order by level, upline_name, upid, id) AS row_num,
    id, username, nama, jbid, spid, upid, upline_name, upline_no, level
--    ,  hcte.bnsperiod, hcte.amount, hcte.bv, hcte.pv, hcte.xv, hcte.g_amount, hcte.g_bv, hcte.g_pv, hcte.g_xv
FROM hierarchy_cte hcte
ORDER BY level, upline_name, upid, id;

-- Step 3: Query the temporary table to retrieve the results
SELECT *
--	tp.row_num, tp.id, tp.username, tp.nama, tp.jbid, tp.spid, tp.upid, tp.upline_name, (select t.row_num from tree_path t where t.jbid = tp.upid) as upline_no, tp.level
--	, tp.bnsperiod, tp.amount, tp.bv, tp.pv, tp.xv, tp.g_amount, tp.g_bv, tp.g_pv, tp.g_xv
FROM tree_path tp
--where username = 'nuryan171272'
ORDER BY tp.row_num;  

-- start calculate

do $$
	declare 
		row_id integer;
	    max_record integer := 0;
		p_purchase_cost integer := 0;
		p_pv_total integer := 0;
		p_bv_total integer := 0;
		bns_period varchar(10);
	--	yearperiod integer;
	begin
		row_id := 1;
	    while row_id <= (select count(*) from tree_path) loop
--			select 
--				coalesce(sum(t.purchase_cost), 0),
--				coalesce(sum(t.pv_total), 0),
--				coalesce(sum(t.bv_total), 0),
--				to_char(t.transaction_date, 'YYYY-MM')
--			 into p_purchase_cost, p_pv_total, p_bv_total, bns_period
--			from "transaction" t  
--	--			join tree_path tp on tp.jbid = t.id_cust_fk
--			where 
--	--			t.month_period = monthperiod and t.year_period = yearperiod 
--				to_char(t.transaction_date, 'YYYY-MM') = '2023-11' and
--				t.id_cust_fk = (select tp.jbid from tree_path tp where tp.row_num = row_id)
--	     	group by to_char(t.transaction_date, 'YYYY-MM');
--	     	
--			update tree_path set bnsperiod = bns_period, amount = p_purchase_cost, pv = p_pv_total, bv = p_bv_total where row_num = row_id;
	  
			--  start update purchase to upline
			  WITH RECURSIVE cte AS (
			     select t1.row_num, t1.username, t1.jbid, t1.upid, t1.spid, t1.amount as p_amount, amount as g_amount_x
			     FROM tree_path t1 
			     WHERE t1.row_num = row_id
			     
			     UNION
			     
			     SELECT t2.row_num, t2.username, t2.jbid, t2.upid, t2.spid, t2.amount as p_amount, t2.g_amount + t2.amount as g_amount_x
			     FROM tree_path t2
			      JOIN cte cte ON t2.jbid = cte.upid
			 )
			 
			 update tree_path 
			 set g_pv = cte.g_pv, g_bv = cte.g_bv, g_amount = cte.g_amount_x
			 from cte 
			 where tree_path.jbid = cte.jbid;
		
			 --  end update purchase to upline  
	    
	       
			raise notice 'Member ID =  %, p_amount = %, year-month %', row_id, row_id, bns_period;
			row_id := row_id + 1;
	    end loop;
  end$$;
  -- end calculate



-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;

-- END NETWORK







/*

select * from "transaction" t where id_cust_fk = 21094807831 and t.transaction_date is not null order by transaction_date desc;



-- SHOW ALL UPLINES BASED ON ID MEMBER -- OPTION 1
WITH RECURSIVE upline_cte AS (
    select  m1.id, m1.username, m1.jbid, u1.nama, 
    		m1.spid, 
    		m1.upid, -- mup1.username as up_username, sup1.nama as up_nama,
    		t1.transaction_date, t1.bv_total,
    		ROW_NUMBER() OVER (PARTITION BY m1.id ORDER BY t1.transaction_date DESC) AS row_num
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    	join transaction t1 on t1.id_cust_fk = m1.jbid 
    	-- left outer join memberships mup1 on mup1.jbid = m1.upid
    	-- left outer join users sup1 on mup1.username = sup1.nama
    WHERE lower(u1.username) in (
				'syefri260170')
		and t1.transaction_date is not null
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
		u.transaction_date, AGE(u.transaction_date) as "Last Order Age", u.bv_total
FROM upline_cte u 
where u.row_num = 1
ORDER BY u.id, u.username, u.transaction_date DESC;



-- SHOW ALL UPLINES BASED ON ID MEMBER -- OPTION 2
WITH RECURSIVE upline_cte AS (
    select  distinct  on (m1.username) m1.id, m1.username, m1.jbid, m1.spid, m1.upid, u1.nama, t1.transaction_date, t1.bv_total
    FROM memberships m1
    	join users u1 on m1.username = u1.username
    	join transaction t1 on t1.id_cust_fk = m1.jbid 
    WHERE lower(u1.username) in (
				'anisha2211511')
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



select *
from tree_path t;

*/


WITH RECURSIVE sponsor_cte AS (
    select  distinct  on (m1.username) m1.id, m1.username, m1.jbid, m1.spid, m1.upid --, u1.nama
    FROM memberships m1
--    	join users u1 on m1.username = u1.username
    WHERE lower(m1.username) in ('joysys18')
    UNION
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid --, u2.nama
    FROM memberships m2
--    	left outer join users u2 on m2.username = u2.username
	    JOIN sponsor_cte ucte ON m2.jbid = ucte.spid
--    WHERE t2.transaction_date is not null
)
select id, username, jbid, spid, upid
FROM sponsor_cte u 
order by id desc;
--ORDER BY u.username, u.transaction_date DESC;


select * from "transaction" t where t.id_cust_fk in (22055054987) order by id desc;

do 
$$
	declare 
	    xusername text := 'atiksa181132';
		_query text;
		_cursor CONSTANT refcursor := '_cursor';
	begin
		_query := 'select ''' || xusername ||''' as "col1";';
	
		OPEN _cursor FOR EXECUTE _query;
	end
$$;
FETCH ALL FROM _cursor;


-- =====================================================================================================================================================================
-- START CHECK UPLINE & LATEST ORDER
-- =====================================================================================================================================================================

do 
$$
	declare 
	    xusername text := 'ayuros2804701';
		_query text;
		_cursor CONSTANT refcursor := '_cursor';
	begin
		_query := 'WITH RECURSIVE upline_cte AS (
			    select  distinct  on (m1.username) ''' || xusername || '''  as x, m1.id, m1.username, m1.jbid, m1.spid, m1.upid
			    FROM memberships m1
			    WHERE lower(m1.username) in (''' || xusername || ''')
			    UNION
			    SELECT ucte.x, m2.id, m2.username, m2.jbid, m2.spid, m2.upid
			    FROM memberships m2
				    JOIN upline_cte ucte ON m2.jbid = ucte.upid
			)
			select distinct on (u.x, u.id) u.x as "source_user", u.id, u.username, --u.jbid, u.spid, u.upid, 
				t1.t_date, t1.code_trans, t1.status, t1.bv_total, AGE(now(), t1.t_date) ,
				case 
					when AGE(now(), t1.t_date) > INTERVAL ''1 year'' then ''> 1 year''
					when (t1.bv_total < 0 or t1.bv_total is null) then ''> 1 year''
					else '''' 
				end as "age of transaction"
			FROM upline_cte u 
				 left outer join (
				 		select distinct on (tx.id_cust_fk) tx.id_cust_fk, max(tx.transaction_date) as t_date, tx.code_trans, tx.status, tx.bv_total
				 		from "transaction" tx
				 		where tx.status in(''PC'', ''S'', ''A'', ''I'') 
				 		group by tx.id_cust_fk, tx.code_trans, tx.status, tx.bv_total
				 	) t1 on u.jbid = t1.id_cust_fk --and t.code_trans = t1.code_trans 
			order by u.x, u.id desc;';
		
		
		OPEN _cursor FOR EXECUTE _query;
	end
$$;
FETCH ALL FROM _cursor;

-- =====================================================================================================================================================================
-- END CHECK UPLINE & LATEST ORDER
-- =====================================================================================================================================================================

select * from stock_packs sp 

select max(t.transaction_date) as "t_date", t.bv_total as "bv_total", t.status, t.code_trans
from "transaction" t 
where t.id_cust_fk = 22055054987
group by t.bv_total, t.status, t.code_trans
order by max(t.transaction_date) desc
limit 1;


select * from memberships m  where jbid = 22095123936;


select 
--		wp.id, pdj.wid, wp."sDate", wp."eDate" , 
		to_char(wp."sDate", 'YYYY-MM') as "sDate_period",
--		to_char(wp."eDate", 'YYYY-MM') as "eDate_period",
		pdj.jbid, m.username, u.nama, 
		coalesce(sum(pdj.omzet), 0) as g_omzet, 
		coalesce(sum(pdj.ppv), 0) as g_pv,  
		coalesce(sum(pdj.pbv), 0) as g_bv, 
		coalesce(sum(pdj.gpv), 0) as g_pv, 
		coalesce(sum(pdj.gbv), 0) as g_bv
from prepared_data_joys pdj 
	 join week_periodes wp on pdj.wid = wp.id 
	 join memberships m on pdj.jbid = m.jbid 
	 join users u  on m.username = u.username 
where pdj.jbid in (22115169320,22115172514,23075169327,23075387390)
group by to_char(wp."sDate", 'YYYY-MM'),
		pdj.jbid, m.username, u.nama
order by to_char(wp."sDate", 'YYYY-MM'), pdj.jbid;


-- GET UPLINE
WITH RECURSIVE descendants AS (
    SELECT id, username, jbid, spid, upid, 0 AS depth, "owner"
    FROM memberships m1
    WHERE lower(m1.username) in ('rohime07034') -- root khusnu1209421 right khusnu12094212 left khusnu12094213
UNION    
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, d.depth+ 1, m2."owner"
    FROM memberships m2
    	 inner join descendants d on m2.jbid = d.spid
)
SELECT d.id, d.username, u.nama, m.username as sp_name, d.jbid, d.spid, d.upid, d.depth, d."owner"
FROM descendants d
	left outer JOIN users u ON d."owner" = u.uid
	inner join memberships m on d.spid = m.jbid
order by d.id
;


-- GET DOWNLINE
WITH RECURSIVE descendants AS (
    SELECT id, username, jbid, spid, upid, 0 AS depth, "owner"
    FROM memberships m1
    WHERE lower(m1.username) in ('yessya1910121') -- root khusnu1209421 right khusnu12094212 left khusnu12094213
UNION    
    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, d.depth+ 1, m2."owner"
    FROM memberships m2
    	 inner join descendants d on m2.spid = d.jbid
)
SELECT d.id, d.username, u.nama, m.username as sp_name, d.jbid, d.spid, d.upid, d.depth, d."owner"
FROM descendants d
	left outer JOIN users u ON d."owner" = u.uid
	inner join memberships m on d.spid = m.jbid
order by d.id
;





-- GET ALL DOWNLINES
WITH RECURSIVE cte (id, username, jbid, spid, "depth", "owner") as (
	select m.id , m.username, m.jbid, m.spid, 0 AS depth, m."owner" 
	from memberships m  
	where m.username = 'khusnu1209421'
  	UNION ALL
	select m.id , m.username, m.jbid, m.spid, cte.depth+ 1, m."owner" 
	from memberships m  
		INNER JOIN cte ON m.spid = cte.jbid
)
SELECT cte.id , cte.username, u1.nama , cte.jbid, cte.spid, cte."depth", cte."owner"
FROM cte
	inner join users u1 on cte."owner" = u1.uid 
--	inner join users u2 on cte."owner" = u2.uid 
order by cte.depth, cte.id
;


select * from memberships m where spid = '22095123975';



