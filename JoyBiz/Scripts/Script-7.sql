

do $$
	declare 
		rowid integer;
		jb_id integer;
		sp_id integer;
		max_record integer := 0;
		p_amount integer := 0;
		pg_amount integer := 0;
		bnsperiod varchar(10);
		monthperiod integer := 11;
		yearperiod integer := 2023;

	begin
		rowid  := 1;
		
		while rowid  <= (select count(*) from tree_path tp) loop
		
			select 
				coalesce(sum(amount), 0),
				coalesce(sum(g_amount), 0),
				jbid,
				spid
			into p_amount, pg_amount, jb_id, sp_id
			from tree_path o 
			where o.bnsperiod = monthperiod 
					and o.row_num = rowid ;
		  
--			update test_member set p_amount = p_total_amount, month_period = monthperiod, year_period = yearperiod where id = member_id;
			  
			--  start update purchase to upline
			WITH RECURSIVE cte AS (
				select t1.row_num, t1.username, t1.id_sponsor, p_total_amount as p_amount, p_total_amount::int8 as g_amount
				FROM tree_path t1 
				WHERE t1.id = member_id
				
				UNION
				 
				SELECT t2.id, t2.fullname, t2.id_sponsor, p_total_amount as p_amount, t2.g_amount + p_total_amount::int8 as g_amount
				FROM tree_path t2
				JOIN cte cte ON t2.id = cte.id_sponsor
			)
			 
			update test_member 
			set g_amount = cte.g_amount
			from cte 
			where test_member.id = cte.id;
			
			--  end update purchase to upline  
			 
			 
			raise notice 'Member ID =  %, p_amount = %, year-month %-%', member_id, p_total_amount, yearperiod, monthperiod;
			member_id := member_id + 1;
		end loop;
	--PERFORM  * from test_aja;
	--  drop table test_aja;
end$$;