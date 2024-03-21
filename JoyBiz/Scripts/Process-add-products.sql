
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


select 	*
from barang b  
where b.nama 
	ILIKE 
	ANY(ARRAY[
		'Joybizer (J40)',
		'Special Customer (J29)'
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
--	b.nama 
--	ILIKE ANY(ARRAY[
----		'Go Gamma BVB Pack%(J39)',
----		'Start-Up Titanium%(J39)',
----		'Start-Up platinum%(J39)'
--		'%propolis%(j39)%',
--		'%omega%(j39)%'
--		])
--	and 
	b.id in (1568,1564) or kode in ('I002B')
order by b.nama ;


select * from products p;


select *
from barang_detail bd  
where id_induk_fk  in (
1641,1622,1643,1644,1645,
1656,1657,1658,1659,1660
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
		d.id, d.id_induk_fk,d.id_barang_fk, dbs.nama, d.qty, p."name" --, d.product_code, p.code
FROM barang b 
	JOIN barang_detail d ON b.id = d.id_induk_fk
	JOIN barang dbs ON d.id_barang_fk = dbs.id
	LEFT JOIN products p ON d.product_code = p.code
WHERE
b.id IN  (
--select id from barang b2 where nama ilike '%RTS%'
1656,1657,1658,1659,1660
		) 
ORDER BY b."id", d.id;
-- END PRODUCT LISTING;

select * from media m 
where id_barang_fk in (1656,1657,1658,1659,1660)
order by m.created_at desc;


select * from barang b  where nama ilike '%J41%' order by id;




-- STOCK PUC
select sps.id, sp.code, sp."name", b.kode, b.nama, sps.qty , sps.created_at, sps.updated_at 
from stock_pack_stocks sps 
	left outer join stock_packs sp on sps.jspid = sp.code 
	left outer join barang b on sps.pcode = b.kode 
order by sps.jspid, sps.pcode ;


