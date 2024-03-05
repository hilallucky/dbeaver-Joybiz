			
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
					case when u.no_npwp is null then '000000000000000' else u.no_npwp end as "NPWP", 
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
					u.no_ktp as "REFERENSI", 
					t.code_trans as "KODE_DOKUMEN_PENDUKUNG"
			from "transaction" t  
				inner join transaction_detail td2 on t.id = td2.id_trans_fk
				inner join barang b on td2.id_barang_fk = b.id
				left outer join memberships m on t.id_cust_fk = m.jbid 
				left outer join users u on m."owner" = u.uid 
				left outer join alamat_provinsi ap on ap.id = u.provinsi::bigint
			where t.status in('PC', 'S', 'A', 'I')
				 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-02-01' and '2024-02-29'
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
				 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-02-01' and '2024-02-29'
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
				 and to_char(t.transaction_date, 'YYYY-MM-DD') between '2024-02-01' and '2024-02-29'
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
			order by t.transaction_date, t.id;
									
			
			-- =============================================================================================================================
			-- END PPN SALES MEMBER
			-- =============================================================================================================================
		
		
select m.username , t.* from "transaction" t left outer join memberships m on m.jbid = t.id_cust_fk 
where (code_trans in ('FDEPI6') or m.username in ('nazili2705651')) and (t.voucher_amount > 0 or t.voucher_amount = 0)
order by voucher_amount desc; -- UVCI2023102399539
select * from memberships m where jbid = 23055340893; -- or "owner" = '4ce8cc1e-6f07-4131-9bb9-ef11d09d8a11';
select * from vouchers v where "owner" = 'c53131c3-d9ae-4e62-9a2b-d434bda60395';
select * from voucher_details vd where "owner" = 'c53131c3-d9ae-4e62-9a2b-d434bda60395' or code ilike 'VCI2023102399539';
select * from voucher_cashbacks vc where owner_id in ('c53131c3-d9ae-4e62-9a2b-d434bda60395','c53131c3-d9ae-4e62-9a2b-d434bda60395');
select * from voucher_cashback_details vcd where owner_id = 'c53131c3-d9ae-4e62-9a2b-d434bda60395' or transaction_code in ('FDEPI6');


select -- bd.*, 
		t.id_barang_fk as "Product Code", t."name" as "Desc", t.total_barang as "Sold Unit", bd.qty as "Unit (pcs)", t.total_barang * bd.qty "Total Unit Out" 
from barang_detail bd
	 join (
			select td.id_barang_fk, td."name", sum(td.qty) as total_barang
			from "transaction" t
				join transaction_detail td on t.id = td.id_trans_fk
			where 
				td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
					select bd.id_induk_fk
					from barang_detail bd 
--					where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
				) 
				and t.transaction_date BETWEEN '2023-12-01' and '2023-12-27'
--				'2023-08-31' and '2023-09-27'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
where bd.id_barang_fk in (4,255,326,457,459,461,463, 747, 823)   
ORDER BY bd.id_induk_fk asc;

select t.id, t.transaction_date, t.created_at, t.code_trans, td.id, td.id_barang_fk, td."name", td.qty 
from "transaction" t 
		left outer join transaction_detail td on t.id = td.id_trans_fk 
where td.id_barang_fk in (995, 879)
	 and t.status in('PC', 'S', 'A', 'I') -- PAID
order by t.transaction_date desc;

select * from barang_detail bd where id_induk_fk  in (879);

-- EDIT STEP 3
select -- bd.*, 
		b.id, b.kode, b.nama,
		t.id_barang_fk as "Product Code", t."name" as "Desc", t.total_barang as "Sold Unit", bd.qty as "Unit (pcs)", t.total_barang * bd.qty "Total Unit Out" 
from barang_detail bd
	 join (
			select td.id_barang_fk, td."name", sum(td.qty) as total_barang
			from "transaction" t
				join transaction_detail td on t.id = td.id_trans_fk
			where 
				td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
					select bd.id_induk_fk
					from barang_detail bd 
--					where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
				) 
				and 
					-- to_char(t.transaction_date, 'YYYY-MM') = '2024-02' 
					t.transaction_date BETWEEN '2023-12-01' and '2023-12-27'
					-- '2023-08-31' and '2023-09-27'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
				and t.deleted_at is null and t.transaction_date is not null
			GROUP BY td."id_barang_fk",td."name"
			ORDER BY td.id_barang_fk
			) t on bd.id_induk_fk = t.id_barang_fk
	join barang b on bd.id_barang_fk = b.id 
where bd.id_barang_fk in (
					4,255,326,457,459,461,463, 747, 823 --, -- --Joymunemax
				)   
ORDER BY 
	-- bd.id_induk_fk asc
	b.nama, b.id, b.kode, t.id_barang_fk
;