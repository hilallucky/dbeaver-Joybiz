

/* 
 * 1 = PICKUP MPU/PUC
 * 2 = SHIP TO ADDRESS
 * ===============================================================================================================================================================
 * START OMZET COMPARISON CUR MONTH AND PREV MONTH
 * ===============================================================================================================================================================
 */
	select -- t.code_trans, 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
	from "transaction" t 
	where 
		t.deleted_at is null
		and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
		and t.transaction_date::date between '2024-02-01' and '2024-03-27'
	group by to_char(t.transaction_date, 'YYYY-MM')
	order by to_char(t.transaction_date, 'YYYY-MM')
				

/* 
 * ===============================================================================================================================================================
 * START OMZET COMPARISON CUR MONTH AND PREV MONTH
 * ===============================================================================================================================================================
 */



--




select * from "transaction" t where t.is_pickup = 1;
	 
/* 
 * 1 = PICKUP MPU/PUC
 * 2 = SHIP TO ADDRESS
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN USERNAME MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */
select r1."Period", r1."Kabupaten", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			join memberships m on (t.id_cust_fk = m.jbid)
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
			join users u on m.username = u.username 
			join alamat_provinsi ap on u.provinsi::int =ap.id  
			join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
		where 
			m.username in ('maisir160464',
							'iputug040329',
							'inyoma230330',
							'inyoma040682',
							'imades220316',
							'gedear121126',
							'usnawi040575',
							'iwayan020430'
							)
			and t.deleted_at is null
			and t.status in('PC', 'S', 'A', 'I') -- PAID
			and t.transaction_date::date between '2022-12-01' and '2024-11-30'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
		order by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
	) r1
;	





select r1."Period Insert", r1."Period", r1."username", r1.nama, r1."Purchase Cost", r1."BV", r1."PV", r1."RV"
from (
		select 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			to_char(t.created_at, 'YYYY-MM') as "Period Insert", 
			m.username, u.nama,
			sum(t.purchase_cost) as "Purchase Cost", 
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from memberships m
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
			join users u on m.username = u.username 
			left outer join "transaction" t on (t.id_cust_fk = m.jbid)
		where 
			m.username in ('maisir160464',
							'iputug040329',
							'inyoma230330',
							'inyoma040682',
							'imades220316',
							'gedear121126',
							'usnawi040575',
							'iwayan020430'
							)
--			and t.deleted_at is null
			and t.status in('PC', 'S', 'A', 'I') -- PAID
--			and t.transaction_date::date between '2022-12-01' and '2024-11-30'
		group by m.username, u.nama, to_char(t.transaction_date, 'YYYY-MM'), to_char(t.created_at, 'YYYY-MM')
		order by m.username, u.nama, to_char(t.transaction_date, 'YYYY-MM')
	) r1
;	

/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN USERNAME MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


	 
/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN DOMISILI MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


	/*
	m.id, m.uid, m.owner, m.jbid, m.username, 
--		m2.jbid, m2.username, 
		u.nama, u.provinsi, ap.provinsi, u.kota_kabupaten, ak.kabupaten,
		t.deleted_at, t.status,
	   t.id , t.transaction_date, to_char(t.transaction_date, 'YYYY-MM') as "period", t.code_trans, t.id_cust_fk, t.id_sc_fk, t.bv_total, t.pv_total, t.rv_total
	   */
--commit;

select sum(t.purchase_cost), sum(t.bv_total)
from "transaction" t 
	left outer join memberships m on (t.id_cust_fk = m.jbid)
	left outer join users u on m."owner" = u.uid
	left outer join alamat_provinsi ap on u.provinsi::int =ap.id  
	left outer join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
where to_char(t.transaction_date, 'YYYY-MM') = '2024-09'
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A') --, 'I') -- PAID
--t.transaction_date::date between '2024-08-01' and '2024-11-30'
;

