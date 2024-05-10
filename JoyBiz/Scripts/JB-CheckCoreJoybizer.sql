/* flag in table membership & users
 * 2 = SC
 * 1 = Member
 */


-- START CHECK CORE JOYBIZER
SELECT 
	case 
		when m.flag = 1 then 'Member'
		when m.flag = 2 then 'Special Customer'
		else 'else'
	end as "type", count(m.flag) as "total"
FROM memberships m
where m.spid = (select jbid from memberships m2 where username = 'khusnu1209421')
--username in ('hamidi0908411','tbabdu0403501','syehda1408901');
group by m.flag
;

select 
--		pdj.wid, 
		u.nama, 
--		pdj.wid , wp.id , 
--		wp."eDate", 
		to_char(wp."eDate", 'YYYY-MM') as "Period",
		pdj.jbid, sum(pdj.omzet) as "omzet", 
		sum(pdj.ppv) as "ppv", sum(pdj.gpvj) as "gpvj",
		sum(pdj.ppv) + sum(pdj.gpvj) as "total_pv"
--		,wp."name" 
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.username = 'khusnu1209421'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by u.nama, pdj.jbid, to_char(wp."eDate", 'YYYY-MM')
order by to_char(wp."eDate", 'YYYY-MM')  desc
;
-- END CHECK CORE JOYBIZER





CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * 
FROM 
   crosstab(
      'select 
				u.nama, 
				to_char(wp."eDate", ''YYYY-MM'') as "Period",
				sum(pdj.ppv) as "ppv"
		from 	memberships m 
				inner join users u on m.username = u.username 
				inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
				inner join week_periodes wp on pdj.wid = wp.id 
		where m.username = ''muhamm2003691''
				and to_char(wp."eDate", ''YYYY-MM'') > to_char(CURRENT_DATE - INTERVAL ''4 months'', ''YYYY-MM'')
		group by u.nama, pdj.jbid, to_char(wp."eDate", ''YYYY-MM'')
       ORDER BY u.nama, to_char(wp."eDate", ''YYYY-MM'')',
      'select 
				to_char(wp."eDate", ''YYYY-MM'') as "Period"
		from 	memberships m 
				inner join users u on m.username = u.username 
				inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
				inner join week_periodes wp on pdj.wid = wp.id 
		where m.username = ''moelja1301911''
				and to_char(wp."eDate", ''YYYY-MM'') > to_char(CURRENT_DATE - INTERVAL ''4 months'', ''YYYY-MM'')
		group by to_char(wp."eDate", ''YYYY-MM'')
        ORDER BY to_char(wp."eDate", ''YYYY-MM'')'
   ) AS ct (
      nama text,
      "Month1" numeric,
      "Month2" numeric,
      "Month3" numeric,
      "Month4" numeric,
      "Month5" numeric
   );


  select 
				u.nama, 
				to_char(wp."eDate", 'YYYY-MM') as "Period",
		sum(pdj.ppv) as "ppv"
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.username = 'moelja1301911'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by u.nama, pdj.jbid, to_char(wp."eDate", 'YYYY-MM')
   ORDER BY u.nama, to_char(wp."eDate", 'YYYY-MM');



select  to_char(wp."eDate", 'YYYY-MM') as "Period"
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.username = 'moelja1301911'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by to_char(wp."eDate", 'YYYY-MM')
ORDER BY to_char(wp."eDate", 'YYYY-MM');





DO $$
DECLARE
    dynamic_sql TEXT;
    month_cols TEXT;
	username text := 'moelja1301911';
	_format_month text := 'YYYY-MM'; 
	_interval_months text := '4 months';
