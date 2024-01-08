-- DATA MPU

SELECT tr.pickup_stock_pack, sp."name", 
		ms.username, u.nama,
		tr.code_trans, 
--		tr.status, 
		tr.transaction_date 
FROM "transaction" tr
	JOIN memberships ms ON tr.id_cust_fk = ms.jbid
	join stock_packs sp on sp.code = tr.pickup_stock_pack
	join users u on ms."owner" = u.uid 
WHERE tr.deleted_at IS NULL 
	AND tr.pickup_stock_pack = 'MPUC003' 
	AND tr.is_pickup = 1 
	AND tr.status = 'PC'
ORDER BY tr.pickup_stock_pack, 
		 tr.transaction_date;