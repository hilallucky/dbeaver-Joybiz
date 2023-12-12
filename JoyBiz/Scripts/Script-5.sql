


-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level,
    		to_char(t1.transaction_date, 'YYYY-MM') as "period",
    		t1.purchase_cost as purchase_cost
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    	left outer join "transaction" t1 on m1.jbid = t1.id_cust_fk
    WHERE 
	    u1.username = 'indram0911961'
--    m1.jbid = 14922

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1,
    		to_char(t2.transaction_date, 'YYYY-MM') as "period",
    		t2.purchase_cost as purchase_cost
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
    	left outer join "transaction" t2 on m2.jbid = t2.id_cust_fk
    	JOIN hierarchy_cte h ON m2.upid = h.jbid
    where h.level < 5
)
--INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level)
SELECT
    ROW_NUMBER() OVER (order by hc.level, hc.upline_name, hc.upid, hc.id) AS row_num,
    hc.id, hc.username, hc.nama, hc.jbid, hc.spid, hc.upid, hc.upline_name, hc.upline_no, hc.level,
    hc."period", sum(hc.purchase_cost) as purchase_cost
FROM hierarchy_cte hc
group by 
    hc.id, hc.username, hc.nama, hc.jbid, hc.spid, hc.upid, hc.upline_name, hc.upline_no, hc.level,
    hc."period"
ORDER BY hc.level, hc.upline_name, hc.upid, hc.id
;





































WITH RECURSIVE DownlineHierarchy AS (
  SELECT
    m.id AS member_id,
    m.fullname AS fullname,
    m.sponsor_id,
    t.amount AS transaction_amount
  FROM test_member m
  	LEFT JOIN test_transaction t ON m.id = t.member_id

  UNION ALL

  SELECT
    m.id AS member_id,
    m.fullname AS fullname,
    m.sponsor_id,
    t.amount AS transaction_amount
  from test_member m
	JOIN test_transaction t ON m.id = t.member_id
	JOIN DownlineHierarchy d ON m.id = d.sponsor_id
)

SELECT
  member_id,
  COALESCE(SUM(transaction_amount), 0) AS total_transaction_amount
FROM  DownlineHierarchy
GROUP BY  member_id
ORDER BY  member_id;




select * 
from users u 
where 
	 alamat ilike '%Jl.RE.Martadinata no.02 rt 07/rw 02'
	 or u.no_ktp ='1571016106730001' 
	or username ilike 'Bessew210665';








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
--    "period" timestamp(0), 
    group_purchase numeric(10,2)
);

-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT m1.id, m1.username, u1.nama, m1.jbid, m1.spid, m1.upid, cast('' AS VARCHAR) AS upline_name, 0 AS upline_no, 0 as level --,
--		    to_char(t1.transaction_date, 'YYYY-MM') as "period",
    		COALESCE(SUM(t1.purchase_cost), 0) as group_purchase
    FROM memberships m1
    	left outer join users u1 on m1.username = u1.username
    	left outer join "transaction" t1 on m1.jbid = t1.id_cust_fk
    WHERE 
	    u1.username = 'indram0911961'
--    m1.jbid = 14922
	    and to_char(t1.transaction_date, 'YYYY-MM') = '2023-11'

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1,
--		    to_char(t2.transaction_date, 'YYYY-MM') as "period",
--    		h.group_purchase + t2.purchase_cost as group_purchase
    		COALESCE(SUM(h.group_purchase + t2.purchase_cost), 0) as group_purchase
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
    	JOIN hierarchy_cte h ON m2.upid = h.jbid
    	left outer join "transaction" t2 on m2.jbid = t2.id_cust_fk
    where 
--    	h.level < 3
    	to_char(t2.transaction_date, 'YYYY-MM') = '2023-11'
)
--INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level, group_purchase)
SELECT
    ROW_NUMBER() OVER (order by level, upline_name, upid, id) AS row_num,
    id, username, nama, jbid, spid, upid, upline_name, upline_no, level 
--    COALESCE(SUM(group_purchase), 0) AS total_group_purchase
FROM hierarchy_cte
ORDER BY level, upline_name, upid, id;

-- Step 3: Query the temporary table to retrieve the results
SELECT tp.row_num, tp.id, tp.username, tp.nama, tp.jbid, tp.spid, tp.upid, tp.upline_name, (select t.row_num from tree_path t where t.jbid = tp.upid) as upline_no, tp.level
FROM tree_path tp
--where username = 'nuryan171272'
ORDER BY tp.row_num;  

-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;


