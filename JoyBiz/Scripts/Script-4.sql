-- CHECK NEW PRODUCT
select *
from barang b 
where b.kode ilike '%39%';

select *
from barang_detail bd
where 
--	b.kode ilike '%39%'
	bd.id_induk_fk in (select b.id
						from barang b 
						where b.kode ilike '%39%'
						)
;

select b.kode, b.nama, bd.*
from barang b 
	join barang_detail bd on b.id = bd.id_induk_fk  
where b.kode ilike '%39%'
order by b.kode, bd.product_code ;

select * from barang_detail bd where bd.id_induk_fk = 1597;;

