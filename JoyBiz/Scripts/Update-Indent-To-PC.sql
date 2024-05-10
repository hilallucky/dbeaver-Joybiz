
select * from 

select code_trans, status, id, transaction_date 
from "transaction" t 
where --code_trans in ('6EIYRI');
	  t.status = 'I'
	 and t.created_at >= '2024-04-01';

select * from transaction_detail td where td.id_trans_fk in (149042);
select kode, nama, created_at, updated_at, status from barang b where id in (1584) or nama ilike 'JoyOmega3%)' order by created_at desc;


update "transaction" 
set status = 'PC'
where code_trans in ('4DZLUV');

select code_trans, status 
from  transaction tr  
where code_trans in ('RJMGGY','VIXWB3','6EIYRI3' ,'6EIYRI1','6EIYRI2');

select * from stock_packs sp 

select id, nama, kode 
from barang b 
where core = true 
	 and nama ilike '%omega%';


	select tr.created_at, tr.transaction_date, tr.code_trans, td.id_barang_fk, td."name", sum(td.qty) as "qty"
	FROM "transaction" tr
		JOIN transaction_detail td ON tr."id" = td.id_trans_fk
	WHERE tr.status = 'I' AND td.id_barang_fk IN (1268,
1294,
1297,
1298,
1300,
1303,
1304,
1307,
1312,
1317,
1321,
1323,
1326,
1347,
1348,
1375,
1385,
1394,
1402,
1403,
1410,
1413,
1414,
1415,
1416,
1417,
1427,
1432,
1442,
1443,
1444,
1445,
1450,
1451,
1461,
1470,
1478,
1479,
1486,
1489,
1490,
1500,
1501,
1502,
1503,
1516,
1517,
1522,
1532,
1533,
1537,
1538,
1539,
1540,
1568,
1577,
1584,
1585,
1586,
1587,
1594,
1595,
1597,
1598,
1599,
1600,
1601,
1605,
1607,
1618,
1621,
1629,
1630,
1632,
1633,
1638,
1640,
1639,
1642,
1643,
1644,
1645,
1658,
1659,
1660,
1671,
1668,
1669,
1670,
1664,
1663,
1675,
1676,
1677)
	group by tr.created_at, tr.transaction_date, tr.code_trans, td.id_barang_fk, td."name"
	ORDER BY tr.transaction_date