BEGIN
    SELECT string_agg(format('COALESCE(MAX(CASE WHEN Period = %s THEN ppv END), 0) AS "Period%s"', Period, Period), ', ')
    INTO month_cols
    FROM generate_series(EXTRACT(MONTH FROM CURRENT_DATE - INTERVAL '2 months')::int, EXTRACT(MONTH FROM CURRENT_DATE)::int) AS months(Period);

    dynamic_sql := '
        SELECT * FROM 
           crosstab(
              $$SELECT u.nama, 
                      EXTRACT(MONTH FROM to_char(wp."eDate", ''' || _format_month ||''' )) AS Period, 
                      SUM(pdj.ppv) AS ppv, 
					  SUM(pdj.gpvj) as "gpvj",
					  SUM(pdj.ppv) + SUM(pdj.gpvj) as "total_pv"
                 from 	memberships m 
						inner join users u on m.username = u.username 
						inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
						inner join week_periodes wp on pdj.wid = wp.id 
                where m.username = ''' || username || '''
						and to_char(wp."eDate", ''' || _format_month || ''') > to_char(CURRENT_DATE - INTERVAL ''' || _interval_months || ''', ''' || _format_month || ''')
				group by u.nama, pdj.jbid, to_char(wp."eDate", ''' || _format_month ||''' )
                ORDER BY u.nama, to_char(wp."eDate", ''' || _format_month ||''' )$$,
              $$VALUES (' || string_agg(Period::text, ', ') || ')$$
           ) AS ct (
              nama text,
              ' || month_cols || '
           );';

    EXECUTE dynamic_sql;
END $$;


-- START CHECK YOUNG EAGLE

--	 STEP 1, CHECK IF THAT MEMBER QUALIFYING YOUNG EAGLE HAVE 800PV 3 MONTHS	
	select 
	--		pdj.wid, 
			u.username,
			u.nama, 
	--		pdj.wid , wp.id , 
	--		wp."eDate", 
			to_char(wp."eDate", 'YYYY-MM') as "Period",
			pdj.jbid, sum(pdj.omzet) as "omzet", 
			sum(pdj.ppv) as "ppv", sum(pdj.gpvj) as "gpvj",
			sum(pdj.ppv) + sum(pdj.gpvj) as "total_pv"
	--		,wp."name" 
	from 	memberships m 
			inner join users u on m.username = u.username 
			inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
			inner join week_periodes wp on pdj.wid = wp.id 
	where m.spid = (select m2.jbid from memberships m2 where m2.username ='khusnu1209421')
			and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
	group by u.username, u.nama, pdj.jbid, to_char(wp."eDate", 'YYYY-MM')
	having sum(pdj.ppv) >= 800
	order by u.username, to_char(wp."eDate", 'YYYY-MM') desc
	;
	-- END STEP 1


	-- STEP 2, HAVE 2 GAMMA FROM SPONSORED BY THAT MEMBER (LEFT & RIGHT)
	/*
	select m.jbid, m.username, s.srank, r.short_name, m.upid, m2.jbid as spid, m2.username 
	from memberships m 
		 inner join sranks s on m.jbid = s.jbid -- GET rank
		 inner join ranks r on s.srank = r.id -- rank NAME
		 inner join memberships m2 on m.upid = m2.jbid -- GET SPONSOR
	where m.spid = (select m2.jbid from memberships m2 where m2.username ='khusnu1209421')
			and s.srank >= 3;
	*/
		
	
	select m.jbid, m.username, s.srank, r.short_name, m.upid, m2.jbid as spid, m2.username as sp_username
	from memberships m 
		 inner join sranks s on m.jbid = s.jbid -- GET rank
		 inner join ranks r on s.srank = r.id -- rank NAME
		 inner join memberships m2 on m.upid = m2.jbid -- GET SPONSOR
	where m.spid in (select m2.jbid from memberships m2 where m2.username in ('khusnu1209421','khusnu12094212','khusnu12094213'))
			and s.srank >= 3;
		
		-- RESULT 
		/*
				#	username
			1	mashil2512161
			2	hashif2003721
			3	muhamm2003691
			4	eniknu2411611
			5	anisha2211511
		*/
		
		

		-- GET UPLINE FOR CHECKING
		WITH RECURSIVE descendants AS (
		    SELECT id, username, jbid, spid, upid, 0 AS depth, "owner"
		    FROM memberships m1
		    WHERE lower(m1.username) in ('muhamm2003691') -- root khusnu1209421 right khusnu12094212 left khusnu12094213
		UNION    
		    SELECT m2.id, m2.username, m2.jbid, m2.spid, m2.upid, d.depth+ 1, m2."owner"
		    FROM memberships m2
		    	 inner join descendants d on m2.jbid = d.upid
		)
		SELECT d.id, d.username, u.nama, m.username as sp_name, d.jbid, d.spid, d.upid, d.depth, d."owner"
		FROM descendants d
			left outer JOIN users u ON d."owner" = u.uid
			inner join memberships m on d.spid = m.jbid
		order by d.id
		;

	-- END STEP 2
		
		
	-- STEP 3, CHECK MIN 6 GAMMA FROM MEMBER STEP 2
		-- GET ALL DOWNLINES
		WITH RECURSIVE cte (id, username, jbid, spid, "depth", "owner") as (
			select m.id , m.username, m.jbid, m.spid, 0 AS depth, m."owner" 
			from memberships m  
--			where m.username IN ('mashil2512161','hashif2003721','muhamm2003691','eniknu2411611','anisha2211511')
			where m.username IN ('hashif2003721')
		  	UNION ALL
			select m.id , m.username, m.jbid, m.spid, cte.depth+ 1, m."owner" 
			from memberships m  
				INNER JOIN cte ON m.spid = cte.jbid
		)
		SELECT cte.id , cte.username, u1.nama , s.srank, r.short_name, cte.jbid, cte.spid, cte."depth", cte."owner"
		FROM cte
			inner join users u1 on cte."owner" = u1.uid 
			inner join sranks s on cte.jbid = s.jbid -- GET rank
			inner join ranks r on s.srank = r.id -- rank NAME
		and s.srank >= 3
		order by cte.depth, cte.id
		;

	-- END STEP 3
	
	-- STEP 4, FIND AT LEAST 2 DOWNLINE CORE JOYBIZER (MIN 3 MONTH 800PPV)
	WITH RECURSIVE downline AS (
	  -- Anchor member(s) - starting point(s)
	  SELECT m.jbid, m.username, m.spid, m.upid, '' as sp_username
	  FROM memberships m 
	  WHERE username = 'khusnu1209421' -- Replace <upline_id> with the ID of the upline member
	  
	  UNION ALL
	  
	  -- Recursive member(s) - fetching children
	  SELECT m2.jbid, m2.username, m2.spid, m2.upid, d.sp_username
	  FROM memberships m2 
	  	INNER JOIN downline d ON m2.upid = d.jbid
	)
