
--
--UPDATE memberships m1
--SET 
--  "left"  = (select m2.jbid  from memberships m2 where m2.upid = m1.jbid order by m2.id asc limit 1),
--  "right" = (select m3.jbid from memberships m3 where m3.upid = m1.jbid order by m3.id desc limit 1)
--WHERE "left" is null and "right" is null and username not ilike '%deleted%'  
--	 and created_at >= '2023-11-19 20:00:00';
select * from memberships m where username ='liatre111240';--	 
	
select t.transaction_date, t.created_at, t.code_trans, t.status , t.deleted_at from "transaction" t where t.id_cust_fk  = 35720 or t.id_sc_fk = 35720 order by t.transaction_date ;
	
select * from users u where username ilike 'hilal%';

select t.* 
from "transaction" t 
where t.code_trans ILIKE ANY(array['SJPDB3','EQ91HJ','YGNDSI%','F24E5Z%'])
	  and t.deleted_at is null;
	 

	
select * from "transaction" t where code_trans ilike 'YGNDSI%' or code_trans ilike 'SJPDB3%';--  or code_trans in ('F24E5Z1');
select * from payment_confirmation pc where code_trans ilike 'YGNDS%' or code_trans in ('SJPDB3');
select * from transaction_payment_logs tpl where code_trans ilike 'YGNDS%' or code_trans in ('SJPDB3');
select * from payment_confirmation pc where code_trans ilike 'YGNDS%' or code_trans in ('SJPDB3');

select -- (select t1.code_trans from "transaction" t1 where t1.id=td.id_trans_fk) as code_trans, 
		* 
from transaction_detail td 
where td.id_trans_fk in (
		select t.id 
		from "transaction" t 
		where t.code_trans ILIKE ANY(array['SJPDB3','EQ91HJ','YGNDSI%','F24E5Z%'])
			and t.deleted_at is null
	)
order by id_trans_fk, id;


select * from "transaction" t where code_trans ilike 'YGNDSI%' or code_trans in ('SJPDB3');

select * from transaction_detail td where td.id_trans_fk in (141686);
select * from transaction_detail td where td.id_trans_fk in (143602,143603,143604,143605,143397,143397,143398);
select * from transaction_detail td where "name" = 'Free Joy Coffee' and deleted_at is not null;
select * from stock_opname_detail sod;


select t.id, t.code_trans, t.created_at, t.transaction_date, t.id_sc_fk, t.id_cust_fk, SUM(t.bv_total),
	 	td."name", td.qty, td.base_price, td.deleted_at 
from "transaction" t 
	join transaction_detail td on t.id = td.id_trans_fk  
where (t.bv_total >= 50 and t.transaction_date::date >= '2023-11-05'and td.deleted_at is not null)
--	or t.code_trans in ('RYTALC')
group by t.id, t.code_trans, t.created_at, t.transaction_date, t.id_sc_fk, t.id_cust_fk,
	 	td."name", td.qty, td.base_price, td.deleted_at 
;

select * from "transaction" t where created_at::date = '2023-11-05' and bv_total >= 240;
