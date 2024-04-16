
/*
select * from users u where username in ('ulilab1210141');
select code_trans, created_at, transaction_date 
from "transaction" t 
where to_char(t.transaction_date, 'YYYY-MM-DD') > to_char(t.created_at, 'YYYY-MM-DD') 
	and t.status in('PC', 'S', 'A', 'I')
	 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2023-11-01' and '2023-11-20'; --t.code_trans in ('Q1ONGB');
select td.id, td.base_price, b.harga_1, td.qty, round((td.sell_price / 1.11) * td.qty, 2) as "DPP", round((b.harga_1 / 1.11) * td.qty , 2) as "DPP_2", td.* 
from transaction_detail td 
	 inner join barang b on td.id_barang_fk = b.id
where td.id_trans_fk in (143303, 143296);
select sum(round(td.sell_price / 1.11, 2)) from transaction_detail td where td.id_trans_fk in (143296);
select * from barang b;
select round(1.5, 0);
*/


-- =============================================================================================================================
-- START PPN SALES MEMBER
-- =============================================================================================================================

	-- TRANSACTION HEADER
	select 
			1 as "tax_no", 
			t.id as "ID_TRANS_HDR", 
			t.id as "ID_TRANS_DET", 
			'FK' as "tax_type", 
			'01' as "KD_JENIS_TRANSAKSI", 
			'0' as "FG_PENGGANTI", 
			'00000' as "NOMOR_FAKTUR",
			to_char(t.transaction_date, 'MM') as "MASA_PAJAK", 
			to_char(t.transaction_date, 'YYYY') as "TAHUN_PAJAK", 
			to_char(t.transaction_date, 'MM/DD/YYYY') as "TANGGAL_FAKTUR", 
			case when u.no_npwp is null then '000000000000000' else translate(u.no_npwp, '.,-, ', '') end as "NPWP", 
			u.nama as "NAMA",
			ap.provinsi as "ALAMAT_LENGKAP", 
			sum(round((b.harga_1 / 1.11) * td2.qty , 0)) as "JUMLAH_DPP",
			sum(round(round((b.harga_1 / 1.11) * td2.qty , 0) * 0.11, 0)) as "PPN", 
			0 as "JUMLAH_PPNBM", 
			0 as "ID_KETERANGAN_TAMBAHAN", 
			0 as "FG_UANG_MUKA", 
			0 as "UANG_MUKA_DPP", 
			0 as "UANG_MUKA_PPN",
			0 as "UANG_MUKA_PPNBM", 
			translate(u.no_ktp, '.,-, ', '') as "REFERENSI", 
			t.code_trans as "KODE_DOKUMEN_PENDUKUNG"
	from "transaction" t  
		inner join transaction_detail td2 on t.id = td2.id_trans_fk
		inner join barang b on td2.id_barang_fk = b.id
		left outer join memberships m on t.id_cust_fk = m.jbid 
		left outer join users u on m."owner" = u.uid 
		left outer join alamat_provinsi ap on ap.id = u.provinsi::bigint
	where t.status in('PC', 'S', 'A', 'I')
--		 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-03-01' and '2024-02-29'
		 and to_char(t.transaction_date, 'YYYY-MM') = '2024-03'
		 and t.deleted_at is null 
		 and m.username not in ('joy201741')
	--	 and t.code_trans in ('Q1ONGB', 'JIZUU8', 'PGHMEV', '2JD52F','B7BEIX')
		 AND b.kode not in ('MK001L','MK001M','MC002L','MC002XL','MC002S','MC002XXL','MK002M','MC006jp','MC006jps','MC006core','MT0002','MK001Lf','MK001XLf','MK004',
										'MC006yg','MC001APS','MC001APM','MC001APXXL','MK005','MC000G2','MK006','MT0004','MT0005','MC000G4','MK007','RC001','MC001TGS','MK002MP',
										'M001MM','M001MMP','M001MMPM','TDMO0014','MT001AR','MC0017S','MC0017M','MC0017L','MC0017XL','MC0017XXL','MC0017XXXL','MT002AR','MT003AR',
										'MT001JK','MT001T','RTS002','RTS003','MC001KXL','MC001KXXL','MT006AR','MT007AR','MT008AR','MC007','MC006ygp','MC008','MC009','MC010','MC001LGL',
										'MC001LGXL','MC001LGXXL','MC001RMXLJ34','MC011','FSTA001','FSTA002','FSTA003','FSTA004','FSTA005','FSTA006','MC012','MC001BPL','MC001BPXXL',
										'MC001WRL','MC001WRXXL','TJ001','TJ002','TJ003','TJ004','TJ005','TJ006','TJ007','TJ008','TJ009','TJ010','PSTJ001','RTS004','TJ006','KJ001'
										)
--		and ap.provinsi is NULL
--		and u.no_npwp is not NULL
	group by t.id, u.no_npwp, u.nama, u.no_ktp, ap.provinsi
	having sum(round((b.harga_1 / 1.11) * td2.qty , 0)) > 0 and sum(round((b.harga_1 / 1.11) * td2.qty , 0)) is not null
	order by t.transaction_date, t.id;
	
	
	-- NPWP JOYBIZ
	select 2 as "tax_no", 
			t.id as "id", 
			t.id as "id", 
			'FAPR' as "LT", 
			'PT JOY BUSINESS INTERNATIONAL' as "NPWP", 
			'BUSINESS PARK KEBON JERUK A18, JL. RAYA MERUYA ILIR KAV.88, MERUYA UTARA, KEMBANGAN, JAKARTA BARAT, DKI JAKARTA' as "NAMA", 
			'' as "JALAN", 
			'' as "BLOK", 
			'' as "NOMOR", 
			'' as "RT", 
			'' as "RW", 
			'' as "KECAMATAN", 
			'' as "KELURAHAN", 
			'' as "KABUPATEN", 
			'' as "PROPINSI", 
			'' as "KODE_POS", 
			'' as "NOMOR_TELEPON"
	from "transaction" t  
		inner join transaction_detail td2 on t.id = td2.id_trans_fk
		inner join barang b on td2.id_barang_fk = b.id
		left outer join memberships m on t.id_cust_fk = m.jbid
	where  t.status in('PC', 'S', 'A', 'I')
