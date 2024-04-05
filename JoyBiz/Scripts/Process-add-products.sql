
select kode, nama, harga_1, harga_2, harga_3, harga_retail_1, harga_retail_2, harga_retail_3 , shipping_budget, weight, status, is_show, is_show --* 
from barang b 
where --nama ilike '%Joypolinse%'
--	nama = 'Go Gamma BVB Pack (J40)'
--	or contains(nama, 'Start-Up Titanium')
nama ILIKE '%J41%%' -- or kode in ('TJ007','TJ008','TJ008','TJ003','TJ005','TJ002','MC008')
--and created_at::date = '2023-12-27'
--or nama ilike '%pronovde%'
order by id
;
1641
1642
1643
1644
1645

1656
1657
1658
1659
1660

select 
--	*
	nama, status, is_show, is_show_sc, created_at, updated_at 
from barang b where nama ILIKE 
	ANY(ARRAY[
		'%promari%',
		'%projanfe%'
		])
order by created_at desc;


select kode, nama, shipping_budget, "desc" , weight, status, is_show, is_show, created_at  --* 
from barang b 
where nama ilike '%joy%omega%%' -- and ("desc" is null or "desc" = '')  --and nama not ilike '%Turbo Pack'
--	nama = 'Go Gamma BVB Pack (J40)'
--	or contains(nama, 'Start-Up Titanium')
order by weight, status, id desc;



select * from barang where nama ilike 'gamma%pack%pro%' order by created_at desc; --core = true and 


select b.id, b.kode, b.nama, b.pv, b.bv, b.xv , 
--		b.harga_1, b.harga_2, b.harga_3,
--		b.status, b.is_show, b.is_show_sc, b.weight,
		b.created_at, b.updated_at,  
		m.id, m.link,m."type", m.created_at, m.updated_at 
from barang b
	 left outer join media m on b.id = m.id_barang_fk 
where b.nama 
	ILIKE 
	ANY(ARRAY[
		'flash%alpha%'
		])
order by b.nama ;


select * from products p where code ilike '%1346%';

select * from media m where id_barang_fk in (1637,1645,
1656,
1657,
1658,
1659,
1660) order by id_barang_fk  desc;


select id , nama, status, is_show , created_at , updated_at, deleted_at  from barang b where nama like 'Joybizer (J31)'; --id in (1560);

select *
from barang_detail bd  
where id_induk_fk  in (1647,1648,1649)
order by id ;

1637





select *
from barang b 
where id
 in (1638
)
--	nama = 'Go Gamma BVB Pack (J40)'
--	or contains(nama, 'Start-Up Titanium')
--nama ILIKE '%Joybize%';
;

select 	*
from barang b  
where 
	b.nama 
	ILIKE ANY(ARRAY[
		'%dba Turbo Pack%',
		'%Immune 01 BVB Pack%',
		'%dba basic 1 BVB Pack%',
		'%Go Gamma BVB Pack%40%'
		'%Start-Up Titanium%',
		'%Start-Up Platinum%',
		'%Start-Up Gold%',
		'%Flash Alpha 06%',
		'%Flash Alpha 08%'
		])
	and
	b.kode in ('dba001BVBJ39',
				'DBATPJ39',
				'FA006J39',
				'FA008J39',
				'I005BVB01J39',
				'SUG001J39',
				'SUP001J40',
				'SUT001J40',
				'GGBVB001J40'
				)
--	b.id in (1568,1564) or kode in ('I002B')
order by b.nama ;

select id, nama, kode, weight, status, is_show, is_show_sc  
from barang b 
where b.nama ilike '%(j41)%' 
	 and remarks ='add new J41' 
order by b.nama, created_at desc;

select * from products p;


select --*
		bd.id, 
		bd.id_induk_fk,
		bd.id_barang_fk, b.nama,  
		bd.qty, 
		bd.product_code,
	 	b2.nama as "nama paket", b.nama as "nama product"
from barang_detail bd  
	 inner join barang b on bd.id_barang_fk = b.id 
	 inner join barang b2 on bd.id_induk_fk = b2.id 
where id_induk_fk  in (
1595,1586,1606,1608,1593,1600,1639,1640,1638
)
order by b2.nama, bd.id_induk_fk, bd.id_barang_fk ;

/*
JoyPolinse - 1335
Sticker Joyrazero - 1337
Sticker Joyrazero LAE 01 Darbotz - 1339
Sticker Joyrazero LAE 01 Erica - 1340
JoyCell - 1341
Joyzetox - 1342
Joypropolis - 1343
JoyVit-C - 1344
JoyVit-D3 - 1345
JoyCoffee - 1346
JoyOmega3 - 1347
JoyCoffee Sachet - 1505
*/

select *
from barang_detail bd  
where id_induk_fk  in (
1595,1586,1606,1608,1593,1600,1639,1640,1638
)
order by bd.id_induk_fk, bd.id_barang_fk ;


select * from users u where u.username ilike'zainal0902411%';
select * from memberships m  where m.username ='yasmar1312861';



-- START PRODUCT LISTING;
SELECT b.id, b.kode, b.nama, b.pv, b.pvx, b.bv, b.bvx, b.xv, b.rv, 
		b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.shipping_budget, 
		b.is_register, b.bv_sc, b.weight, b.cashback_reseller, 
		d.id, d.id_induk_fk,d.id_barang_fk, dbs.nama, d.qty, p."name" --, d.product_code, p.code
FROM barang b 
	JOIN barang_detail d ON b.id = d.id_induk_fk
	JOIN barang dbs ON d.id_barang_fk = dbs.id
	LEFT JOIN products p ON d.product_code = p.code
WHERE
b.id IN  (
--select id from barang b2 where nama ilike '%RTS%'
1665,1666,1671,1667,1668,1669,1670,1664,1663

		) 
ORDER BY b."id", d.id;
-- END PRODUCT LISTING;

select * 
from media m 
where id_barang_fk in (1665,1666,1671,1667,1668,1669,1670,1664,1663)
order by m.created_at desc;


select * 
from media m 
where id_barang_fk in (1595,1586,1606,1608,1593,1600,1639,1640,1638)
order by m.created_at desc;


select * from barang b  where nama ilike '%J41%' order by id;




-- STOCK PUC
select sps.id, sp.code, sp."name", b.kode, b.nama, sps.qty , sps.created_at, sps.updated_at 
from stock_pack_stocks sps 
	left outer join stock_packs sp on sps.jspid = sp.code 
	left outer join barang b on sps.pcode = b.kode 
order by sps.jspid, sps.pcode ;




SELECT * FROM barang b where status in ('A','I') and deleted_at is null and is_show = 1;