select r1."Provinsi", r1."Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2024-08' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-08",
	sum(CASE WHEN r1."Period" = '2024-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-09",
	sum(CASE WHEN r1."Period" = '2024-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-10",
	sum(CASE WHEN r1."Period" = '2024-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-11"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			join memberships m on (t.id_cust_fk = m.jbid)
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
			join users u on m."owner" = u.uid
			join alamat_provinsi ap on u.provinsi::int =ap.id  
			join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
		where 
		--	u.provinsi::int = 72
		--	and u.kota_kabupaten::int = 7271 --PALU
		--	and 
			t.deleted_at is null
--			and t.status in('PC', 'S', 'A', 'I') -- PAID
			and t.transaction_date::date between '2024-08-01' and '2024-11-30'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
		order by 
				INITCAP(ap.provinsi), INITCAP(ak.kabupaten), 
				to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
;	

select * 
from "transaction" t
where code_trans in ('LMYH7Y','GEQE74','GUCCFX');

select * from users u where nama ilike 'test lagi' order by created_at desc;
select * from memberships m  
--where username in ('testla1412441',';testla1412621') 
order by created_at desc
limit 10;
--56334 56331

SELECT MAX(id) FROM memberships m ;

SELECT nextval('memberships_id_seq');

SELECT pg_catalog.setval(pg_get_serial_sequence('memberships', 'id'), MAX(id)) FROM memberships;


/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN DOMISILI MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */



/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN DOMISILI MEMBER MONTHLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2023-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-11",
	sum(CASE WHEN r1."Period" = '2023-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-12",
	sum(CASE WHEN r1."Period" = '2024-01' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-01",
--	sum(CASE WHEN r1."Period" = '2024-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-11"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select -- t.code_trans, 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
			left outer join users u on m.username = u.username 
			left outer join alamat_provinsi ap on u.provinsi::int =ap.id  
			left outer join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
		where 
		--	u.provinsi::int = 72
		--	and u.kota_kabupaten::int = 7271 --PALU
		--	and 
			t.deleted_at is null
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2023-11-01' and '2024-01-31'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		order by 
				INITCAP(ap.provinsi), INITCAP(ak.kabupaten), 
				to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN DOMISILI MEMBER MONTHLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN TUJUAN PENGIRIMAN MONTHLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	select * from "transaction" t where is_pickup = 1; 
	select * from stock_packs sp ;
	select * from alamat_kabupaten ak where id in (3174,7371);
 */

select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2023-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-11",
	sum(CASE WHEN r1."Period" = '2023-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-12",
	sum(CASE WHEN r1."Period" = '2024-01' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-01",
	sum(CASE WHEN r1."Period" = '2024-02' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-02" --,
--	sum(CASE WHEN r1."Period" = '2024-03' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-03",
--	sum(CASE WHEN r1."Period" = '2024-04' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-04",
--	sum(CASE WHEN r1."Period" = '2024-05' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-05",
--	sum(CASE WHEN r1."Period" = '2024-06' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-06",
--	sum(CASE WHEN r1."Period" = '2024-07' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-07",
--	sum(CASE WHEN r1."Period" = '2024-08' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-08",
--	sum(CASE WHEN r1."Period" = '2024-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-09",
--	sum(CASE WHEN r1."Period" = '2024-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-10",
--	sum(CASE WHEN r1."Period" = '2024-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-11",
--	sum(CASE WHEN r1."Period" = '2024-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-12"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select -- t.code_trans, 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--			left outer join users u on m.username = u.username 
			left outer join stock_packs sp on t.pickup_stock_pack = sp.code
			left outer join alamat_provinsi ap on sp.province::int =ap.id  
			left outer join alamat_kabupaten ak on sp.district::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 1 -- PICKUP PUC/MPU
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2023-11-01' and '2024-12-31' -- now() --'2024-12-10'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
				
		union all
		
		select -- t.code_trans, 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
			left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 2 -- SENT to ADDRESS
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2023-11-01' and '2024-12-31' -- now() --'2024-12-10'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
--ROLLUP (r1."Provinsi", r1."Kabupaten")
order by r1."Provinsi", r1."Kabupaten"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN TUJUAN PENGIRIMAN MONTHLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */





/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	select * from "transaction" t where is_pickup = 1; 
	select * from ;_packs sp ;
	select * from alamat_kabupaten ak where id in (3174,7371);
 */

select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '25-31 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "25-31 JAN 2024",
	sum(CASE WHEN r1."Period" = '01-07 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "01-07 JAN 2024",
	sum(CASE WHEN r1."Period" = '08-14 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "08-14 JAN 2024",
	sum(CASE WHEN r1."Period" = '15-21 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "15-21 JAN 2024",
	sum(CASE WHEN r1."Period" = '22-28 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "22-28 JAN 2024",
	sum(CASE WHEN r1."Period" = '29-04 FEB 2024' THEN r1."Purchase Cost" else 0 end) AS "29-04 FEB 2024"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		(
			select 
				'25-31 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-25' and '2024-12-31'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'week5 25-31 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-25' and '2024-12-31'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'01-07 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-01' and '2024-01-07'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'01-07 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-01' and '2024-01-07'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'08-14 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-08' and '2024-01-14'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'08-14 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-08' and '2024-01-14'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'15-21 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-15' and '2024-01-21'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'15-21 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-15' and '2024-01-21'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'22-28 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-22' and '2024-01-28'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'22-28 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-22' and '2024-01-28'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'29-04 FEB 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-29' and '2024-02-04'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'29-04 FEB 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-01-29' and '2024-02-04'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
--ROLLUP (r1."Provinsi", r1."Kabupaten")
order by r1."Provinsi", r1."Kabupaten"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */



/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN TUJUAN PENGIRIMAN YEARLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	select * from "transaction" t where is_pickup = 1; 
	select * from stock_packs sp ;
	select * from alamat_kabupaten ak where id in (3174,7371);
 */

select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", r1."Period",
	r1."Purchase Cost"
--	,r1.code_trans
from (
		select  --t.code_trans, 
			EXTRACT('Year' FROM t.transaction_date) as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join stock_packs sp on t.pickup_stock_pack = sp.code
			left outer join alamat_provinsi ap on sp.province::int =ap.id  
			left outer join alamat_kabupaten ak on sp.district::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 1 -- PICKUP PUC/MPU
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and EXTRACT('Year' FROM t.transaction_date) BETWEEN 2021 and 2023
		group by EXTRACT('Year' FROM t.transaction_date), ap.provinsi, ak.kabupaten --, t.code_trans
				
		union all
		
		select  --t.code_trans, 
			EXTRACT('Year' FROM t.transaction_date) as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
			left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 2 -- SENT to ADDRESS
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and EXTRACT('Year' FROM t.transaction_date) BETWEEN 2021 and 2023
		group by EXTRACT('Year' FROM t.transaction_date), ap.provinsi, ak.kabupaten --, t.code_trans
	) r1
--where r1."Kabupaten" ilike '%jember%' and r1."Provinsi" = 'Jawa Tengah'
group by r1."Provinsi", r1."Kabupaten", r1."Period", r1."Purchase Cost" --, r1.code_trans
--ROLLUP (r1."Provinsi", r1."Kabupaten")
order by r1."Provinsi", r1."Kabupaten"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN TUJUAN PENGIRIMAN YEARLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


select * from "transaction" t where code_trans in ('DD3ENW','KOMJCM');
select * from alamat_provinsi ap where id in (35);
select * from alamat_kabupaten ak where id in (3526) or ak.kabupaten ilike '%mamuju%';
select * from alamat_kecamatan ak where ak.kecamatan ilike '%bangkalan%'; --ak.id_kabupaten in (7605) order by kecamatan ; -- and 
select * from alamat_kelurahan ak;



select * from week_periodes wp order by "eDate" desc;


select id, transaction_date, purchase_cost, bv_total, pv_total, rv_total,
	   case 
	   	when 
	   end
	   
from "transaction" t 
where transaction_date between (select min (wp."sDate") from week_periodes wp where wp."name" like '23.12.%')
	and (select min (wp."eDate") from week_periodes wp where wp."name" like '23.12.%')
order by transaction_date ;


select * from alamat_provinsi ap where id = 51;



select --transaction_date, 
		wp."name", wp."sDate", wp."eDate", 
		INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--		ap.id, ak.id,
		sum(purchase_cost) as purchase_cost, sum(bv_total) as bv_total, sum(pv_total) as pv_total, sum(rv_total) as rv_total,
		(
			select count(*)
			from users u 
			where u.flag = 1 and (u.activated_at::date between wp."sDate" and wp."eDate") and u.deleted_at is null
				 and u.provinsi::int = ap.id and u.kota_kabupaten::int = ak.id
		) as "total_member"
from 	"transaction" t 
	  	left outer join week_periodes wp on (transaction_date >= wp."sDate" and transaction_date <= wp."eDate") 
		left outer join stock_packs sp on t.pickup_stock_pack = sp.code
		left outer join alamat_provinsi ap on sp.province::int =ap.id 
		left outer join alamat_kabupaten ak on sp.district::int = ak.id
where wp."name" like '23.11.%' or wp."name" like '23.12.%'
		and t.deleted_at is null
		and t.is_pickup = 1 -- PICKUP PUC/MPU
		and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
		
--		and t.transaction_date::date between '2024-11-27' and '2024-12-03'
group by --transaction_date, 
	wp."sDate", wp."eDate", wp."name"
--	to_char(t.transaction_date, 'YYYY-MM'), 
	,ap.provinsi, ak.kabupaten --t.code_trans,
	,ap.id, ak.id
order by wp."name" 
--transaction_date 
;




select count(*) --u.activated_at::date, wp."sDate", wp."eDate", wp,"name"
	   , u.flag, u.provinsi, kota_kabupaten 
from users u 
	join week_periodes wp on (u.activated_at::date >= wp."sDate" and u.activated_at::date <= wp."eDate")
where wp."name" like '23.12.%' and u.deleted_at is null and u.activated_at::date is not null
group by u.flag, u.provinsi, kota_kabupaten  ;

/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY TUTUP POINT
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = 'week1 27 NOV-03 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "Week1 27 NOV-03 JAN 2024",
	sum(CASE WHEN r1."Period" = 'week2 04-10 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "Week2 04-10 JAN 2024",
	sum(CASE WHEN r1."Period" = 'week3 11-17 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "Week3 11-17 JAN 2024"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		(
			select 
				'week1 27 NOV-03 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-11-27' and '2024-12-03'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'week1 27 NOV-03 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-11-27' and '2024-12-03'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'week2 04-10 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-04' and '2024-12-10'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'week2 04-10 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-04' and '2024-12-10'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
		
		union all
		
		(
			select 
				'week3 11-17 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
	--			left outer join users u on m.username = u.username 
				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
				left outer join alamat_provinsi ap on sp.province::int =ap.id  
				left outer join alamat_kabupaten ak on sp.district::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 1 -- PICKUP PUC/MPU
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-11' and '2024-12-17'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
					
			union all
			
			select -- t.code_trans, 
				'week3 11-17 JAN 2024' as "Period",
				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
			from "transaction" t 
				left outer join memberships m on (t.id_cust_fk = m.jbid)
				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
			where 
				t.deleted_at is null
				and t.is_pickup = 2 -- SENT to ADDRESS
				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
				and t.transaction_date::date between '2024-12-11' and '2024-12-17'
			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		)
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
--ROLLUP (r1."Provinsi", r1."Kabupaten")
order by r1."Provinsi", r1."Kabupaten"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY TUTUP POINT
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */







select 
from "transaction" t 
where transaction_date 


select 	current_date - extract(isodow from current_date)::integer-13 as Monday,
		current_date - extract(isodow from current_date)::integer-5 as Tuesday,
		current_date - extract(isodow from current_date)::integer-4 as Wednesday,
		current_date - extract(isodow from current_date)::integer-3 as Thursday,
	   	current_date - extract(isodow from current_date)::integer-2 as Friday,
	   	current_date - extract(isodow from current_date)::integer-1 as Saturday,
	   	current_date - extract(isodow from current_date)::integer as Sunday,
	   	current_date
	   ;

select extract(day from TIMESTAMP '2024-12-04 00:00:00')::int / 7 + 1 as week_in_month;

SELECT t.d1::DATE
FROM GENERATE_SERIES
     (
       TIMESTAMP '2024-12-01',
       TIMESTAMP '2024-12-19',
       INTERVAL  '7 DAY'
     ) AS t(d1);
    
    
    
SELECT t.transaction_date , to_char(t.transaction_date, 'Day') as dayofweek 
FROM "transaction" t 
WHERE t.transaction_date  BETWEEN '2024-12-01' AND now()::date 
--	AND date_part('dow', t.transaction_date) in (5,0)
order by t.transaction_date ;
    

/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN DOMISILI MEMBER WEEKLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

select CASE WHEN r1."Provinsi" = null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" = null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2024-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-12"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select -- t.code_trans, 
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
		--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
			left outer join users u on m.username = u.username 
			left outer join alamat_provinsi ap on u.provinsi::int =ap.id  
			left outer join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
		where 
		--	u.provinsi::int = 72
		--	and u.kota_kabupaten::int = 7271 --PALU
		--	and 
			t.deleted_at is null
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2024-12-04' and '2024-12-10'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
		order by 
				INITCAP(ap.provinsi), INITCAP(ak.kabupaten), 
				to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
;	


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN DOMISILI MEMBER WEEKLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */




/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

select r1.username, r1.nama,
	sum(CASE WHEN r1."Period" = '2024-05' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-05",
	sum(CASE WHEN r1."Period" = '2024-06' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-06",
	sum(CASE WHEN r1."Period" = '2024-07' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-07",
	sum(CASE WHEN r1."Period" = '2024-08' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-08",
	sum(CASE WHEN r1."Period" = '2024-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-09",
	sum(CASE WHEN r1."Period" = '2024-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-10",
	sum(CASE WHEN r1."Period" = '2024-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-11",
	sum(CASE WHEN r1."Period" = '2024-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2024-12"
--	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
from (
		select -- t.code_trans, 
			m.username, u.nama,
			to_char(t.transaction_date, 'YYYY-MM') as "Period", 
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join users u on m.username = u.username 
--			left outer join users u on m.username = u.username 
		where 
--			m.username ilike 'indram0911961'
			m.spid = (select m3.jbid from memberships m3 where m3.username = 'indram0911961')
			and t.deleted_at is null
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and to_char(t.transaction_date, 'YYYY-MM') between '2024-10' and '2024-12'
		group by m.username, to_char(t.transaction_date, 'YYYY-MM'), u.nama
		order by 
				to_char(t.transaction_date, 'YYYY-MM'), m.username, u.nama
	) r1
group by r1.username, r1.nama
;	

select * from memberships m where username = 'indram0911961' or m.spid = 22115169320;

/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN DOMISILI MEMBER
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */


/*
select U.username, U.nama, u.provinsi, ap.provinsi, u.kota_kabupaten, ak.kabupaten 
from users u 	
	join alamat_provinsi ap on u.provinsi::int =ap.id  
	join alamat_kabupaten ak on u.kota_kabupaten::int = ak.id
where username ='abubak0208201';

select * from "transaction" t where t.id_cust_fk = 23085410030;

select * from "transaction" t where t.shipping_id is null and shipping_postcode is not NULL;
select * from memberships m where username ='abubak0208201';


select * from alamat_provinsi ap ;

select * from alamat_kabupaten ak where id_provinsi =72;
select * from alamat_kecamatan ak ;
select * from alamat_kelurahan ak ;
select * from alamat_kodepos ak ;

select * 
from users u 
where username in ('nurill2608961','bintan2608731','lusias0811781','lusias08117813','lusias08117812','asepsu19115913','asepsu1911591','asepsu19115912');
*/








/* 
 * ===============================================================================================================================================================
 * START OMZET BERDASARKAN TUJUAN PENGIRIMAN MONTHLY -- MARKETING -- LELA
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------

	select * from "transaction" t where is_pickup = 1; 
	select * from stock_packs sp ;
	select * from alamat_kabupaten ak where id in (3174,7371);
 */

/*
select 
	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten",
	r1."Period",
	r1."Purchase Cost"
from (
		select 
			to_char(t.transaction_date, 'YYYY-MM-DD') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join stock_packs sp on t.pickup_stock_pack = sp.code
			left outer join alamat_provinsi ap on sp.province::int =ap.id  
			left outer join alamat_kabupaten ak on sp.district::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 1 -- PICKUP PUC/MPU
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2023-11-01' and '2024-12-31' -- now() --'2024-12-10'
		group by to_char(t.transaction_date, 'YYYY-MM-DD'), ap.provinsi, ak.kabupaten --t.code_trans,
				
		union all
		
		select
			to_char(t.transaction_date, 'YYYY-MM-DD') as "Period", 
			INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
			sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
			sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
		from "transaction" t 
			left outer join memberships m on (t.id_cust_fk = m.jbid)
			left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
			left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
		where 
			t.deleted_at is null
			and t.is_pickup = 2 -- SENT to ADDRESS
			and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
			and t.transaction_date::date between '2023-11-01' and '2024-12-31' -- now() --'2024-12-10'
		group by to_char(t.transaction_date, 'YYYY-MM-DD'), ap.provinsi, ak.kabupaten --t.code_trans,
	) r1
where r1."Kabupaten" ilike '%makassar%'
--	  and (r1."Period" between '2024-05-22' and '2024-06-17')
group by r1."Provinsi", r1."Kabupaten", r1."Period", 
	r1."Purchase Cost"
order by r1."Provinsi", r1."Kabupaten"
;	
*/



select
	to_char(t.transaction_date, 'YYYY-MM') as "Period", 
	INITCAP(ap.provinsi) as "Provinsi", 
--	INITCAP(ak.kabupaten) as "Kabupaten",
	case
		when INITCAP(ap.provinsi) = 'Bengkulu' then 'Bengkulu'
		when INITCAP(ap.provinsi) = 'Lampung' then 'Lampung'
		when INITCAP(ap.provinsi) = 'Bali' then 'Bali'
		when INITCAP(ap.provinsi) = 'Palu' then 'Palu'
		else INITCAP(ak.kabupaten)
	end as "Kabupaten",
	sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost"
from "transaction" t 
	left outer join memberships m on (t.id_cust_fk = m.jbid)
	left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
	left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
where 
	t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
--	and t.transaction_date::date -- >= '2023-05-29'  --		between '2023-11-28' and '2023-12-27' -- now() --'2024-12-10'
	and to_char(t.transaction_date, 'YYYY-MM') between '2023-08' and '2024-03'
	and (
			ak.kabupaten ILIKE ANY(ARRAY['%Makassar%','%Banyuwangi%','%Kota Jambi%','%Jember%',
										 '%Bombana%','%Purbalingga%','%Buton%Tengah%',
										 '%mamuju%utara', --'%Pasang%kayu%',
										 '%Bau%bau%','%Cianjur%','%Tangerang%','%Madura%','%Kota%Bandung%',
										 '%Bangkalan%','%Sampang%','%Pamekasan%','%Sumenep%','%Kalianget%', --Madura
										 '%Cilegon%','%Surabaya%','%Lumajang%','%Palu%','%Garut%','%serang%']) 
			or ap.provinsi ILIKE ANY(ARRAY['%Bengkulu%','%Lampung%','%Bali%']) 
--			ak.kabupaten ILIKE ANY(ARRAY['%serang%']) 
		)
--	ak.kabupaten ilike '%bau%bau%'
--		NOT ILIKE ALL(ARRAY['%Bombana%','%Baubau%','%Makassar%','%Palu%'])
--	and ap.provinsi ilike '%b%ton%'
group by 
	to_char(t.transaction_date, 'YYYY-MM'), 
	ap.provinsi, ak.kabupaten --t.code_trans,
order by ap.provinsi, ak.kabupaten, to_char(t.transaction_date, 'YYYY-MM') 
;




select
	to_char(t.transaction_date, 'YYYY-MM') as "Period", 
	INITCAP(ap.provinsi) as "Provinsi", 
--	INITCAP(ak.kabupaten) as "Kabupaten",
	case
		when INITCAP(ap.provinsi) = 'Bengkulu' then 'Bengkulu'
		when INITCAP(ap.provinsi) = 'Lampung' then 'Lampung'
		when INITCAP(ap.provinsi) = 'Bali' then 'Bali'
		when INITCAP(ap.provinsi) = 'Palu' then 'Palu'
		else INITCAP(ak.kabupaten)
	end as "Kabupaten",
	sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost"
from "transaction" t 
	left outer join memberships m on (t.id_cust_fk = m.jbid)
	left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
	left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
where 
	t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
--	and t.transaction_date::date -- >= '2023-05-29'  --		between '2023-11-28' and '2023-12-27' -- now() --'2024-12-10'
	and to_char(t.transaction_date, 'YYYY-MM') between '2023-11' and '2024-03'
	and (
			ak.kabupaten ILIKE ANY(ARRAY['%garut%','%Bangkalan%']) 
			or ap.provinsi ILIKE ANY(ARRAY['%Bengkulu%','%Lampung%','%Bali%']) 
		)
--	ak.kabupaten ilike '%bau%bau%'
--		NOT ILIKE ALL(ARRAY['%Bombana%','%Baubau%','%Makassar%','%Palu%'])
--	and ap.provinsi ilike '%b%ton%'
group by 
	to_char(t.transaction_date, 'YYYY-MM'), 
	ap.provinsi, ak.kabupaten --t.code_trans,
order by ap.provinsi, ak.kabupaten, to_char(t.transaction_date, 'YYYY-MM') 
;


/* 
 * ===============================================================================================================================================================
 * END OMZET BERDASARKAN TUJUAN PENGIRIMAN MONTHLY -- MARKETING -- LELA
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */



/*

Omset bulan Desember, Januari, Februari dan 3 username yg belanja terbanyak 
.
1. Pringsewu Lampung
2. Pesawaran Lampung
3. Tulang Bawang Lampung
4. Kotabumi Lampung
*/


select * from week_periodes wp;

select * from barang b;



select *
from (
		select   
				ap.provinsi, 
				ak.kabupaten,
				ak2.kecamatan, 
				u.username, 
				u.nama,  
				u.handphone,
				sum(pdj.omzet) as omzet, 
				rank() OVER (
			        PARTITION BY ap.provinsi, 
								ak.kabupaten,
								ak2.kecamatan,to_char(wp."eDate", 'YYYY-MM')
			        ORDER BY ak.kabupaten, ak2.kecamatan, sum(pdj.omzet) DESC
			    ),
		--		pdj.wid ,
		--		wp."sDate", wp."eDate" 
				to_char(wp."eDate", 'YYYY-MM') 
		from alamat_provinsi ap
			 inner join alamat_kabupaten ak on ap.id  = ak.id_provinsi  
			 inner join alamat_kecamatan ak2 on ak.id  = ak2.id_kabupaten 
			 inner join users u on u.kecamatan::bigint = ak2.id 
			 inner join memberships m on u.uid = m."owner"  
			 inner join prepared_data_joys pdj on m.jbid = pdj.jbid 
			 inner join week_periodes wp on pdj.wid = wp.id 
		where  ap.provinsi ilike '%lampung%'
				and (
						ak.kabupaten ILIKE ANY(ARRAY['%pringsewu%','%pesawaran%','%tulang%bawang%','%kotabumi%'])
						or ak2.kecamatan ILIKE any(ARRAY['%pringsewu%','%pesawaran%','%tulang%bawang%','%kotabumi%']) 
					)
				and to_char(wp."eDate", 'YYYY-MM') between '2023-12' and '2024-02'
				and u.username not ilike 'dgsc%'
		--	ak.kabupaten ilike '%pringsewu%'
		group by ap.provinsi, 
				ak.kabupaten,
				ak2.kecamatan, 
				u.username, 
				u.nama,  
				u.handphone,
		--		wp."sDate", 
				to_char(wp."eDate", 'YYYY-MM') 
		--order by ap.provinsi, ak.kabupaten, u.username 
	) as data
where data.rank <= 3;
;

--		NOT ILIKE ALL(ARRAY['%Bombana%','%Baubau%','%Makassar%','%Palu%'])






SELECT rank_filter.* 
FROM (
	    SELECT items.*, 
	    rank() OVER (
	        PARTITION BY color
	        ORDER BY created_at DESC
	    )
	    FROM items
	    WHERE items.cost < 50
	) rank_filter WHERE RANK = 1;






select
	to_char(t.transaction_date, 'YYYY-MM') as "Period", 
	INITCAP(ap.provinsi) as "Provinsi", 
--	INITCAP(ak.kabupaten) as "Kabupaten",
	case
		when INITCAP(ap.provinsi) = 'Bengkulu' then 'Bengkulu'
		when INITCAP(ap.provinsi) = 'Lampung' then 'Lampung'
		when INITCAP(ap.provinsi) = 'Bali' then 'Bali'
		when INITCAP(ap.provinsi) = 'Palu' then 'Palu'
		else INITCAP(ak.kabupaten)
	end as "Kabupaten",;
	sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost"
from "transaction" t 
	left outer join memberships m on (t.id_cust_fk = m.jbid)
	left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
	left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
where 
	t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
--	and t.transaction_date::date -- >= '2023-05-29'  --		between '2023-11-28' and '2023-12-27' -- now() --'2024-12-10'
	and to_char(t.transaction_date, 'YYYY-MM') between '2023-11' and '2024-02'
	and (
			ak.kabupaten ILIKE ANY(ARRAY['%garut%','%Bangkalan%']) 
--			or ap.provinsi ILIKE ANY(ARRAY['%Bengkulu%','%Lampung%','%Bali%']) 
		)
--	ak.kabupaten ilike '%bau%bau%'
--		NOT ILIKE ALL(ARRAY['%Bombana%','%Baubau%','%Makassar%','%Palu%'])
--	and ap.provinsi ilike '%b%ton%'
group by 
	to_char(t.transaction_date, 'YYYY-MM'), 
	ap.provinsi, ak.kabupaten --t.code_trans,
order by ap.provinsi, ak.kabupaten, to_char(t.transaction_date, 'YYYY-MM') 
;


select * from memberships m where m.username = 'dgsc-dgsc-elfina0108261';

