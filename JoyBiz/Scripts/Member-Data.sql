-- ===========================================================================================
-- START CHECK LATEST ORDER BY USERNAME;
	WITH latest_orders AS (
		select m.username, m.jbid, t.transaction_date, t.code_trans, t.pv_total,
				ROW_NUMBER() OVER (PARTITION BY t.id_cust_fk ORDER BY t.transaction_date DESC) AS row_num
		from memberships m 
			 left outer join "transaction" t on t.id_cust_fk = m.jbid 
		where m.username in ('sofiat1706631',
								'badrus1706241',
								'bumin1109821',
								'ahmad1109681',
								'nyimas1109551',
								'rikain1109111',
								'ponima1109451',
								'stkhoir1109871',
								'suparm1706261',
								'sumard1606691'
								)
	)
	select username, transaction_date, code_trans, pv_total --, row_num
	from latest_orders
	where row_num = 1;
-- END CHECK LATEST ORDER BY USERNAME;
-- ===========================================================================================

SELECT * FROM memberships m where m.username ='nining2507921';
select * from sranks s where s.jbid =23075395236;
select sl.id, sl.jbid , m.username , sl.srank , r.short_name, sl.achieve_at
from srank_logs sl 
	inner join memberships m on m.jbid = sl.srank
	inner join ranks r on sl.srank = r.id 
where sl.jbid =23075395236
order by sl.achieve_at;
