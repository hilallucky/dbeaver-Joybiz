--SELECT x.* 
--FROM public.barang x
--WHERE x.kode = 'SUT001J34'
----or x.id in (select bd.id_barang_fk::int from barang_detail bd where id_induk_fk::int = 1298);

SELECT b.id, b.kode, b.nama, b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.bv, b.pv, b.rv 
FROM barang b 
where --(b.kode ilike '%J39%' or b.kode ilike '%J40%')
	b.kode ILIKE ANY(ARRAY['%J39%','%J40%','%J41%']) 
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
where 
	b.kode ILIKE ANY(ARRAY['%J39%','%J40%','%J41%']) 
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
group by --b.id, b.kode, b.nama, 
		b.harga_1, b.harga_2, b.harga_3, b.harga_retail_1, b.bv, b.pv, b.rv, 
		replace(replace(b.nama, ' (J39)', ''), ' (J40)', ''),
		to_char(t.transaction_date, 'YYYY-MM')
order by to_char(t.transaction_date, 'YYYY-MM'), 
		replace(replace(b.nama, ' (J39)', ''), ' (J40)', '')
;




SELECT b.id, b.kode, b.nama, -- b.pv, b.pvx, b.bv, b.bvx, b.xv, b.rv, 
		b.harga_1, b.shipping_budget, b.weight, 
		-- b.harga_2, b.harga_3, b.harga_retail_1, b.is_register, b.bv_sc, , b.cashback_reseller,  d.id, d.id_induk_fk,
		d.id_barang_fk, dbs.nama, d.qty, p."name" --, d.product_code, p.code
FROM barang b 
	JOIN barang_detail d ON b.id = d.id_induk_fk
	JOIN barang dbs ON d.id_barang_fk = dbs.id
	LEFT JOIN products p ON d.product_code = p.code
where b.kode in 
	(
	'JCF002PJ39P',
	'I005PLJ39',
	'FA005J39',
	'JCF001SPJ39',
	'GPJ002J39',
	'GPJ001J39',
	'FA006J39',
	'FA007J39',
	'PRJP004J39',
	'DBATPJ39',
	'FA004J39',
	'I004J39K',
	'R05J40',
	'SUT001J40',
	'GPJ001J40',
	'P001J40PR',
	'I005PLJ40',
	'GPJ002J40',
	'BP002J40',
	'GGBVB001J40',
	'BP002J39',
	'SUP001J40',
	'P001J41PR',
	'PB001J41',
	'GPJ001J41',
	'GPJ002J41',
	'BP001J41',
	'JV001J39TP',
	'B001J39',
	'PB001J39',
	'DTP001J39',
	'E001LAEBVBJ39',
	'FTP001J39',
	'JCF002PJ39',
	'JOTP001J39',
	'B001J39TP',
	'JZ001J39TP',
	'PRJ001J39TP',
	'I005J39',
	'E002JPTPJ39',
	'I005PJ39',
	'JCF001J39',
	'JVC001J39',
	'E001LAEPCJ39',
	'E002JPJ39',
	'E002KJJ39',
	'PD001J39',
	'P001J39P',
	'I002J39',
	'I004J39',
	'I003J39',
	'JP001J39',
	'D001J39',
	'E002LAE01J39',
	'P001J39',
	'JP001TPJ39',
	'I004GAOJ39',
	'SUG001J39',
	'I005GAOJ39',
	'GGBVB001J39',
	'I003GAOJ39',
	'FA002J39',
	'D001GAOJ39',
	'B001GAOJ39',
	'E002LAE01GAOJ39',
	'E002KJGAOJ39',
	'P001J39GAO',
	'FA008J39',
	'SUT001J39',
	'SUP001J39',
	'JCF001GAOJ39',
	'I002GAOJ39',
	'I005BVB01J39',
	'I005BVB02J39',
	'JVC001BVBJ39',
	'JVD001BVBJ39',
	'dba001BVBJ39',
	'TBVBJ39',
	'FA001J39',
	'FA003J39',
	'P001BVBJ39P',
	'JVD001J39TP',
	'JP001BVBJ39',
	'JOBVBP001J39',
	'B001BVBJ39',
	'D001BVBJ39',
	'D002BVBJ39'
	)
	;