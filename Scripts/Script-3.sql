SELECT x.* 
FROM public.barang x
WHERE x.kode = 'SUT001J34'
--or x.id in (select bd.id_barang_fk::int from barang_detail bd where id_induk_fk::int = 1298);
