-- step 1
select * from barang b where id in (select id_induk_fk from barang_detail where id_barang_fk in (4,255,326,457,459,461,463, 747, 823)) ;
select * from barang_detail bd 

select *
from barang_detail
where id_barang_fk in (4,255,326,457,459,461,463, 747, 823)
ORDER BY id_induk_fk ASC;

-- Step 2
select td.id_barang_fk, td."name", sum(td.qty) as total_barang
from "transaction" t
	join transaction_detail td on t.id = td.id_trans_fk
where 
	td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
		select bd.id_induk_fk
		from barang_detail bd 
		where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
	) 
	and t.transaction_date BETWEEN '2023-10-26' and '2023-11-30'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
	and t.deleted_at is null and t.transaction_date is not null
GROUP BY td."id_barang_fk",td."name"
ORDER BY td.id_barang_fk;

--select * from 


-- Step 3
-- Step 3
select * from barang_detail
where id_barang_fk in (4,255,326,457,459,461,463, 747, 823) 
and id_induk_fk in
(
995
) ORDER BY id_induk_fk asc





select bd.id, bd.id_induk_fk, b.nama , bd.id_barang_fk, bd.qty, bd.product_code 
from barang_detail bd
	 join barang b on bd.id_induk_fk = b.id 
where id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335) 
and id_induk_fk in
	( -- id_barang_fk dari query step 2
		select td.id_barang_fk
		from "transaction" t
			join transaction_detail td on t.id = td.id_trans_fk
		where 
			td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
				select bd.id_induk_fk
				from barang_detail bd 
				where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
			) 
			and t.transaction_date BETWEEN '2023-10-26' and '2023-11-30' -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
			and t.deleted_at is null and t.transaction_date is not null
		GROUP BY td."id_barang_fk",td."name"
		ORDER BY td.id_barang_fk
	) 
ORDER BY id_induk_fk asc;






select bd.id_induk_fk, t1.id_barang_fk, t1."name", t1.total_barang, bd.qty, t1.total_barang * bd.qty as "Total"
from (
		select td.id_barang_fk, td."name", sum(td.qty) as total_barang
		from "transaction" t
			join transaction_detail td on t.id = td.id_trans_fk
		where 
			td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
				select bd.id_induk_fk
				from barang_detail bd 
				where bd.id_barang_fk in (3,254,325, 695, 746, 822, 923, 996, 1064, 1148, 1205, 1263, 1335)
			) 
			and t.transaction_date BETWEEN '2023-10-26' and '2023-11-30'  -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
			and t.deleted_at is null and t.transaction_date is not null
		GROUP BY td."id_barang_fk",td."name"
		ORDER BY td.id_barang_fk
	) t1
join barang_detail bd on -- bd.id_barang_fk = t1.id_barang_fk --and 
	bd.id_induk_fk = t1.id_barang_fk
group by bd.id_induk_fk, t1.id_barang_fk, t1."name", t1.total_barang, bd.qty
;









--
--
--DO 
--	$$
--	DECLARE id_barang_x UUID; 
--			var_two UUID;  
--	BEGIN
--		select into id_barang_x
--		from barang_detail bd 
--		where bd.id_barang_fk in (4,255,326,457,459,461,463, 747, 823);
--	
--	
--		--	STEP 3
--		select * 
--		from barang_detail
----		where id_barang_fk in (id_barang_x)
----		and id_induk_fk in
----			( -- id_barang_fk dari query step 2
----				select td.id_barang_fk
----				from "transaction" t
----					join transaction_detail td on t.id = td.id_trans_fk
----				where 
----					td.id_barang_fk IN ( -- id_induk_fk dari table barang_detail
----						select bd.id_induk_fk
----						from barang_detail bd 
----						where bd.id_barang_fk in (id_barang_x)
----					) 
----					and t.transaction_date BETWEEN '2023-09-28' and '2023-10-25' -- (kamis pertama di bulan berjalan sampai rabu terakhir di bulan selanjutnya)
----					and t.deleted_at is null and t.transaction_date is not null
----				GROUP BY td."id_barang_fk",td."name"
----				ORDER BY td.id_barang_fk
----			) 
--		ORDER BY id_induk_fk asc;
--	END;
--	$$;



-- import PPH
select m.username , bw.*
from bonus_weeklies bw
	join memberships m on bw."owner" = m."owner" 
where m.username ilike 'rohime07034%'
order by bw.wid desc;




select * from users u where u.username in ('saswin0512941','mohamm2211741') ;-- email in ('mohammad97@gmail.com','sumarni75@gmail.com');


