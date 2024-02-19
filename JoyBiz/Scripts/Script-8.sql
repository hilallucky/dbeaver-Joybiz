

--SELECT to_char(now(), 'Day');

SELECT to_char(now()::timestamp AT TIME ZONE 'Asia/Jakarta', 'Day');



select 
	r1."Day",
	case 
		when trim(r1."Day") = 'Monday' then 'Senin' 
		when trim(r1."Day") = 'Tuesday' then 'Selasa'
		when trim(r1."Day") = 'Wednesday' then 'Rabu'
		when trim(r1."Day") = 'Thursday' then 'Kamis'
		when trim(r1."Day") = 'Friday' then 'Jumat'
		when trim(r1."Day") = 'Saturday' then 'Sabtu'
		else 'Minggu' 
	end,
	r1."Date",
	r1."Period",
	sum(r1.total_trans) as total_trans, --r1.type_ship,
	sum(r1."Purchase Cost") AS "Purchase Cost"
from (
	select 
		to_char(t.transaction_date , 'Day') as "Day",
		to_char(t.transaction_date, 'YYYY-MM-DD') as "Date",
		to_char(t.transaction_date, 'YYYY-MM') as "Period",
		INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
		sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV", count(t.code_trans) as total_trans, 'S' as type_ship
	from "transaction" t 
		left outer join memberships m on (t.id_cust_fk = m.jbid)
		left outer join stock_packs sp on t.pickup_stock_pack = sp.code
		left outer join alamat_provinsi ap on sp.province::int =ap.id  
		left outer join alamat_kabupaten ak on sp.district::int = ak.id
	where 
		t.deleted_at is null
		and t.is_pickup = 1 -- PICKUP PUC/MPU
		and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
		and t.transaction_date >  CURRENT_DATE - INTERVAL '3 months'
		and t.created_userid in (11763, 54281)
	group by to_char(t.transaction_date , 'Day'), to_char(t.transaction_date, 'YYYY-MM-DD'),to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
			
	union all
	
	select -- t.code_trans, 
		to_char(t.transaction_date , 'Day') as "Day",
		to_char(t.transaction_date, 'YYYY-MM-DD') as "Date",
		to_char(t.transaction_date, 'YYYY-MM') as "Period",
		INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
		sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
		sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV", count(t.code_trans) as total_trans, 'A' as type_ship
	from "transaction" t 
		left outer join memberships m on (t.id_cust_fk = m.jbid)
		left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
		left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
	where 
		t.deleted_at is null
		and t.is_pickup = 2 -- SENT to ADDRESS
		and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
	--	and t.transaction_date::date between '2024-12-25' and '2024-12-31'
		and t.transaction_date >  CURRENT_DATE - INTERVAL '3 months'
		and t.created_userid in (11763, 54281)
	group by to_char(t.transaction_date , 'Day'), to_char(t.transaction_date, 'YYYY-MM-DD'),to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
) r1
where trim(r1."Day") = 'Saturday'
group by r1."Day", r1."Date", r1."Period"--, r1.type_ship --, r1."Provinsi", r1."Kabupaten" --, r1."Period"
--ROLLUP (r1."Provinsi", r1."Kabupaten")
order by r1."Date", r1."Day" --, r1."Provinsi", r1."Kabupaten"
;







