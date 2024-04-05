update barang
set harga_ori_1 = 0,
	harga_ori_2 = 0,
	harga_ori_3 = 0;


-- START UPDATE HARGA DI TABLE BARANG (HEADER)

update barang b
set harga_ori_1 = data_summ.sub_tot_harga_1,
	harga_ori_2 = data_summ.sub_tot_harga_2,
	harga_ori_3 = data_summ.sub_tot_harga_3
from (
			select 
				data_compile.id_induk_fk,
			     data_compile.product_name,
			     data_compile.product_harga_1,
			     data_compile.product_harga_2,
			     data_compile.product_harga_3,
			     sum(data_compile.sub_tot_harga_1) as sub_tot_harga_1,
			     sum(data_compile.sub_tot_harga_2) as sub_tot_harga_2,
			     sum(data_compile.sub_tot_harga_3) as sub_tot_harga_3,
			     sum(data_compile.sub_tot_bv) as sub_tot_pv,
			     sum(data_compile.sub_tot_pv) as sub_tot_bv,
			     sum(data_compile.sub_tot_xv) as sub_tot_xv
			from
				(
					select datasets.id_induk_fk,
							datasets.product_name,
							datasets.product_code,
							datasets.id_barang_fk,
							datasets.product_harga_1,
							datasets.product_harga_2,
							datasets.product_harga_3,
							datasets.id,
							datasets.product_unit_name,
							datasets.qty,
							datasets.harga_1,
							datasets.harga_2,
							datasets.harga_3,
							datasets.sub_tot_harga_1,
							datasets.sub_tot_harga_2,
							datasets.sub_tot_harga_3,
							datasets.bv,
							datasets.pv,
							datasets.xv,
							datasets.sub_tot_bv,
							datasets.sub_tot_pv,
							datasets.sub_tot_xv
					from (
							select 
								bd.id_induk_fk, b1.nama as "product_name", bd.product_code, bd.id_barang_fk, 
								b1.harga_1 as "product_harga_1", b1.harga_2 as "product_harga_2", b1.harga_3 as "product_harga_3", 
								case when b2.id is null then b3.id else b2.id end as "id", 
								case when b2.nama is null then b3.nama else b2.nama end as "product_unit_name", 
								bd.qty, 
								case when b2.harga_1 is null then b3.harga_1 else b2.harga_1 end as "harga_1", 
								case when b2.harga_2 is null then b3.harga_2 else b2.harga_2 end as "harga_2", 
								case when b2.harga_3 is null then b3.harga_3 else b2.harga_3 end as "harga_3", 		
								case when b2.harga_1 is null then bd.qty * b3.harga_1 else bd.qty * b2.harga_1 end as "sub_tot_harga_1", 
								case when b2.harga_2 is null then bd.qty * b3.harga_2 else bd.qty * b2.harga_2 end as "sub_tot_harga_2", 
								case when b2.harga_3 is null then bd.qty * b3.harga_3 else bd.qty * b2.harga_3 end as "sub_tot_harga_3", 	
								case when b2.bv is null then b3.bv else b2.bv end as "bv", 	
								case when b2.pv is null then b3.pv else b2.bv end as "pv", 	
								case when b2.xv is null then b3.xv else b2.bv end as "xv", 
								case when b2.bv is null then bd.qty * b3.bv else bd.qty * b2.bv end as "sub_tot_bv", 
								case when b2.pv is null then bd.qty * b3.pv else bd.qty * b2.pv end as "sub_tot_pv", 
								case when b2.xv is null then bd.qty * b3.xv else bd.qty * b2.xv end as "sub_tot_xv"
							from barang_detail bd 
									inner join barang b1 on bd.id_induk_fk = b1.id
									left outer join barang b2 on bd.product_code = b2.kode --and b2.core = true
									left outer join barang b3 on bd.id_barang_fk = b3.id --and b2.core = true
							where 
							 bd.id_induk_fk in (1665,1666,1671,1667,1668,1669,1670,1664,1663)
							--b1.created_at >= '2023-08-01'
						--		and bd.id_induk_fk in (1638)
						) as datasets
--					where 
--							datasets.sub_tot_harga_1 = 0
--							or datasets.sub_tot_harga_2 = 0
--							or datasets.sub_tot_harga_3 = 0
					) as data_compile
				group by 
					 data_compile.id_induk_fk,
				     data_compile.product_name,
				     data_compile.product_harga_1,
				     data_compile.product_harga_2,
				     data_compile.product_harga_3
			) as data_summ
