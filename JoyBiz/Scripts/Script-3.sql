--
--select * from users u where u.username ilike 'dewire2206881%';
--select * from memberships m where m.username ilike 'dewire2206881%';
--select  distinct  on (m1.username) m1.id, m1.username, m1.jbid, m1.spid, m1.upid
--FROM memberships m1
--WHERE lower(m1.username) in ('endang060912');

do 
$$
	declare 
	    xusername text := 'sindiw0911571';
		_query text;
		_cursor CONSTANT refcursor := '_cursor';
	begin
		_query := 'WITH RECURSIVE upline_cte AS (
						    select  distinct  on (m1.username) ''' || xusername || '''  as x, m1.id, 
									REPLACE(lower(m1.username),''-delete'','''') as username, m1.jbid, m1.spid, m1.upid
						    FROM memberships m1
						    WHERE REPLACE(lower(m1.username),''-delete'','''') in (''' || xusername || ''')
						    UNION
						    SELECT ucte.x, m2.id, m2.username, m2.jbid, m2.spid, m2.upid
						    FROM memberships m2
							    JOIN upline_cte ucte ON m2.jbid = ucte.upid
						)
						select distinct on (u.x, u.id) u.x as "source_user", u.id, REPLACE(lower(u.username),''-delete'','''') as username,  
							t1.t_date, t1.code_trans, t1.status, t1.bv_total, AGE(now(), t1.t_date) ,
							case 
								when AGE(now(), t1.t_date) > INTERVAL ''1 year'' then ''> 1 year''
								when (t1.bv_total < 0 or t1.bv_total is null) then ''> 1 year''
								else '''' 
							end as "age of transaction"
						FROM upline_cte u 
							 left outer join (
							 		select distinct on (tx.id_cust_fk) tx.id_cust_fk, max(tx.transaction_date) as t_date, tx.code_trans, tx.status, tx.bv_total
							 		from "transaction" tx
							 		where tx.status in(''PC'', ''S'', ''A'', ''I'') 
							 		group by tx.id_cust_fk, tx.code_trans, tx.status, tx.bv_total
							 	) t1 on u.jbid = t1.id_cust_fk --and t.code_trans = t1.code_trans 
						order by u.x, u.id desc;';
		
		OPEN _cursor FOR EXECUTE _query;
	end
$$;
FETCH ALL FROM _cursor;



-- ========================================================================

--
--
--		WITH RECURSIVE upline_cte AS (
--		    select  distinct  on (m1.username) m1.id, REPLACE(lower(m1.username),'-delete','') as "username", m1.jbid, m1.spid, m1.upid
--		    FROM memberships m1
--		    WHERE REPLACE(lower(m1.username),'-delete','') in ('dewire22068812')
--		    UNION
--		    SELECT m2.id, REPLACE(lower(m2.username),'-delete','') as "username", m2.jbid, m2.spid, m2.upid
--		    FROM memberships m2
--			    JOIN upline_cte ucte ON m2.jbid = ucte.upid
--		)
--		select distinct on (u.id) u.id, u.username
--		FROM upline_cte u 
--		order by u.id desc;
--
--	
--	
--
--		WITH RECURSIVE upline_cte AS (
--		    select  distinct  on (m1.username) m1.id, REPLACE(lower(m1.username),'-delete','') as "username", m1.jbid, m1.spid, m1.upid, m1."left", m1."right"
--		    FROM memberships m1
--		    WHERE REPLACE(lower(m1.username),'-delete','') in ('istiwi2011981')
--		    UNION
--		    SELECT m2.id, REPLACE(lower(m2.username),'-delete','') as "username", m2.jbid, m2.spid, m2.upid, m2."left", m2."right"
--		    FROM memberships m2
--			    JOIN upline_cte ucte ON m2.jbid = ucte.upid
--		)
--		select distinct on (u.id) u.id, u.username, u.jbid, u.upid, u."left", u."right"
--		FROM upline_cte u 
--		order by u.id desc;
--	
--	
--select 1.id, m1.username, m1.jbid, m1.spid, m1.upid, m1."left", m1."right" 
--from memberships m1 
--where m1.username in ('natali1011721', 'istiwi2011981') or jbid in (23115547199, 24025645232); 
--
--
--


--select * from memberships m where username = 'ramlan1109281' or ("left" = 21094795076 or "right"  = 21094795076);


