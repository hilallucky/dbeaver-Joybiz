/* flag in table membership & users
 * 2 = SC
 * 1 = Member
 */
SELECT 
	case 
		when m.flag = 1 then 'Member'
		when m.flag = 2 then 'Special Customer'
		else 'else'
	end as "type", count(m.flag) as "total"
FROM memberships m
where m.spid = (select jbid from memberships m2 where username = 'muhamm2003691')
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
where m.username = 'muhamm2003691'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by u.nama, pdj.jbid, to_char(wp."eDate", 'YYYY-MM')
order by to_char(wp."eDate", 'YYYY-MM')  desc
;






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
		where m.username = ''muhamm2003691''
				and to_char(wp."eDate", ''YYYY-MM'') > to_char(CURRENT_DATE - INTERVAL ''4 months'', ''YYYY-MM'')
		group by to_char(wp."eDate", ''YYYY-MM'')
        ORDER BY to_char(wp."eDate", ''YYYY-MM'')'
   ) AS ct (
      nama text,
      "Month1" numeric,
      "Month2" numeric,
      "Month3" numeric,
      "Month4" numeric
   );


  select 
				u.nama, 
				to_char(wp."eDate", 'YYYY-MM') as "Period",
		sum(pdj.ppv) as "ppv"
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.username = 'muhamm2003691'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by u.nama, pdj.jbid, to_char(wp."eDate", 'YYYY-MM')
   ORDER BY u.nama, to_char(wp."eDate", 'YYYY-MM');



select  to_char(wp."eDate", 'YYYY-MM') as "Period"
from 	memberships m 
		inner join users u on m.username = u.username 
		inner join prepared_data_joys pdj on m.jbid = pdj.jbid  
		inner join week_periodes wp on pdj.wid = wp.id 
where m.username = 'muhamm2003691'
		and to_char(wp."eDate", 'YYYY-MM') > to_char(CURRENT_DATE - INTERVAL '4 months', 'YYYY-MM')
group by to_char(wp."eDate", 'YYYY-MM')
ORDER BY to_char(wp."eDate", 'YYYY-MM');





DO $$
DECLARE
    dynamic_sql TEXT;
    month_cols TEXT;
	username text := 'ayuros2804701';
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