where id = data_summ.id_induk_fk
	;
-- START UPDATE HARGA DI TABLE BARANG (HEADER)




select b.id, b.nama, b.kode, b.harga_1, b.harga_2, b.harga_3, b.harga_ori_1, b.harga_ori_2, b.harga_ori_3 from barang b;






-- START UPDATE HARGA DI TABLE BARANG_DETAIL UNTUK TIAP SATUAN;
update barang_detail 
set harga_ori_per_unit_1 = data_unit.harga_1,
	harga_ori_per_unit_2 = data_unit.harga_2,
	harga_ori_per_unit_3 = data_unit.harga_3,
	harga_ori_subtotal_unit_1 = data_unit.sub_tot_harga_1,
	harga_ori_subtotal_unit_2 = data_unit.sub_tot_harga_2,
	harga_ori_subtotal_unit_3 = data_unit.sub_tot_harga_3
from
		(
			select datasets.id_induk_fk,
					datasets.product_name,
					datasets.product_code,
					datasets.id_barang_fk,
					datasets.product_harga_1,
					datasets.product_harga_2,
					datasets.product_harga_3,
					datasets.id,
					datasets.product_unit_name,
					datasets.qty,
					datasets.harga_1,
					datasets.harga_2,
					datasets.harga_3,
					datasets.sub_tot_harga_1,
					datasets.sub_tot_harga_2,
					datasets.sub_tot_harga_3,
					datasets.bv,
					datasets.pv,
					datasets.xv,
					datasets.sub_tot_bv,
					datasets.sub_tot_pv,
					datasets.sub_tot_xv
			from (
					select 
						bd.id_induk_fk, b1.nama as "product_name", bd.product_code, bd.id_barang_fk, 
						b1.harga_1 as "product_harga_1", b1.harga_2 as "product_harga_2", b1.harga_3 as "product_harga_3", 
						case when b2.id is null then b3.id else b2.id end as "id", 
						case when b2.nama is null then b3.nama else b2.nama end as "product_unit_name", 
						bd.qty, 
						case when b2.harga_1 is null then b3.harga_1 else b2.harga_1 end as "harga_1", 
						case when b2.harga_2 is null then b3.harga_2 else b2.harga_2 end as "harga_2", 
						case when b2.harga_3 is null then b3.harga_3 else b2.harga_3 end as "harga_3", 		
						case when b2.harga_1 is null then bd.qty * b3.harga_1 else bd.qty * b2.harga_1 end as "sub_tot_harga_1", 
						case when b2.harga_2 is null then bd.qty * b3.harga_2 else bd.qty * b2.harga_2 end as "sub_tot_harga_2", 
						case when b2.harga_3 is null then bd.qty * b3.harga_3 else bd.qty * b2.harga_3 end as "sub_tot_harga_3", 	
						case when b2.bv is null then b3.bv else b2.bv end as "bv", 	
						case when b2.pv is null then b3.pv else b2.bv end as "pv", 	
						case when b2.xv is null then b3.xv else b2.bv end as "xv", 
						case when b2.bv is null then bd.qty * b3.bv else bd.qty * b2.bv end as "sub_tot_bv", 
						case when b2.pv is null then bd.qty * b3.pv else bd.qty * b2.pv end as "sub_tot_pv", 
						case when b2.xv is null then bd.qty * b3.xv else bd.qty * b2.xv end as "sub_tot_xv"
					from barang_detail bd 
							inner join barang b1 on bd.id_induk_fk = b1.id
							left outer join barang b2 on bd.product_code = b2.kode --and b2.core = true
							left outer join barang b3 on bd.id_barang_fk = b3.id --and b2.core = true
					where 
					-- bd.id in (3085)
					 bd.id_induk_fk in (1665,1666,1671,1667,1668,1669,1670,1664,1663)
					--b1.created_at >= '2023-08-01'
				--		and bd.id_induk_fk in (1638)
				) as datasets
		) as data_unit
where barang_detail.id_induk_fk = data_unit.id_induk_fk 
	  and barang_detail.id_barang_fk = data_unit.id_barang_fk
	  and (
	  		barang_detail.harga_ori_per_unit_1 = 0 or
			barang_detail.harga_ori_per_unit_2 = 0 or
			barang_detail.harga_ori_per_unit_3 = 0 or
			barang_detail.harga_ori_subtotal_unit_1 = 0 or
			barang_detail.harga_ori_subtotal_unit_2 = 0 or
			barang_detail.harga_ori_subtotal_unit_3 = 0
	  		)