--		 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-02-01' and '2024-02-29'
		 and to_char(t.transaction_date, 'YYYY-MM') = '2024-03'
		 and t.deleted_at is null 
		 and m.username not in ('joy201741')
	--	 and t.code_trans in ('Q1ONGB', 'JIZUU8', 'PGHMEV', '2JD52F','B7BEIX')
		  AND b.kode not in ('MK001L','MK001M','MC002L','MC002XL','MC002S','MC002XXL','MK002M','MC006jp','MC006jps','MC006core','MT0002','MK001Lf','MK001XLf','MK004',
										'MC006yg','MC001APS','MC001APM','MC001APXXL','MK005','MC000G2','MK006','MT0004','MT0005','MC000G4','MK007','RC001','MC001TGS','MK002MP',
										'M001MM','M001MMP','M001MMPM','TDMO0014','MT001AR','MC0017S','MC0017M','MC0017L','MC0017XL','MC0017XXL','MC0017XXXL','MT002AR','MT003AR',
										'MT001JK','MT001T','RTS002','RTS003','MC001KXL','MC001KXXL','MT006AR','MT007AR','MT008AR','MC007','MC006ygp','MC008','MC009','MC010','MC001LGL',
										'MC001LGXL','MC001LGXXL','MC001RMXLJ34','MC011','FSTA001','FSTA002','FSTA003','FSTA004','FSTA005','FSTA006','MC012','MC001BPL','MC001BPXXL',
										'MC001WRL','MC001WRXXL','TJ001','TJ002','TJ003','TJ004','TJ005','TJ006','TJ007','TJ008','TJ009','TJ010','PSTJ001','RTS004','TJ006','KJ001'
										)
	group by t.id
	having sum(round((b.harga_1 / 1.11) * td2.qty , 0)) > 0 and sum(round((b.harga_1 / 1.11) * td2.qty , 0)) is not null
	order by t.transaction_date, t.id;

				
	-- TRANSACTION DETAIL
	select 3 as "tax_no", 
			td.id_trans_fk, 
			td.id, 
			'OF' as "OF", 
			b.kode as "KODE_OBJEK", 
			b.nama as "NAMA",
			round(b.harga_1 / 1.11 , 0) as "HARGA_SATUAN", 
			td.qty as "JUMLAH_BARANG",
			round((b.harga_1 / 1.11) * td.qty , 0) as "HARGA_TOTAL", 
			0 as "DISKON",  
			round((b.harga_1 / 1.11) * td.qty , 0) as "DPP", 
			round(round((b.harga_1 / 1.11) * td.qty , 0) * 0.11, 0) as "PPN", 
			0 as "TARIF_PPNBM",
			0 as "PPNBM"
	from "transaction" t  
		inner join transaction_detail td on t.id = td.id_trans_fk 
		inner join barang b on td.id_barang_fk = b.id  
		left outer join memberships m on t.id_cust_fk = m.jbid 
		left outer join users u on m."owner" = u.uid 
	where t.status in('PC', 'S', 'A', 'I')
--		 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-02-01' and '2024-02-29'
		 and to_char(t.transaction_date, 'YYYY-MM') = '2024-03'
		 and t.deleted_at is null 
		 and b.kode not in ('MK001L','MK001M','MC002L','MC002XL','MC002S','MC002XXL','MK002M','MC006jp','MC006jps','MC006core','MT0002','MK001Lf','MK001XLf','MK004',
							'MC006yg','MC001APS','MC001APM','MC001APXXL','MK005','MC000G2','MK006','MT0004','MT0005','MC000G4','MK007','RC001','MC001TGS','MK002MP',
							'M001MM','M001MMP','M001MMPM','TDMO0014','MT001AR','MC0017S','MC0017M','MC0017L','MC0017XL','MC0017XXL','MC0017XXXL','MT002AR','MT003AR',
							'MT001JK','MT001T','RTS002','RTS003','MC001KXL','MC001KXXL','MT006AR','MT007AR','MT008AR','MC007','MC006ygp','MC008','MC009','MC010','MC001LGL',
							'MC001LGXL','MC001LGXXL','MC001RMXLJ34','MC011','FSTA001','FSTA002','FSTA003','FSTA004','FSTA005','FSTA006','MC012','MC001BPL','MC001BPXXL',
							'MC001WRL','MC001WRXXL','TJ001','TJ002','TJ003','TJ004','TJ005','TJ006','TJ007','TJ008','TJ009','TJ010','PSTJ001','RTS004','TJ006','KJ001'
							)
		 and m.username not in ('joy201741')
	--	 and t.code_trans in ('Q1ONGB', 'JIZUU8', 'PGHMEV', '2JD52F')
		 and round(b.harga_1 / 1.11 , 0) > 0
	order by t.transaction_date, t.id;
							
						

-- =============================================================================================================================
-- END PPN SALES MEMBER
-- =============================================================================================================================