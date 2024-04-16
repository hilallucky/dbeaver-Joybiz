-- START UPDATE STOCK PUC/MPU
SELECT * FROM stock_packs sp where code = 'MPUC001'; -- 10


select * 
from stock_pack_stock_details spsd 
where 
--	tcode in ('MPUC001') 
	jspid in ('MPUC004')
;

select *
from stock_pack_stocks sps 
where jspid in ('MPUC001') and pcode in ('E002LAE1EB','E002LAE1DB');
-- END UPDATE STOCK PUC/MPU



select t.created_at, t.transaction_date, t.pickup_stock_pack, t.status, t.id, t.code_trans, td.id_barang_fk, b.kode, td."name", td.qty, t.is_pickup  
from "transaction" t 
	inner join transaction_detail td on t.id = td.id_trans_fk 
	inner join barang b on td.id_barang_fk = b.id 
where 
	t.status in('PC', 'S', 'A', 'I') -- PAID
	and t.deleted_at is null
	and t.is_pickup = 1 -- PICKUP PUC/MPU
	and t.pickup_stock_pack in ('MPUC004')
--	created_at >= '2024-02-12'	
--	and
;


select tx.*, bd.id_barang_fk, bd.product_code, b2.nama , bd.qty, tx.qty_transaction * bd.qty as "total" 
from (
		select t.pickup_stock_pack, sp."name", td.id_barang_fk as "id_barang", b.kode, td."name", sum(td.qty) as "qty_transaction"  
		from "transaction" t 
			inner join transaction_detail td on t.id = td.id_trans_fk 
			inner join barang b on td.id_barang_fk = b.id 
			inner join stock_packs sp on t.pickup_stock_pack = sp.code 
		where 
			t.status in('PC', 'S', 'A', 'I') -- PAID
			and t.deleted_at is null
			and t.is_pickup = 1 -- PICKUP PUC/MPU
			and t.pickup_stock_pack in ('MPUC004')
		group by t.pickup_stock_pack, sp."name", td.id_barang_fk, b.kode, td."name"
--		order by td."name"
	) as tx
	left outer join barang_detail bd on tx.id_barang = bd.id_induk_fk  
	left outer join barang b2 on bd.id_barang_fk = b2.id 
	order by tx.kode
;



select tx.pickup_stock_pack, tx.puc_name, -- tx.id_barang, tx.kode, tx.name, sum(tx.qty_transaction), 
		bd.id_barang_fk, --bd.product_code, 
		b2.nama, --sum(bd.qty), 
		sum(tx.qty_transaction * bd.qty) as "total" 
from (
		select t.pickup_stock_pack, sp."name" as "puc_name", td.id_barang_fk as "id_barang", b.kode, td."name", sum(td.qty) as "qty_transaction"  
		from "transaction" t 
			inner join transaction_detail td on t.id = td.id_trans_fk 
			inner join barang b on td.id_barang_fk = b.id 
			inner join stock_packs sp on t.pickup_stock_pack = sp.code 
		where 
			t.status in('PC', 'S', 'A', 'I') -- PAID
			and t.deleted_at is null
			and t.is_pickup = 1 -- PICKUP PUC/MPU
			and t.pickup_stock_pack in ('MPUC004')
		group by t.pickup_stock_pack, sp."name", td.id_barang_fk, b.kode, td."name"
--		order by td."name"
	) as tx
	left outer join barang_detail bd on tx.id_barang = bd.id_induk_fk  
	left outer join barang b2 on bd.id_barang_fk = b2.id 
group by tx.pickup_stock_pack, tx.puc_name,  
		bd.id_barang_fk, --bd.product_code, 
		b2.nama 
order by b2.nama --tx.kode
;



select * from stock_pack_stock_details spsd where pcode = 'B001B' and jspid = 'MPUC004';


select s.jspid, s.pcode, b.id, b.kode, b.nama, s."in", -- s.qty
	sum(s.qty) as qty --,
