-- START UPDATE STOCK PUC/MPU
SELECT * FROM stock_packs sp where code = 'MPUC004'; -- 10

select * 
from stock_pack_stock_details spsd 
where tcode in ('ZY8XMG');

select *
from stock_pack_stocks sps 
where jspid in ('MPUC004') and pcode in ('E002LAE1EB');
-- END UPDATE STOCK PUC/MPU