--
--
--
--
--
--
--
--
--
--
--/* 
-- * ===============================================================================================================================================================
-- * START OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY
-- * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
--
--	select * from "transaction" t where is_pickup = 1; 
--	select * from stock_packs sp ;
--	select * from alamat_kabupaten ak where id in (3174,7371);
-- */
--
--select 
--	CASE WHEN r1."Provinsi" is null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
--	CASE WHEN r1."Kabupaten" is null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
--	sum(CASE WHEN r1."Period" = '25-31 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "25-31 JAN 2024",
--	sum(CASE WHEN r1."Period" = '01-07 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "01-07 JAN 2024",
--	sum(CASE WHEN r1."Period" = '08-14 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "08-14 JAN 2024",
--	sum(CASE WHEN r1."Period" = '15-21 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "15-21 JAN 2024",
--	sum(CASE WHEN r1."Period" = '22-28 JAN 2024' THEN r1."Purchase Cost" else 0 end) AS "22-28 JAN 2024",
--	sum(CASE WHEN r1."Period" = '29-04 FEB 2024' THEN r1."Purchase Cost" else 0 end) AS "29-04 FEB 2024"
----	r1."Purchase Cost", r1."Shipping Cost", r1."BV", r1."PV", r1."RV"
--from (
--		(
--			select 
--				'25-31 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-12-25' and '2024-12-31'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					
--			union all
--			
--			select -- t.code_trans, 
--				'week5 25-31 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-12-25' and '2024-12-31'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--		
--		union all
--		
--		(
--			select 
--				'01-07 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-01' and '2024-01-07'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					
--			union all
--			
--			select -- t.code_trans, 
--				'01-07 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-01' and '2024-01-07'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--		
--		union all
--		
--		(
--			select 
--				'08-14 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-08' and '2024-01-14'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					;;
--			union all
--			
--			select -- t.code_trans, 
--				'08-14 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-08' and '2024-01-14'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--		
--		union all
--		
--		(
--			select 
--				'15-21 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-15' and '2024-01-21'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					
--			union all
--			
--			select -- t.code_trans, 
--				'15-21 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-15' and '2024-01-21'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--		
--		union all
--		
--		(
--			select 
--				'22-28 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-22' and '2024-01-28'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					
--			union all
--			
--			select -- t.code_trans, 
--				'22-28 JAN 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-22' and '2024-01-28'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--		
--		union all
--		
--		(
--			select 
--				'29-04 FEB 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--			--	join memberships m2 on m.owner = m2.owner and m.owner = m.uid
--	--			left outer join users u on m.username = u.username 
--				left outer join stock_packs sp on t.pickup_stock_pack = sp.code
--				left outer join alamat_provinsi ap on sp.province::int =ap.id  
--				left outer join alamat_kabupaten ak on sp.district::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 1 -- PICKUP PUC/MPU
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-29' and '2024-02-04'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--					
--			union all
--			
--			select -- t.code_trans, 
--				'29-04 FEB 2024' as "Period",
--				INITCAP(ap.provinsi) as "Provinsi", INITCAP(ak.kabupaten) as "Kabupaten",
--				sum(t.purchase_cost) as "Purchase Cost", sum(t.shipping_cost) as "Shipping Cost",
--			--	sum(t.subsidi_shipping) as "Shipping Subsidy", sum(t.gross_shipping) as "Shipping Gross",
--				sum(t.bv_total) as "BV", sum(t.pv_total) as "PV", sum(t.rv_total) as "RV"
--			from "transaction" t 
--				left outer join memberships m on (t.id_cust_fk = m.jbid)
--				left outer join alamat_provinsi ap on t.shipping_province::int =ap.id  
--				left outer join alamat_kabupaten ak on t.shipping_city::int = ak.id
--			where 
--				t.deleted_at is null
--				and t.is_pickup = 2 -- SENT to ADDRESS
--				and t.status in('PC', 'S', 'A') -- , 'I') -- PAID
--				and t.transaction_date::date between '2024-01-29' and '2024-02-04'
--			group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten --t.code_trans,
--		)
--	) r1
--group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
----ROLLUP (r1."Provinsi", r1."Kabupaten")
--order by r1."Provinsi", r1."Kabupaten"
--;	
--
--
--/* 
-- * ===============================================================================================================================================================
-- * END OMZET BERDASARKAN TUJUAN PENGIRIMAN WEEKLY
-- * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
-- */
;

select * from users u where nama ilike '%zadina%' or nama ilike 'diah k%';
select * from "transaction" t where created_userid in (11763, 54281);

