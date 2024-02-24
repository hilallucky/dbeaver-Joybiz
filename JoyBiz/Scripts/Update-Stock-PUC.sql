-- START UPDATE STOCK PUC/MPU
SELECT * FROM stock_packs sp where code = 'MPUC004'; -- 10


select * 
from stock_pack_stock_details spsd 
where 
	tcode in ('ZY8XMG') 
--	jspid in ('MPUC004')
;

select *
from stock_pack_stocks sps 
where jspid in ('MPUC004') and pcode in ('E002LAE1EB','E002LAE1DB');
-- END UPDATE STOCK PUC/MPU



select t.created_at, t.pickup_stock_pack, t.is_pickup, td.id_barang_fk, td."name", td.qty 
from "transaction" t 
	inner join transaction_detail td on t.id = td.id_trans_fk 
where created_at >= '2024-02-12'	
	and t.status in('PC', 'S', 'A', 'I') -- PAID
	and t.deleted_at is null
--	and t.is_pickup = 1 -- PICKUP PUC/MPU
;




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
	
	
	