--	  and barang_detail.id in (3085)
;


-- END UPDATE HARGA DI TABLE BARANG_DETAIL UNTUK TIAP SATUAN;


-- START LIST REPORT LIST PRODUCT SALES QTY FOR FINANCE

select 
		b.id, 
		b.kode, 
		b.nama,
		t.id_barang_fk as "Product Code", 
		t."name" as "Desc", 
		t.total_barang as "Sold Unit", 
		bd.qty as "Unit (pcs)", 
		t.total_barang * bd.qty "Total Unit Out",
		b.harga_ori_1
from barang_detail bd
	 join (
			select td.id_barang_fk, td."name", sum(td.qty) as total_barang
			from "transaction" t
				join transaction_detail td on t.id = td.id_trans_fk
			where 
				td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
					select bd.id_induk_fk
					from barang_detail bd 
				) 
				and to_char(t.transaction_date, 'YYYY-MM') = '2024-03' 
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
	inner join barang b on bd.id_barang_fk = b.id 
	inner join barang bp on bp.id = b.id
	inner join barang bdx on bdx.id = t.id_barang_fk
--where t.id_barang_fk in (1586)
--where bd.id_barang_fk in (
--					3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335, --Joypolinse
--					4,255,326,457,459,461,463, 747, 823, -- --Joymunemax
--					119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341, --Joycell
--					104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337, -- Joyrazero
--					95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340, -- Lae Erica
--					96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339, -- Lae Darbot
--					54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342, -- Joyzetox
--					281, 336, 757, 837, 936, 1009, 1077, -- --Facial wash
--					280, 335, 756, 836, 935, 1008, 1076, -- --Toner
--					282, 337, 758, 838, 937, 1010, 1078, -- --Day cream
--					283,338, 759, 839, 938, 1011, 1079, -- --Night cream
--					309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343, -- Joypropolis
--					483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344, -- Joyvit-C
--					696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345, -- JoyVit-D3
--					809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346, -- JoyCoffee
--					1294, 1347, -- JoyOmega-3
--					1652, 1653, 1654, 1655 -- JoyBeau
--				)   
ORDER BY b.nama, b.id, b.kode, t.id_barang_fk;


select 0.1/0;



-- =============================================================================================================
-- START REPORT SALES PRODUCT WITH AVG PRICE/UNIT
-- =============================================================================================================
	select 
			raw_data.transaction_date,
			raw_data.id, 
			raw_data.code_trans, 
			raw_data.purchase_cost, 
			raw_data.id_barang_fk, 
			raw_data.kode, 
			raw_data.name, 
			raw_data.qty_order, 
--			raw_data.base_price, 
			raw_data.sell_price, 
--			raw_data.pv, 
--			raw_data.bv, 
--			raw_data.original_price, 
			raw_data.product_unit_code, 
			raw_data.product_unit_name, 
--			raw_data.product_code, 
			raw_data.unit, 
			raw_data.total_unit, 
			raw_data.original_price_per_unit, 
			raw_data.sub_total_original_price_per_unit,
			raw_data.total_original_price_per_transaction,
