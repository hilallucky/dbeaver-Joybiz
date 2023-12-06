
 
 
 WITH RECURSIVE RecursivePoints AS (
 	select 	m.uuid, 
 			m.first_name,
 			m.sponsor_uuid,
 			(oh.total_pv) as total_pv, 
 			(oh.total_pv) as acc_pv,
 			(oh.total_xv) as total_xv,
 			(oh.total_xv) as acc_xv
 	from members m 
 		left join order_headers oh on m.uuid = oh.member_uuid 
 			and oh.created_at::date between '2023-09-10' and '2023-09-30'
 	where m.sponsor_uuid is not null
-- 	group by m.uuid,
-- 			m.first_name,
-- 			m.sponsor_uuid

  UNION all

  
  	select 	m2.uuid, 
 			m2.first_name,
 			m2.sponsor_uuid,
 			(oh2.total_pv) as total_pv, 
 			r.acc_pv as acc_pv,
 			(oh2.total_xv) as total_xv,
 			r.acc_xv as acc_xv
 	from members m2
 		left join order_headers oh2 on m2.uuid = oh2.member_uuid 
 			and oh2.created_at::date between '2023-09-10' and '2023-09-30'
 		join RecursivePoints r ON UUID(m2.uuid) = UUID(r.sponsor_uuid)
 	where m2.sponsor_uuid is not null
-- 	group by m2.uuid, m2.first_name,
-- 			m2.sponsor_uuid, r.acc_pv, r.acc_xv 
 	
)
--select * from rp;


select
	mlm.uuid,
 	mlm.first_name,
	mlm.sponsor_uuid,
	(COALESCE(ohr.total_pv, 0)) as total_pv, 
	sum(COALESCE(rp.acc_pv, 0))  as acc_pv,
	(COALESCE(ohr.total_xv, 0)) as total_xv,
	sum(COALESCE(rp.acc_xv, 0))  as acc_xv
FROM
  members mlm
  left join order_headers ohr on mlm.uuid = ohr.member_uuid 
 			and ohr.created_at::date between '2023-09-10' and '2023-09-30'
 		join RecursivePoints rp ON UUID(mlm.uuid) = UUID(rp.uuid)
where mlm.uuid in ('fcc77d76-a239-4904-bc96-4ee9fc59d9e2')
group by 
	mlm.uuid,
	mlm.first_name,
	mlm.sponsor_uuid,
	ohr.total_pv, ohr.total_xv
order by mlm.uuid;
 	
 	
 
 
 select m.uuid, sum(oh.total_pv) as total_pv, sum(oh.total_xv) as total_xv 
 from members m 
 	left join order_headers oh on m.uuid = oh.member_uuid 
 		and oh.created_at::date between '2023-09-10' and '2023-09-30'
 where m.sponsor_uuid is not null
 group by m.uuid ; 
 





WITH RECURSIVE ctename AS (
      SELECT uuid, first_name , sponsor_uuid
      FROM members
      WHERE sponsor_uuid is not null
   UNION ALL
      SELECT m.uuid, m.first_name , m.sponsor_uuid
      FROM members m
         JOIN ctename ON UUID(m.sponsor_uuid) = UUID(ctename.uuid)
)
SELECT * FROM ctename;




 insert into week_periodes (sDate, eDate, updated_at, created_at) 
 values ('2018-01-04 00:00:00', '2018/01/10', '2023-10-10 07:24:33', '2023-10-10 07:24:33') 
 returning id;

 truncate table week_periods;
 




insert into countries (
	uuid, 
	name, 
	name_iso, 
	region_name, 
	sub_region_name, 
	intermediate_region_name, 
	capital_city, 
	tld, 
	languages, 
	geoname_id, 
	dial_prefix, 
	alpha_3_isp, 
	alpha_2_isp, 
	corrency_code_iso, 
	currency_minor_unit_iso, 
	status, 
	created_at, 
	created_by, 
	updated_at
	) 
values (
	'07f3e05c-4d49-11ee-a7c0-33183240fe8c', 
	'Taiwan', 
	null, 
	null, 
	null, 
	null, 
	'Taipei', 
	null,
	'tw', 
	'zh-TW,zh,nan,hak', 
	'1668284', 
	'1668284', 
	'TW', 
	'TWN', 
	null, 
	null, 
	1, 
	'2023-10-19 09:34:27', 
	'admin', 
	'2023-10-19 09:34:27'
);



