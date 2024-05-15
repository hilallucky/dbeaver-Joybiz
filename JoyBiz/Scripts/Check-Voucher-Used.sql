
--select * from memberships m where m.username ilike 'nazili270565%';

select jbs."owner", m.username, u.nama, wp."name", jbs.created_at, jbs.voucher, jbs.voucher2
from joy_bonus_summaries jbs 
	inner join week_periodes wp on jbs.wid = wp.id 
	inner join memberships m on jbs."owner" = m.uid 
	inner join users u on m."owner" = u.uid 
where jbs."owner" in ('c53131c3-d9ae-4e62-9a2b-d434bda60395');

--('2195e04f-167d-4dce-8383-8335af8ea918',
--'c53131c3-d9ae-4e62-9a2b-d434bda60395',
--'642f71ac-83d3-4e66-b826-1d2820d91f49');
--
--select * 
--from bonus_weeklies b
--where b."owner" in ('2195e04f-167d-4dce-8383-8335af8ea918',
--'c53131c3-d9ae-4e62-9a2b-d434bda60395',
--'642f71ac-83d3-4e66-b826-1d2820d91f49');

select t.created_at,  t.transaction_date, t.code_trans, t.code_voucher, t.purchase_cost, t.voucher_amount 
from "transaction" t 
where id_cust_fk in (23055340893) and voucher_amount > 0
	and t.status in('PC', 'S', 'A', 'I') -- PAID;
-- 23055340879, 23055340893, 23055340835