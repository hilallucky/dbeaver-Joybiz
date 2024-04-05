
-- ============================================================================================
-- START REPORT COUNT OF MEMBER REGISTRATION BY PERIOD
/*
 select to_char(u.activated_at, 'YYYY-MM') as "Period", count(u.username) as "Total Member"
 from users u 
 where to_char(u.activated_at, 'YYYY-MM') between '2023-01' and '2024-02'
 group by to_char(u.activated_at, 'YYYY-MM') 
 ;
 */
	
	
	
	select CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
		CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", 
		r1."Period", r1."Total Member",
		coalesce(lag(r1."Total Member", 1) over (order by r1."Period"),0) as "Prev Total Member",
		r1."Total Member" - coalesce(lag(r1."Total Member", 1) over (order by r1."Period"),0) as "Diff",
		round((100 * (r1."Total Member" - lag(r1."Total Member", 1) over (order by r1."Period")) / lag(r1."Total Member", 1) over (order by r1."Period")),2) || '%' as "Growth"
	from (
			select
				to_char(u.activated_at, 'YYYY-MM') as "Period", 
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				count(u.username) as "Total Member"
			from 
				users u 
				left outer join alamat_provinsi ap on u.provinsi::int =ap.id  
				left outer join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
			where 
				u.deleted_at is null and
--				 to_char(u.activated_at, 'YYYY-MM-DD') between '2024-01-01' and '2024-03-07'
				 to_char(u.activated_at, 'YYYY-MM') between '2024-03' and '2024-03'
			group by to_char(u.activated_at, 'YYYY-MM'), ap.provinsi, ak.kabupaten
			order by 
					INITCAP(ap.provinsi), INITCAP(ak.kabupaten), 
					to_char(u.activated_at, 'YYYY-MM'), ap.provinsi, ak.kabupaten
		) r1
	group by r1."Provinsi", r1."Kabupaten", r1."Period", r1."Total Member"
	order by r1."Provinsi", r1."Kabupaten"
	;	


-- END REPORT COUNT OF MEMBER REGISTRATION BY PERIOD
-- ============================================================================================


