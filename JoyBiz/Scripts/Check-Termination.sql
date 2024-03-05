
select u.username, u.nama, u.id_sponsor_fk, u.id_upline_fk from users u where u.username in ('condro2707762') or uid in ('a60c0098-198a-4c4d-b17d-dac20c502e47');
select * from memberships m where m.username ilike ANY(ARRAY['%condro2707762%']) or jbid in (21054060364);


-- =====================================================================================================================================================================
-- START CHECK TERMINATION
-- =====================================================================================================================================================================

select REPLACE(m.username,'-delete','') as "username", u.nama, -- m.owner, u4.username,
--	m.jbid, -- m.spid, m.upid, 
	s.srank, (select count(m4.username) from memberships m4 where m4."owner" = m."owner") as "hu",
	REPLACE(m3.username,'-delete','') as "sponsor_username", u3.nama as "sponsor_name", -- m3."owner",
	REPLACE(REPLACE(m2.username,'-delete',''), 'dgsc-', '') as "upline_username", u2.nama as "upline_name",
	m.created_at, m.activated_at
from memberships m 
	left outer join users u on REPLACE(u.username,'-block','') = REPLACE(m.username,'-delete','')
	left outer join sranks s on m.jbid = s.jbid 
	left outer join memberships m2 on m.upid = m2.jbid
	left outer join users u2 on  REPLACE(u2.username,'-block','') = REPLACE(REPLACE(m2.username,'-delete',''), 'dgsc-', '') --u2.uid = m2."owner" --
	left outer join memberships m3 on m.spid = m3.jbid
	left outer join users u3 on u3.uid = m3."owner" -- REPLACE(u3.username,'-block','') = REPLACE(m3.username,'-delete','')
--	left outer join users u4 on m.owner = u4.uid 
where u.nama is not null and
	m.username ILIKE ANY(ARRAY[
		'marlin1309511%',
		'budisa270852%',
		'amarmu2305211',
		'andang2508341%',
		'atiksa181132%',
		'dewire2206881%',
		'endang060912',
		'hernia051128',
		'idanur291085',
		'iimsit2205281',
		'iloh110666',
		'istiwi2205461',
		'%karni091057%',
		'mahdar0903521',
		'midian0206571',
		'mulyat0708521',
		'netyis240178',
		'nuraen301125',
		'nurcah0505611',
		'sitima1106931',
		'sitimu1605681',
		'takari231235',
		'vilias210563',
		'warsik0606571'
		]
	)
order by REPLACE(m.username,'-delete','')
;

-- =====================================================================================================================================================================
-- END CHECK TERMINATION
-- =====================================================================================================================================================================



SELECT u.username as "u_owner", m.username, u.nama ,case when (s.srank = 0 or s.srank is null) then '' else r.short_name end as "rank_desc"
from memberships m 
	left outer join sranks s on m.jbid = s.jbid 
	left outer join ranks r on s.srank = r.id
	left outer join users u on m."owner" = u.uid 
where m.username ILIKE ANY(ARRAY[
			'fazril0604391%',
			'sindiw0911571%',
			'suward1210911%',
			'ayuros2804701%',
			'ramlan1109281%',
			'marlin1309511%'
		])
--group by u.username, m.username, u.nama, s.srank, r.short_name
;

select * from users u where u.username = 'tarmuj0602391';