--	sum(case when s."in" = true then s.qty end) as qty_in, 
--	sum(case when s."in" = false then s.qty end) as qty_out -- s.tcode, 
from stock_pack_stock_details s
	 inner join barang b on s.pcode = b.kode 
where 
	s.jspid in ('MPUC004')
	and s.pcode in ('B001B')
--	and s."in" = true
group by s.jspid, s.pcode, b.id, b.kode, b.nama, s."in" --, s.qty
	;



select s.jspid, s.pcode, s."in", 
	sum(s.qty) as qty 
from stock_pack_stock_details s
where 
	s.jspid in ('MPUC004')
group by s.jspid, s.pcode, s."in"
order by s.jspid, s.pcode, s."in";

/*

 

SELECT *
FROM crosstab(
    'SELECT row_number() OVER () AS row_num, 
            s.jspid, 
            s.pcode, 
			b.kode,
			b.nama,
            s."in", 
            sum(s.qty) as qty
     FROM stock_pack_stock_details s
		  inner join barang b on s.pcode = b.kode
		  left outer join barang_detail bd on b.id = bd.id_induk_fk  
	 where s.jspid in (''MPUC004'')
	 group by s.jspid, 
            s.pcode, 
			b.kode,
			b.nama, 
            s."in"
     ORDER BY 1',
    'SELECT DISTINCT "in" FROM stock_pack_stock_details ORDER BY 1'
) AS ct (
    "Row_Num" INT,
    "Jspid" TEXT,
    "Pcode" TEXT,
	"Kode" TEXT,
	"nama" TEXT,
    "Out" INT,
    "In" INT
)
order by CT."In";







SELECT row_number() OVER () AS row_num, 
	        s.jspid,
	        s."in", 
	        sum(s.qty) as qty,
	        b2.kode,
	        b2.nama,
	        bd.qty,
	        sum(s.qty) * bd.qty as "total"
	 FROM stock_pack_stock_details s
		  inner join barang b on s.pcode = b.kode
		  left outer join barang_detail bd on b.id = bd.id_induk_fk  
		  left outer join barang b2 on bd.id_barang_fk = b2.id
	 where s.jspid in ('MPUC004')
	 group by s.jspid, 
	        s."in",
	        bd.qty,
	        b2.kode,
	        b2.nama
	 ORDER BY 1;
*/	


SELECT row_number() OVER () AS row_num, 
        s.jspid, 
        s.pcode, 
		b.kode,
		b.nama,
        s."in", 
        sum(s.qty) as qty,
        bd.product_code,
        bd.id_induk_fk, 
        bd.id_barang_fk,
        b2.kode,
        b2.nama,
        bd.qty,
        sum(s.qty) * bd.qty as "total"
 FROM stock_pack_stock_details s
	  inner join barang b on s.pcode = b.kode
	  left outer join barang_detail bd on b.id = bd.id_induk_fk  
	  left outer join barang b2 on bd.id_barang_fk = b2.id
 where s.jspid in ('MPUC004')
 group by s.jspid, 
        s.pcode, 
		b.kode,
		b.nama, 
        s."in",
        bd.product_code,
        bd.id_induk_fk, 
        bd.id_barang_fk,
        bd.qty,
        b2.kode,
        b2.nama
 ORDER BY 1;


	
SELECT
--    row_number() OVER () AS "#",
    s.jspid AS "Jspid",
    sp."name",
    b2.id,
--    b2.kode AS "Kode",
    b2.nama AS "Nama",
--    s."in",
--    SUM(s.qty) AS "Qty",
--    bd.qty AS "Qty Pack",
    SUM(CASE WHEN s."in" THEN s.qty * bd.qty ELSE 0 END) AS "In",
    SUM(CASE WHEN NOT s."in" THEN s.qty * bd.qty ELSE 0 END) AS "Out"
FROM
    stock_pack_stock_details s
    inner join stock_packs sp on s.jspid = sp.code 
	INNER JOIN barang b ON s.pcode = b.kode
	LEFT OUTER JOIN barang_detail bd ON b.id = bd.id_induk_fk
	LEFT OUTER JOIN barang b2 ON bd.id_barang_fk = b2.id
