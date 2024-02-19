--SELECT x.* 
--FROM public.barang x
--WHERE x.kode = 'SUT001J34'
----or x.id in (select bd.id_barang_fk::int from barang_detail bd where id_induk_fk::int = 1298);

SELECT b.id, b.kode, b.nama, b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.bv, b.pv, b.rv 
FROM barang b 
where (b.kode ilike '%J39%' or b.kode ilike '%J40%') 
--	and	b.kode not in ('B001J39','BP002J40','D001J39','DTP001J39','E001LAEBVBJ39','E001LAEPCJ39','E002JPJ39','E002JPTPJ39','E002KJGAOJ39',	
--						'E002KJGAOJ39','E002KJJ39','E002LAE01GAOJ39','E002LAE01J39','FA003J39','FA003J39','FTP001J39','GGBVB001J40','GPJ001J40',
--						'GPJ002J40','I002J39','I003J39','I004J39','I005J39','P001J39','P001J39','RSLP001J24','SUG001J39','SUP001J40','SUT001J40'
--						)
;
	
	



SELECT 	-- b.id, b.kode, b.nama, 
		to_char(t.transaction_date, 'YYYY-MM') as "Period",
		replace(replace(b.nama, ' (J39)', ''), ' (J40)', '') as "nama_barang", 
		b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.bv, b.pv, b.rv, 
	sum(coalesce(td.qty, 0)) as "qty"
FROM barang b 
		left outer join transaction_detail td on b.id = td.id_barang_fk 
		inner join "transaction" t on t.id = td.id_trans_fk 
where (b.kode ilike '%J39%' or b.kode ilike '%J40%')
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
group by --b.id, b.kode, b.nama, 
		b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.bv, b.pv, b.rv, 
		replace(replace(b.nama, ' (J39)', ''), ' (J40)', ''),
		to_char(t.transaction_date, 'YYYY-MM')
order by to_char(t.transaction_date, 'YYYY-MM'), 
		replace(replace(b.nama, ' (J39)', ''), ' (J40)', '')
;