select (generate_series('2024-01-01', '2024-12-31', '7 day'::interval))::date;

select count(1)
from week_periodes wp 
where wp."sDate"  between (now() - '1 week'::interval) and (now() - '2 weeks'::interval);


select date_part('epoch', now());

select date_part('minute', now()); -- or hour, day, month

SELECT EXTRACT('Day' FROM CURRENT_DATE);

extract(dow from date_column::timestamp)
from current_date;

select to_char(current_date, 'day'), to_char(current_date, 'dy');



SELECT 
    date_trunc('month', current_date) as month_start
  , (date_trunc('month', current_date) + interval '1 month' - interval '1 day')::date as month_end;
  
 
 SELECT '2024-01-27'::date + cast(abs(extract(dow FROM '2024-01-27'::date) - 6) + 1 AS int);

SELECT current_date - ((6 + cast(extract(dow FROM current_date) AS int)) % 7), cast(extract(dow FROM '2024-01-25'::date ) AS int)t;

select date_trunc('week', now())+ INTERVAL '7days';


-- GET DATE WITH SPECIFIC DAY IN A YEAR
select '2024-01-01'::date + d.date, 
		EXTRACT(month FROM date '2024-01-01'::date + d.date) as "MONTH",
		TO_CHAR(date '2024-01-01'::date + d.date, 'YYYY') as "year"
from generate_series(0, 400) as d(date)
where ('2024-01-01'::date + d.date BETWEEN '2024-01-01'::date and '2024-12-31'::date)
	and (to_char('2024-01-01'::date + d.date, 'dy') = 'wed' or to_char('2024-01-01'::date + d.date, 'dy') = 'thu') 
order by d.date;


select * from week_periodes wp order by "sDate" desc ;



-- INSERT INTO week_periodes 
insert into week_periodes("sDate", "eDate", "created_at", "updated_at", "name")

with data_weeks as (
select "data"."Thursday", "data"."Wednesday", 
	now(), now(),
	concat("data"."periodxx", row_number() over(partition by "data"."periodym" order by "data"."periodym")) as "period_name"
from (
	select '2024-01-01'::date + d.date as "Thursday",  -- Kamis
			(('2024-01-01'::date + d.date)+ INTERVAL '6days')::date as "Wednesday",  -- Rabu
			EXTRACT(month FROM date '2024-01-01'::date + d.date) as "MONTH",
			EXTRACT(month FROM (('2024-01-01'::date + d.date)+ INTERVAL '6days')::date) as "MONTH-Wed",
			TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'YYMM') as "periodym",
			CONCAT(TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'yy.'),
					TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'MM')::integer,
					'.') as "periodxx"
					
	from generate_series(0, 1400) as d(date)
	where ('2024-01-01'::date + d.date BETWEEN '2024-01-01'::date and '2026-12-31'::date)
		and (to_char('2024-01-01'::date + d.date, 'dy') = 'thu') 
	order by d.date
) "data"
)
select *
from data_weeks
where "Thursday"> '2024-01-25';







with data_weeks as (
select "data"."Thursday", "data"."Wednesday", 
--	"data"."MONTH-Wed", "data"."year", "data"."period",
	now(), now(),
	concat("data"."periodxx", row_number() over(partition by "data"."periodym" order by "data"."periodym")) as "period_name"
from (
	select '2024-01-01'::date + d.date as "Thursday",  -- Kamis
			(('2024-01-01'::date + d.date)+ INTERVAL '6days')::date as "Wednesday",  -- Rabu
			EXTRACT(month FROM date '2024-01-01'::date + d.date) as "MONTH",
			EXTRACT(month FROM (('2024-01-01'::date + d.date)+ INTERVAL '6days')::date) as "MONTH-Wed",
			TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'YYYY') as "year",
			TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'YYMM') as "periodym",
			TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'yy.mm.') as "period",
			CONCAT(TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'yy.'),
					TO_CHAR((('2024-01-01'::date + d.date)+ INTERVAL '6days')::date, 'MM')::integer,
					'.') as "periodxx"
					
	from generate_series(0, 1400) as d(date)
	where ('2024-01-01'::date + d.date BETWEEN '2024-01-01'::date and '2026-12-31'::date)
		and (to_char('2024-01-01'::date + d.date, 'dy') = 'thu') 
	order by d.date
) "data"
)
select *
from data_weeks
where "Thursday"> '2024-01-25';