WHERE
    s.jspid IN ('MPUC004')
GROUP BY
    s.jspid,
    sp."name",
    b2.id,
--    s."in",
--    bd.qty,
--    b2.kode,
    b2.nama
ORDER BY
    1;

/*
SELECT ct."Row_Num", ct."Jspid", ct."Kode", ct."Nama", ct."Out", ct."In", SUM(CASE WHEN s."in" THEN s.qty ELSE 0 END) AS "In",
FROM crosstab(
    'SELECT row_number() OVER () AS row_num, 
	        s.jspid, 
	        b2.kode,
	        b2.nama,
--	        sum(s.qty) as qty,
--	        bd.qty,
	        s."in", 
	        sum(s.qty) * bd.qty as "total"
	 FROM stock_pack_stock_details s
		  inner join barang b on s.pcode = b.kode
		  left outer join barang_detail bd on b.id = bd.id_induk_fk  
		  left outer join barang b2 on bd.id_barang_fk = b2.id
	 where s.jspid in (''MPUC004'')
	 group by s.jspid,  
	        bd.qty,
	        b2.kode,
	        b2.nama,
	        s."in"
	 ORDER BY 1;',
    'SELECT DISTINCT "in" FROM stock_pack_stock_details ORDER BY 1'
) AS ct (
    "Row_Num" INT,
    "Jspid" TEXT,
	"Kode" TEXT,
	"Nama" TEXT,
--    "Qty" INT,
--    "Qty Pack" INT,
    "Out" INT,
    "In" INT
)
order by CT."In";


SELECT row_number() OVER () AS row_num, 
       jspid, 
       pcode, 
       "in", 
       COALESCE(qty, 0) AS qty
FROM stock_pack_stock_details
ORDER BY 1;
*/





select distinct s.in, s.pcode  from stock_pack_stock_details s order by 1;

select s.jspid, s.pcode, b.id, b.kode, b.nama, s."in", 
	sum(s.qty) filter (where s."in" = true) as qty_in,
	sum(s.qty) filter (where s."in" = false) as qty_out
from stock_pack_stock_details s
	 left outer join barang b on s.pcode = b.kode 
where 
	s.jspid in ('MPUC004')
--	and s."in" = true
group by s.jspid, s.pcode, b.id, b.kode, b.nama, s."in" 
order by b.nama, s."in";

--select *


select 
		t.created_at, t.pickup_stock_pack, 
		t.is_pickup, td.id_barang_fk, 
		td."name", td.qty,
		"product".nama, "product".qty, "product".qty * td.qty as "total"
--		"product".nama, 
--		sum("product".qty) as qty, 
--		sum("product".qty * td.qty) as "total"
from "transaction" t 
	inner join transaction_detail td on t.id = td.id_trans_fk 
	inner join 
	(
		select b.id, null as "id_induk_fk", null as "id_barang_fk", b.id as "id_detail", b.nama, 1 as qty --, b.created_at 
		from barang b 
		where b.nama ilike '%propolis%'
		union 
		select bd.id, bd.id_induk_fk, bd.id_barang_fk, b.id, b.nama , bd.qty --, bm.created_at 
		from barang_detail bd 
			 inner join barang b on bd.id_barang_fk = b.id 
--			 inner join barang bm on bd.id_induk_fk = bm.id 
		where b.nama ilike '%propolis%' -- and bd.id_induk_fk in (1580)
	) as "product" on td.id_barang_fk = "product".id_induk_fk
where t.created_at >= '2024-01-12'	
	and t.status in('I') -- PAID --('PC', 'S', 'A', 'I') 
	and t.deleted_at is null
--	and td.id_barang_fk in (1580)
--	and t.is_pickup = 1 -- PICKUP PUC/MPU
--group by t.is_pickup, td.id_barang_fk, "product".nama --, "product".qty, "product".qty * td.qty as "total"
order by t.is_pickup
;


select * from barang_detail bd where id_induk_fk in (1580);
	
	
	


