/*
	Note : 
	Kode produk :
	Joypolinse : 3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335
--	Joymunemax : ;4,255,326,457,459,461,463, 747, 823
	Joycell : 119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341
	Joyrazero : 104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337
	Lae Erica : 95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340
	Lae Darbot : 96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339
	Joyzetox ; 54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342
--	Facial wash : ;281, 336, 757, 837, 936, 1009, 1077
--	Toner: 280, 335, 756, 836, 935, 1008, 1076
--	Day cream:  282, 337, 758, 838, 937, 1010, 1078
--	Night cream 283,338, 759, 839, 938, 1011, 1079
	Joypropolis : 309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343
	Joyvit-C: 483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344
	JoyVit-D3 : 696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345
	JoyCoffee:  809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346
	JoyOmega-3: 1294, 1347 
*/




			
-- =============================================================================================================================
-- START REPORT PRODUCT SALES QTY;
-- =============================================================================================================================
-- EDIT STEP 3
select -- bd.*, 
		b.id, b.kode, b.nama,
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
				and 
					 to_char(t.transaction_date, 'YYYY-MM') = '2024-02' 
--					t.transaction_date BETWEEN '2023-12-01' and '2023-12-27'
					-- '2023-08-31' and '2023-09-27'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
	join barang b on bd.id_barang_fk = b.id 
where bd.id_barang_fk in (
					3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335, --Joypolinse
					4,255,326,457,459,461,463, 747, 823, -- --Joymunemax
					119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341, --Joycell
					104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337, -- Joyrazero
					95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340, -- Lae Erica
					96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339, -- Lae Darbot
					54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342, -- Joyzetox
					281, 336, 757, 837, 936, 1009, 1077, -- --Facial wash
					280, 335, 756, 836, 935, 1008, 1076, -- --Toner
					282, 337, 758, 838, 937, 1010, 1078, -- --Day cream
					283,338, 759, 839, 938, 1011, 1079, -- --Night cream
					309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343, -- Joypropolis
					483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344, -- Joyvit-C
					696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345, -- JoyVit-D3
					809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346, -- JoyCoffee
					1294, 1347 -- JoyOmega-3
				)   
ORDER BY b.nama, b.id, b.kode, t.id_barang_fk;


-- =============================================================================================================================
-- END REPORT PRODUCT SALES QTY;
-- =============================================================================================================================


SELECT 
	b.id, b.kode, b.nama --, 
--	b.pv, b.pvx, b.bv, b.bvx, b.xv, b.rv, b.bv_sc, b.weight, b.cashback_reseller,   
--	b.harga_1, b.harga_2, b.harga_3, 
--	b.harga_retail_1, b.shipping_budget, 
--	b.is_register, d.id, d.id_induk_fk,d.id_barang_fk, dbs.nama, d.qty, p."name"
FROM barang b JOIN barang_detail d ON b.id = d.id_induk_fk
JOIN barang dbs ON d.id_barang_fk = dbs.id
LEFT JOIN products p ON d.product_code = p.code
WHERE b.nama ilike '%j40%' or b.nama ilike '%j39%'
group by b.id, b.kode, b.nama 
ORDER BY b."id";



select * from barang b where kode ilike 'RTS%';

select 
from 	"transaction" t 
		inner join transaction_detail td on t.id  = td.id_trans_fk 
where td.id_barang_fk in (1647,1648,1649);


select -- td.id_barang_fk, 
	td."name", 
	td.sell_price,
	sum(td.qty) as qty_order,
	td.sell_price * sum(td.qty) as price_total,
	td.pv,
	td.pv * sum(td.qty) as pv_total,
	td.bv,
	td.bv * sum(td.qty) as bv_total,
	td.rv,
	td.rv * sum(td.qty) as rv_total
from 	transaction_detail td 
		inner join "transaction" t on t.id = td.id_trans_fk 
where td.id_barang_fk  in (1647,1648,1649) --"name" ilike '%rts%' -- 
	and t.status in('PC', 'S', 'A', 'I') -- PAID
group by td.id_barang_fk, td."name", 
	td.sell_price, td.pv, td.bv, td.rv 
order by td."name" ;


