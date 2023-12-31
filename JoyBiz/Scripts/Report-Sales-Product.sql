/*
	Note : 
	Kode produk :
	Joypolinse : 3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335
--	Joymunemax : ;4,255,326,457,459,461,463, 747, 823
	Joycell : 119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341
	Joyrazero : 104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337
	Lae Erica : 95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340
	Lae Darbot : 96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339
	Joyzetox ; ;54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342
--	Facial wash : ;281, 336, 757, 837, 936, 1009, 1077
--	Toner: 280, 335, 756, 836, 935, 1008, 1076
--	Day cream:  282, 337, 758, 838, 937, 1010, 1078
--	Night cream 283,338, 759, 839, 938, 1011, 1079
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
				and t.transaction_date BETWEEN '2023-12-01' and '2023-12-27'
--				'2023-08-31' and '2023-09-27'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
where bd.id_barang_fk in (1294, 1347)   
ORDER BY bd.id_induk_fk asc;