select id,
		uuid,
        name,
        name_iso,
        region_name,
        sub_region_name,
        intermediate_region_name,
        capital_city,
        tld,
        languages,
        geoname_id,
        dial_prefix,
        alpha_3_iso,
        alpha_2_iso,
        corrency_code_iso,
        currency_minor_unit_iso,
        status,
        created_by,
        updated_by,
        deleted_by
from countries c ; 



select id,uuid,country_uuid,price_code,price_code_uuid,area_code,zip_code,province,city,district,village,latitude,longitude,elevation,status
from cities c
--where c.price_code  is null 
group by id,uuid,country_uuid,price_code,price_code_uuid,area_code,zip_code,province,city,district,village,latitude,longitude,elevation,status
;	 

select c.province
from cities c
where c.price_code  is null 
group by c.province;


--462c73d2-6e6b-11ee-8021-41422053e022,WIB
update cities set price_code_uuid = '462c73d2-6e6b-11ee-8021-41422053e022', price_code = 'WIB'
where province ilike 'sumat%ra%'
	 or province ilike 'aceh%'
	 or province ilike 'lampung%'
	 or province ilike 'jambi%'
	 or province ilike '%riau'
	 or province ilike 'kep%riau'
	 or province ilike '%yogyakarta'
	 or province ilike 'bengkulu%'
	 or province ilike '%bangka%'
	 or province ilike '%belitung%'
	 or province ilike 'banten%'
	 or province ilike '%jakarta'	 
	 or province ilike 'jawa%'
	 or province ilike 'madura%'
	 or province ilike 'kalimantan%barat'
	 or province ilike 'kalimantan%tengah';



--462f755a-6e6b-11ee-b7ad-fb7fa0f79d3e,WITA
update cities set price_code_uuid = '462f755a-6e6b-11ee-b7ad-fb7fa0f79d3e', price_code = 'WITA'
where province ilike 'bali%'
	 or province ilike 'nusa%tenggara%barat'
	 or province ilike 'nusa%tenggara%timur'
	 or province ilike 'sulawesi%'
	 or province ilike 'gorontalo%'
	 or province ilike 'kalimantan%utara'
	 or province ilike 'kalimantan%timur'
	 or province ilike 'kalimantan%selatan';

	 
	 

--463125da-6e6b-11ee-98a5-3f54d849a915,WIT
update cities set price_code_uuid = '463125da-6e6b-11ee-98a5-3f54d849a915'
where province ilike 'maluku%'
	 or province ilike 'papua%';
	 
	
	
select odt.*
from order_details_temp odt 
	 left outer join products p on odt.product_uuid = p.uuid 
where odt.product_uuid is null;
	 
	 
	 
update order_headers set status = 'PC', approved_date = '2023-10-27 03:40:47', updated_at = '2023-10-27 03:40:47' where id = 3;
	 
	 
select * from product_attributes where product_attributes.product_uuid in ('080b6ed4-4d49-11ee-b49d-7d3eb780f12c'); 	 
	 
	 
select product_group_compositions.*, order_details.product_uuid as pivot_product_uuid 
from product_group_compositions 
	inner join order_details on product_group_compositions.product_uuid = order_details.product_uuid 
where order_details.product_uuid in (
	  '080b6ed4-4d49-11ee-b49d-7d3eb780f12c'
      ) and product_group_compositions.deleted_at is null	
;

select * from order_headers 
where transaction_date::date between '2023-01-01' and '2023-11-01' 
	and status in ('1') 
	and order_headers.deleted_at is null for update;

select * from order


select * from order_group_headers_temp 
where (uuid = '8abe8925-a3d7-45bf-ad51-4ad8222a8598' and status = '0') 
	and order_group_headers_temp.deleted_at is null 
order by created_at asc;

select * from order_group_payments_temp
where order_group_payments_temp.order_group_header_temp_uuid in ('8abe8925-a3d7-45bf-ad51-4ad8222a8598') 
	and order_group_payments_temp.deleted_at is null