--	select * from downline;
	, monthly_transactions AS (
	  -- Monthly transactions for downline members
	  SELECT d.jbid, d.username, d.spid, d.upid, d.sp_username, 
--	         DATE_TRUNC('month', t.transaction_date) AS transaction_month, 
			to_char(wp."eDate", 'YYYY-MM') as "Period",
			sum(pdj.omzet) as "omzet", 
			sum(pdj.ppv) as "ppv", sum(pdj.gpvj) as "gpvj",
			sum(pdj.ppv) + sum(pdj.gpvj) as "total_pv"
	  FROM downline d
--	  	JOIN "transaction" t ON d.jbid = t.id_cust_fk
			inner join prepared_data_joys pdj on d.jbid = pdj.jbid  
			inner join week_periodes wp on pdj.wid = wp.id 
--	  group by d.jbid, d.username, d.spid, d.upid, d.sp_username, DATE_TRUNC('month', t.transaction_date)
	 where to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
	  		and d.username <> 'khusnu1209421'
 	 group by d.jbid, d.username, d.spid, d.upid, d.sp_username, 
--	         DATE_TRUNC('month', t.transaction_date) AS transaction_month, 
			to_char(wp."eDate", 'YYYY-MM')
	 having sum(pdj.ppv) >= 800
	)
	-- Summarize monthly transactions for each downline member
	SELECT m.jbid, m.username, m.spid, m.upid, m.sp_username, COUNT(*) as "month_>=_800",
	         -- m."Period", m.omzet, m.ppv, m.gpvj, m.total_pv,
			(
				SELECT 
					/*
					 * 
					 case 
						when mx.flag = 1 then 'Member'
						when mx.flag = 2 then 'Special Customer'
						else 'else'
					end as "type", 
					*/
					count(mx.flag) as "total"
				FROM memberships mx
				where mx.spid = m.jbid and mx.flag = 2
				--mx.username in ('hamidi0908411','tbabdu0403501','syehda1408901');
				group by mx.flag
				having count(mx.flag) >= 10
			) as "Special Customer"
	FROM monthly_transactions m
	GROUP BY m.jbid, m.username, m.spid, m.upid, m.sp_username --, m.transaction_month
	HAVING COUNT(*) >= 3
	ORDER BY m.username --, m."Period"
	;

	-- END STEP 4
		
		
select * 
from memberships m 
where m.spid = (select m2.jbid from memberships m2 where m2.username ='khusnu1209421');
-- END CHECK YOUNG EAGLE


