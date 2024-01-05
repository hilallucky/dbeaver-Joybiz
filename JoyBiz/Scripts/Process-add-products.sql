
select *
from barang b 
where --nama ilike '%Joypolinse%'
--	nama = 'Go Gamma BVB Pack (J40)'
--	or contains(nama, 'Start-Up Titanium')
nama ILIKE '%J40%' and created_at::date = '2023-12-27'
--or nama ilike '%pronovde%'
order by id
;
1641
1642
1643
1644
1645

select 	*
from barang b  
where b.nama 
	ILIKE 
	ANY(ARRAY[
		'Go Gamma BVB Pack%(J39)',
		'Start-Up Titanium%(J39)',
		'Start-Up platinum%(J39)'
		])
order by b.nama ;


select * from products p where code ilike '%1346%';

select * from media m where id_barang_fk in (1640,1641,1642,1643,1644,1645) order by id_barang_fk  desc;


select * from barang b where id in (1346);

select *
from barang_detail bd  
where id_induk_fk  = 1643
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
--	b.nama 
--	ILIKE 
--	ANY(ARRAY[
--		'Go Gamma BVB Pack%(J39)',
--		'Start-Up Titanium%(J39)',
--		'Start-Up platinum%(J39)'
--		])
	b.id in (1637,1638,1639,1640)
order by b.nama ;


select * from products p;


select *
from barang_detail bd  
where id_induk_fk  in (
--1637,1638,1639,1640,
--1597,1599,1598
1637,1638,1639,1640
)
order by bd.id_induk_fk, bd.id_barang_fk ;

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

select * from users u where u.username ilike'zainal0902411%';
select * from memberships m  where m.username ='yasmar1312861';



-- START PRODUCT LISTING;
SELECT b.id, b.kode, b.nama, b.pv, b.pvx, b.bv, b.bvx, b.xv, b.rv, 
		b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.shipping_budget, 
		b.is_register, b.bv_sc, b.weight, b.cashback_reseller, 
		d.id, d.id_induk_fk,d.id_barang_fk, dbs.nama, d.qty, p."name"
FROM barang b 
	JOIN barang_detail d ON b.id = d.id_induk_fk
	JOIN barang dbs ON d.id_barang_fk = dbs.id
	LEFT JOIN products p ON d.product_code = p.code
WHERE b.id IN  (
		1641,1642,1643,1644,1645
		) 
ORDER BY b."id", d.id;
-- END PRODUCT LISTING;