select * from order_headers_temp where order_group_header_temp_uuid = '8abe8925-a3d7-45bf-ad51-4ad8222a8598';
select * from order_details_temp where order_header_temp_uuid  = '6f99ce34-0c66-4d95-9f7c-f5ac328d6ba9';
select * from order_payments_temp where order_header_temp_uuid  = '6f99ce34-0c66-4d95-9f7c-f5ac328d6ba9';
select * from order_shipping_temp where order_header_temp_uuid  = '6f99ce34-0c66-4d95-9f7c-f5ac328d6ba9';



truncate table stock_periods; 


truncate table week_periods; 

update order_headers set date_transfered_to_wms = null;

update wms_get_transactions set wms_do_date =null, wms_do_header_uuid = null;
--update wms_get_transactions set wms = null;
truncate table wms_do_details; 
truncate table wms_do_headers; 
truncate table wms_stock_summary_headers ; 

select * from wms_get_transactions where transaction_date::date between '2023-01-01' and '2023-11-07' and wms_do_header_uuid is null and wms_get_transactions.deleted_at is null


select * from wms_do_details;

insert into wms_do_details (attribute_name, created_by, description, is_register, name, 
							product_attribute_uuid, product_status, product_uuid, 
							qty_indent, qty_order, qty_remain, qty_sent, updated_by, 
							uuid, weight, wms_do_header_uuid) 
values (null, null, 'Laptop Desc', 0, 'Laptop', 
		 null, 1, '080b6ed4-4d49-11ee-b49d-7d3eb780f12c', 
		 0, 4, 0, 4, null, 
		 '0cedaab7-ac84-4c54-99cb-233c4f209efc', 0.8, '5a879ffe-150c-4f4b-99fb-260cfd55735a') , 
		(?, ?, Laptop Desc, 0, Laptop, 
		 377134ce-3ec7-46df-bb92-767c75ee3e69, 1, 377134ce-3ec7-46df-bb92-767c75ee3e69, 
		 0, 2, 0, 2, ?, 
		 e94d47d5-caf7-415b-8f85-b14f59b24e93, 0.4, 3f3acc2b-b529-451b-a812-97112b212283), 
		 (?, ?, Laptop Desc, 0, Laptop, 6ee02ee2-1d85-4c80-8a56-907ec1175ac5, 1, 080b6ed4-4d49-11ee-b49d-7d3eb780f12c, 0, 4, 0, 4, ?, ffa22431-21d9-4148-9e18-2655c389a0c0, 0.8, d320e444-faca-47a0-b4d1-63d364f35e39), (?, ?, Laptop Desc, 0, Laptop, 458e5502-f0c7-46d1-83ac-a3671605a2e2, 1, 080b6ed4-4d49-11ee-b49d-7d3eb780f12c, 0, 2, 0, 2, ?, 05008219-9939-4db7-961a-0d3104a64877, 0.4, 921ab6d1-a0bc-496a-9067-3aeb9a65b6aa), (?, ?, Laptop Desc, 0, Laptop, 2f6a6bf3-ad7d-47c4-a74e-113cb40a7760, 1, 080b6ed4-4d49-11ee-b49d-7d3eb780f12c, 0, 2, 0, 2, ?, 385fa896-d446-4b55-aa17-f04863e73bb9, 0.4, 48dd11cb-bb8a-4775-8f16-8c2738520d9f), (?, ?, Runaway Desc, 0, Runaway, ?, 1, 082efd04-4d49-11ee-9bbe-01601eb00f7f, 3, 26, 3, 23, ?, 72ee7ced-82e5-498e-b611-1cb2bfac7e65, 0.8, b0bf69e9-b46c-483c-934a-0678a1b7408f)




select product_uuid, product_attribute_uuid, product_header_uuid, name, attribute_name, description, is_register, 
	SUM(weight) as weight, stock_type, SUM(qty_order) as qty_order, SUM(qty_indent) as qty_indent, product_status 
from wms_get_transactions 
where uuid in ('a84e4b7b-fa51-438e-84aa-d1c5f358ce40') and wms_get_transactions.deleted_at is null 
group by product_uuid, product_attribute_uuid, product_header_uuid, name, attribute_name, description, is_register, stock_type, product_status 
order by product_uuid, product_attribute_uuid, product_header_uuid;


