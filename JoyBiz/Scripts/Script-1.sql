--select now() as "sekarang";

/*
	Note : 
	Kode produk :
	Joypolinse : 3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335
	Joymunemax : 4,255,326,457,459,461,463, 747, 823
	Joycell : 119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341
	Joyrazero : 104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337
	Lae Erica : 95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340
	Lae Darbot : 96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339
	Joyzetox ; 54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342
	Facial wash 281, 336, 757, 837, 936, 1009, 1077
	Toner: 280, 335, 756, 836, 935, 1008, 1076
	Day cream:  282, 337, 758, 838, 937, 1010, 1078
	Night cream 283,338, 759, 839, 938, 1011, 1079
	Joypropolis : 309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343
	Joyvit-C: 483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344
	JoyVit-D3 :     696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345
	JoyCoffee:  809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346
	JoyOmega-3: 1294, 1347 
*/

-- EDIT STEP 3
select -- bd.*, 
		t.id_barang_fk as "Product Code", t."name" as "Desc", t.total_barang as "Sold Unit", bd.qty as "Unit (pcs)", t.total_barang * bd.qty "Total Unit Out" 
from barang_detail bd
	 join (
			select td.id_barang_fk, td."name", sum(td.qty) as total_barang
			from "transaction" t
				join transaction_detail td on t.id = td.id_trans_fk
			where 
				td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
					select bd.id_induk_fk
					from barang_detail bd 
--					where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
				) 
				and t.transaction_date BETWEEN '2023-10-26' and '2023-11-30'
--				'2023-08-31' and '2023-09-27'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
where bd.id_barang_fk in (1294, 1347)   
ORDER BY bd.id_induk_fk asc;






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
	    u1.username = 'indram0911961'
--    m1.jbid = 14922

    UNION ALL

    SELECT m2.id, m2.username, u2.nama, m2.jbid, m2.spid, m2.upid, h.nama, 0 AS upline_no, h.level + 1
    FROM memberships m2
    	left outer join users u2 on m2.username = u2.username
    	JOIN hierarchy_cte h ON m2.upid = h.jbid
    where h.level < 3
)
--INSERT INTO tree_path(row_num, id, username, nama, jbid, spid, upid, upline_name, upline_no, level)
SELECT
    ROW_NUMBER() OVER (order by hc.level, hc.upline_name, hc.upid, hc.id) AS row_num,
    hc.id, hc.username, hc.nama, hc.jbid, hc.spid, hc.upid, hc.upline_name, hc.upline_no, hc.level,
    to_char(tr.transaction_date, 'YYYY-MM') as "period",
	case 
		when (tr.deleted_at is not null and tr.status in('PC', 'S', 'A') and to_char(tr.transaction_date, 'YYYY-MM') between '2023-10' and '2023-12') then sum(tr.purchase_cost) else 0
	end as "purchase_cost"
--    sum(tr.purchase_cost) as "purchase_cost", sum(tr.shipping_cost) as "shipping_cost",
--	sum(tr.bv_total) as "bv_total", sum(tr.pv_total) as "pv_total", sum(tr.rv_total) as "rv_total"
FROM hierarchy_cte hc
	left outer join "transaction" tr on hc.jbid = tr.id_cust_fk
--where tr.deleted_at is null
--	  and tr.status in('PC', 'S', 'A') -- , 'I') -- PAID
--	  and to_char(tr.transaction_date, 'YYYY-MM') between '2023-10' and '2023-12'
group by 
    hc.id, hc.username, hc.nama, hc.jbid, hc.spid, hc.upid, hc.upline_name, hc.upline_no, hc.level,
    to_char(tr.transaction_date, 'YYYY-MM'), tr.deleted_at, tr.status 
ORDER BY hc.level, hc.upline_name, hc.upid, hc.id

-- Step 3: Query the temporary table to retrieve the results
SELECT tp.row_num, tp.id, tp.username, tp.nama, tp.jbid, tp.spid, tp.upid, tp.upline_name, (select t.row_num from tree_path t where t.jbid = tp.upid) as upline_no, tp.level
FROM tree_path tp
--where username = 'nuryan171272'
ORDER BY tp.row_num;  

-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;

-- END NETWORK



select *
from "transaction" t 
where t.id_cust_fk = 22115169320;
