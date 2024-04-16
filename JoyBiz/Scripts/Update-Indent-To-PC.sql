
select code_trans, status 
from "transaction" t 
where code_trans in ('Z03WEX');


update "transaction" 
set status = 'PC'
where code_trans in ('TPSJWW');

select code_trans, status 
from  transaction tr  
where code_trans in ('K3TPPH','HSNWIA','FAIC9O' ,'H9FZ0O');


select * from stock_packs sp 


	select tr.code_trans
	FROM "transaction" tr
		JOIN transaction_detail td ON tr."id" = td.id_trans_fk
	WHERE tr.status = 'I' AND td.id_barang_fk IN (1621,
	1516,
	1517,
	1522,
	1638,
	1639,
	1640,
	1642,
	1643,
	1644,
	1645,
	1658,
	1659,
	1660,
	1532,
	1268,
	1630,
	1632,
	1629,
	1533,
	1537,
	1304,
	1307,
	1312,
	1321,
	1323,
	1585,
	1568,
	1577,
	1584,
	1586,
	1587,
	1594,
	1595,
	1538,
	1539,
	1540,
	1375,
	1347,
	1297,
	1294,
	1298,
	1300,
	1303,
	1317,
	1326,
	1348,
	1385,
	1394,
	1402,
	1403,
	1410,
	1413,
	1414,
	1415,
	1416,
	1427,
	1432,
	1444,
	1443,
	1445,
	1451,
	1461,
	1450,
	1417,
	1442,
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
	1597,
	1598,
	1599,
	1600,
	1601,
	1605,
	1607,
	1618,
	1633)
	ORDER BY tr.transaction_date