select uuid, transaction_type, transaction_date, to_char(transaction_date, 'YYYY-MM-DD') AS trans_date, 
		warehouse_uuid, product_uuid, product_attribute_uuid, product_header_uuid, name, attribute_name, 
		description, is_register, weight, qty_order, qty_indent, product_status, stock_type 
from wms_get_transactions 
where transaction_date::date between '2023-01-01' and '2023-11-07' and (wms_do_date is null or wms_do_header_uuid is null) 
	and wms_get_transactions.deleted_at is null 
order by warehouse_uuid ASC, product_uuid, product_attribute_uuid, product_header_uuid, transaction_type, transaction_date;
		 
SELECT array_to_string(array_agg(uuid), ',')
FROM wms_get_transactions;		 

select 
		array_to_string(array_agg(wms_do_headers.uuid), ', ') as "ids", 
		wms_do_details.product_uuid, wms_do_details.product_attribute_uuid, wms_do_details.product_header_uuid,
        wms_do_details.name, wms_do_details.attribute_name, wms_do_details.description, wms_do_details.is_register,
        wms_do_details.product_status, wms_do_details.weight, wms_do_details.stock_type,
        SUM(wms_do_details.qty_order) AS qty_order, SUM(wms_do_details.qty_sent) AS qty_sent,
        SUM(wms_do_details.qty_indent) AS qty_indent, SUM(wms_do_details.qty_remain) AS qty_remain 
from "wms_do_headers" 
	inner join "wms_do_details" on "wms_do_headers"."uuid" = "wms_do_details"."wms_do_header_uuid" 
--where "wms_do_headers"."daily_stock" is null 
--	and ("wms_do_headers"."daily_stock" is null or "wms_do_headers"."daily_stock" = 0) 
	and "wms_do_headers"."do_date" between '2023-01-01' and '2024-01-01' 
group by "wms_do_details"."product_uuid", "wms_do_details"."product_attribute_uuid", "wms_do_details"."product_header_uuid", 
		"wms_do_details"."name", "wms_do_details"."attribute_name", "wms_do_details"."description", "wms_do_details"."is_register", 
		"wms_do_details"."product_status", "wms_do_details"."weight", "wms_do_details"."stock_type";


select * 
from wms_do_headers 
--set daily_stock = 1, daily_stock_date = 2023-11-13 04:27:12, updated_at = 2023-11-13 04:27:12 
where uuid in ('6f68c74a-d4d8-4bbf-a170-d6e4c19fc926',
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926', 
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926', 
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926', 
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926', 
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926', 
				'6f68c74a-d4d8-4bbf-a170-d6e4c19fc926'
				) 
		and wms_do_headers.deleted_at is null;
	
	
	

-- NETWORK
-- Step 1: Create the temporary table
CREATE TEMPORARY TABLE tree_path (
    row_num INT,
    id INT,
    name VARCHAR,
    upline_id INT,
    level INT,
    upline_name VARCHAR
);

-- Step 2: Insert the data into the temporary table
WITH RECURSIVE hierarchy_cte AS (
    SELECT id, name, 0 as upline_id, 0 as level, cast('' AS VARCHAR) AS upline_name
    FROM test_network
    WHERE upline_id IS NULL

    UNION ALL

    SELECT t.id, t.name, t.upline_id, h.level + 1, h.name AS upline_name
    FROM test_network t
    	JOIN hierarchy_cte h ON t.upline_id = h.id
)
INSERT INTO tree_path(row_num, id, name, upline_id, level, upline_name)
SELECT
    ROW_NUMBER() OVER (order by upline_id, level) AS no,
    id, name, upline_id, level, upline_name AS upline
FROM hierarchy_cte
ORDER BY upline_id, level;

-- Step 3: Query the temporary table to retrieve the results
SELECT tp.row_num, tp.name, (select t.row_num from tree_path t where t.id = tp.upline_id) as upline_no, tp.level
FROM tree_path tp
ORDER BY tp.row_num;  

-- Step 4: Query detele the temporary table
DROP TABLE IF EXISTS tree_path;