--			(raw_data.total_original_price_per_transaction / raw_data.sub_total_original_price_per_unit) * raw_data.purchase_cost as "avg_price_per_unit", -- SALAH
			case
				when raw_data.sub_total_original_price_per_unit > 0 then ROUND(CAST(raw_data.sub_total_original_price_per_unit AS NUMERIC) / cast(raw_data.total_original_price_per_transaction AS NUMERIC) * raw_data.purchase_cost, 2)
				else 0
			end as "avg_price_per_unit"
	from (
			-- ----------------------------------------------------------------------------------------------------------
			-- START GET RAW DATA FROM SALES/TRANSACTION
			-- ----------------------------------------------------------------------------------------------------------
			/* - */ select  t.transaction_date, t.id, t.code_trans, t.purchase_cost, 
			/* - */ 		td.id_barang_fk, b.kode, td.name, 
			/* - */ 		td.qty as "qty_order", td.base_price, td.sell_price, 
			/* - */ 		td.pv, td.bv,
			/* - */ 		case
			/* - */ 			when td.sell_price = b.harga_1 then b.harga_ori_1 
			/* - */ 			when td.sell_price = b.harga_2 then b.harga_ori_2
			/* - */ 			when td.sell_price = b.harga_3 then b.harga_ori_3
			/* - */ 			else 0
			/* - */ 		end as "original_price",
			/* - */ 		bd.id_barang_fk as "product_unit_code", b2.nama as "product_unit_name", 
			/* - */ 		bd.product_code, bd.qty as "unit", bd.qty * td.qty as "total_unit",
			/* - */ 		case
			/* - */ 			when td.sell_price = b.harga_1 then bd.harga_ori_per_unit_1
			/* - */ 			when td.sell_price = b.harga_2 then bd.harga_ori_per_unit_2
			/* - */ 			when td.sell_price = b.harga_3 then bd.harga_ori_per_unit_3
			/* - */ 			else 0
			/* - */ 		end as "original_price_per_unit",
			/* - */ 		case
			/* - */ 			when td.sell_price = b.harga_1 then (bd.harga_ori_per_unit_1 * (bd.qty * td.qty))
			/* - */ 			when td.sell_price = b.harga_2 then (bd.harga_ori_per_unit_2 * (bd.qty * td.qty))
			/* - */ 			when td.sell_price = b.harga_3 then (bd.harga_ori_per_unit_3 * (bd.qty * td.qty))
			/* - */ 			else 0
			/* - */ 		end as "sub_total_original_price_per_unit",
			/* - */ 		case
			/* - */ 			when td.sell_price = b.harga_1 then SUM((bd.harga_ori_per_unit_1 * (bd.qty * td.qty))) OVER (PARTITION BY t.id)
			/* - */ 			when td.sell_price = b.harga_2 then SUM((bd.harga_ori_per_unit_2 * (bd.qty * td.qty))) OVER (PARTITION BY t.id)
			/* - */ 			when td.sell_price = b.harga_3 then SUM((bd.harga_ori_per_unit_3 * (bd.qty * td.qty))) OVER (PARTITION BY t.id)
			/* - */ 			else 0
			/* - */ 		end as "total_original_price_per_transaction"
			/* - */ from "transaction" t 
			/* - */ 	 inner join transaction_detail td on t.id = td.id_trans_fk 
			/* - */ 	 inner join barang b on td.id_barang_fk = b.id 
			/* - */ 	 inner join barang_detail bd on td.id_barang_fk = bd.id_induk_fk 
			/* - */ 	 inner join barang b2 on bd.id_barang_fk = b2.id 
			/* - */ where 
			/* - */ 	 to_char(t.transaction_date, 'YYYY-MM') = '2024-01' 
			/* - */ 	 and t.status in ('PC', 'S', 'A', 'I')
		 	/* - */ 	 and t.deleted_at is null 
			/* - */ order by 
			/* - */ 	 t.transaction_date, t.id, t.code_trans, b2.nama
			-- ----------------------------------------------------------------------------------------------------------
			-- END GET RAW DATA FROM SALES/TRANSACTION
			-- ----------------------------------------------------------------------------------------------------------
		) as raw_data
--	WHERE raw_data.sub_total_original_price_per_unit > 0 AND raw_data.total_original_price_per_transaction > 0 AND raw_data.purchase_cost > 0
;

-- =============================================================================================================
-- END REPORT SALES PRODUCT WITH AVG PRICE/UNIT
-- =============================================================================================================
-- END LIST REPORT LIST PRODUCT SALES QTY FOR FINANCE




			-- ----------------------------------------------------------------------------------------------------------
			-- START GET RAW DATA FROM SALES/TRANSACTION
			-- ----------------------------------------------------------------------------------------------------------
			/* - */ select  t.transaction_date, t.id, t.code_trans, t.purchase_cost, 
			/* - */ 		td.id_barang_fk, td."name",
			/* - */ 		td.qty as "qty_order", td.base_price, td.sell_price, 
			/* - */ 		td.pv, td.bv
			/* - */ from "transaction" t 
			/* - */ 	 inner join transaction_detail td on t.id = td.id_trans_fk 
			/* - */ where 
			/* - */ 	 to_char(t.transaction_date, 'YYYY-MM') = '2024-03' 
			/* - */ 	 and t.status in ('PC', 'S', 'A', 'I')
		 	/* - */ 	 and t.deleted_at is null 
			/* - */ order by 
			/* - */ 	 t.transaction_date, t.code_trans;
			-- ----------------------------------------------------------------------------------------------------------
			-- END GET RAW DATA FROM SALES/TRANSACTION
			-- ----------------------------------------------------------------------------------------------------------
		


