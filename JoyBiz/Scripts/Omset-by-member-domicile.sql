

/*
 * 
 * $this->data['status_payment'] = [
            "P"=>"Process",
            "WP"=>"Pending",
            "CP"=>"Menunggu Verifikasi",
            "PC"=>"Settlement",
            "PR"=>"Pembayaran ditolak",
            "S"=>"Delivered",
            "A"=>"Picked",
            "R"=> "Transaksi ditolak",
            "I"=> "Indent",        
            "J"=> "Partial",
            "X"=> "Promo Anniversary",
            "COD"=> "Cash On Delivery",
        ]; 



select t.* 
from "transaction" t 
--	 join 
where t.code_trans ILIKE ANY(array['SJPDB3','EQ91HJ','YGNDSI%','F24E5Z%'])
	  and t.deleted_at is null;
	 
 */


	 
/* 
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
			and t.transaction_date::date between '2022-12-01' and '2023-11-30'
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
--			and t.transaction_date::date between '2022-12-01' and '2023-11-30'
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
where to_char(t.transaction_date, 'YYYY-MM') = '2023-09'
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A') --, 'I') -- PAID
--t.transaction_date::date between '2023-08-01' and '2023-11-30'
;

select r1."Provinsi", r1."Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2023-08' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-08",
	sum(CASE WHEN r1."Period" = '2023-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-09",
	sum(CASE WHEN r1."Period" = '2023-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-10",
	sum(CASE WHEN r1."Period" = '2023-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-11"
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
			and t.transaction_date::date between '2023-08-01' and '2023-11-30'
		group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
		order by 
				INITCAP(ap.provinsi), INITCAP(ak.kabupaten), 
				to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
	) r1
group by r1."Provinsi", r1."Kabupaten" --, r1."Period"
;	

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

select CASE WHEN r1."Provinsi" = null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" = null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2023-1' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-08",
	sum(CASE WHEN r1."Period" = '2023-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-09",
	sum(CASE WHEN r1."Period" = '2023-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-10",
	sum(CASE WHEN r1."Period" = '2023-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-11"
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
			and t.transaction_date::date between '2023-12-04' and '2023-12-10'
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
 * START OMZET BERDASARKAN DOMISILI MEMBER WEEKLY
 * ---------------------------------------------------------------------------------------------------------------------------------------------------------------
 */

select CASE WHEN r1."Provinsi" = null then 'Unknown' else r1."Provinsi" end as "Provinsi", 
	CASE WHEN r1."Kabupaten" = null then 'Unknown' else r1."Kabupaten" end as "Kabupaten", -- r1."Period",
	sum(CASE WHEN r1."Period" = '2023-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-12"
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
			and t.transaction_date::date between '2023-12-04' and '2023-12-10'
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
	sum(CASE WHEN r1."Period" = '2023-05' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-05",
	sum(CASE WHEN r1."Period" = '2023-06' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-06",
	sum(CASE WHEN r1."Period" = '2023-07' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-07",
	sum(CASE WHEN r1."Period" = '2023-08' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-08",
	sum(CASE WHEN r1."Period" = '2023-09' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-09",
	sum(CASE WHEN r1."Period" = '2023-10' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-10",
	sum(CASE WHEN r1."Period" = '2023-11' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-11",
	sum(CASE WHEN r1."Period" = '2023-12' THEN r1."Purchase Cost" else 0 end) AS "Purchase Cost 2023-12"
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
			and to_char(t.transaction_date, 'YYYY-MM') between '2023-10' and '2023-12'
		group by m.username, to_char(t.transaction_date, 'YYYY-MM'), u.nama
		order by 
				to_char(t.transaction_date, 'YYYY-MM'), m.username --, u.nama
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

