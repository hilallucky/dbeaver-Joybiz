

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
	u.provinsi::int = 72
	and u.kota_kabupaten::int = 7271 --PALU
	and t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
--	and t.transaction_date::date between '2023-08-01' and '2023-11-23'
group by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
order by to_char(t.transaction_date, 'YYYY-MM'), ap.provinsi, ak.kabupaten
;	

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

