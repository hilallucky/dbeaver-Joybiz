-- CHECK BONUS 
-- BONUS JOY
select *
from joy_bonus_summaries jbs 
order by jbs."date"  desc 
limit 100;

-- BONUS PLAN
select * 
from bonus_weeklies bw 
order by bw.created_at desc
limit 100;

-- BONUS PUC/MPU
select *
from fee_pucs fp 
order by fp.created_at desc
limit 100;