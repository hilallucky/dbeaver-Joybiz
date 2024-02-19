SELECT now();



-- CHECK TRANSAKSI MEMBER
select m.id, m.jbid, m.username, m.spid, m.upid, 
	t.transaction_date, t.created_at, t.code_trans, t.pv_total, t.bv_total, 
	t.deleted_at, t.status 
from "transaction" t 
	  join memberships m on t.id_cust_fk = m.jbid 
where 
	t.code_trans in ('HEXDPS') or m.username = 'holil0412631'
--t.status in('PC', 'S', 'A', 'I') -- PAID
--	 and m.username in ('andrie2211191')
--	 and t.transaction_date >= '2023-11-07'
order by m.username, t.transaction_date desc ;



select *
from barang b
where id in (282);--kode ilike '%J40%' or kode ilike '%J39%';

--
--
--	Joypolinse : 3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335
----	Joymunemax : ;4,255,326,457,459,461,463, 747, 823
--	Joycell : 119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341
--	Joyrazero : 104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337
--	Lae Erica : 95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340
--	Lae Darbot : 96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339
--	Joyzetox ; 54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342
----	Facial wash : ;281, 336, 757, 837, 936, 1009, 1077
----	Toner: 280, 335, 756, 836, 935, 1008, 1076
----	Day cream:  282, 337, 758, 838, 937, 1010, 1078
----	Night cream 283,338, 759, 839, 938, 1011, 1079
--	Joypropolis : 309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343
--	Joyvit-C: 483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344
--	JoyVit-D3 : 696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345
--	JoyCoffee:  809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346
--	JoyOmega-3: 1294, 1347 
--
--	
--	
--	


select td.id_barang_fk, 
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
where td.id_barang_fk  in (
	3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335,
	4,255,326,457,459,461,463, 747, 823,
	119,266,332, 751, 830, 929, 1002,1070, 1154, 1211, 1279, 1341,
	104, 256, 327, 749, 824, 924, 997, 1065, 1150, 1206, 1274, 1337,
	95, 260, 329, 399, 806, 826, 926, 999, 1068, 1151, 1208, 1276, 1340,
	96, 261, 330, 400, 807, 828, 927, 1000, 1069, 1152, 1209, 1277, 1339,
	54, 267, 333, 752, 831, 930, 1005, 1071, 1155, 1212, 1280, 1342,
	281, 336, 757, 837, 936, 1009, 1077,
	280, 335, 756, 836, 935, 1008, 1076,
	282, 337, 758, 838, 937, 1010, 1078,
	283,338, 759, 839, 938, 1011, 1079,
	309, 334, 753, 832, 931, 1003, 1072, 1156, 1213, 1281, 1343,
	483, 640, 754, 833, 932, 1004, 1073, 1158, 1214, 1282, 1344,
	696,  755, 834, 933, 1006, 1074, 1159, 1215, 1283, 1345,
	809, 835, 934, 1007, 1075, 1161, 1216, 1284, 1346,
	1294, 1347 
) --"name" ilike '%rts%' -- 
	and t.status in('PC', 'S', 'A', 'I') -- PAID
group by td.id_barang_fk, td."name", 
	td.sell_price, td.pv, td.bv, td.rv 
order by td."name" ;

