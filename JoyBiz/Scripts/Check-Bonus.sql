-- CHECK BONUS 
select * from week_periodes wp where to_char("eDate" , 'YYYY-MM') = '2024-03' order by "eDate" limit 10;


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
where fp."owner" in (select "owner" from memberships m where m.username in ('sumari2604911','franky1110191'))
	  and fp."date" = '2024-03-20'
order by fp.created_at desc
limit 100;


select * from stock_packs sp where sp.code = 'MPUC002';
select * from memberships m where "owner" = 'd3e238a4-3aff-4b3b-a215-990a9872b547';

select * from memberships m where username in ('mohammad171260','ivonew0806631');

select * 
from joy_bonus_summaries jbs 
where "owner" in ('96867ffc-936f-46e7-a37e-d5dd1bf0b66a')
	  and wid between 298 and 302
order by "owner", wid desc;

select * 
from bonus_weeklies bw 
where "owner" in ('96867ffc-936f-46e7-a37e-d5dd1bf0b66a','d3e238a4-3aff-4b3b-a215-990a9872b547')
	  and wid between 298 and 302
order by "owner", wid desc;


select m2.username, 
--		m.spid, m.username, 
		u.username, u.nama, u.handphone, sum(t.pv_total) as PV  -- , t.transaction_date m.jbid, t.id_cust_fk, 
from "transaction" t 
	 inner join memberships m on t.id_cust_fk = m.jbid 
	 inner join memberships m2 on m.spid = m2.jbid 
	 inner join users u on m."owner" = u.uid 
where to_char(t.transaction_date , 'YYYY-MM-DD') between '2024-02-29' and '2024-03-29'
	And t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
	and m.spid in (select m3.jbid from memberships m3 where m3.username in ('wendri290683', 'mocham0409911', 'ipanka1111751', 'ferlin2707821', 'hennym2707611', 'dedemu0409731', 'gilang1807741'))
group by m2.username, 
--		m.spid, 
		m."owner", 
		m.username, u.username, m.jbid, t.id_cust_fk, u.nama, u.handphone
--having sum(t.pv_total) >= 240
order by m2.username, m."owner", m.username; --, t.transaction_date

'wendri290683', 'mocham0409911', 'ipanka1111751', 'ferlin2707821', 'hennym2707611', 'dedemu0409731', 'gilang1807741'))

select *
from memberships m 
--	 inner join memberships m2 on m.spid=m2.jbid 
where m.spid = 8647
--(select m3.jbid from memberships m3 where m3.username = 'wendri290683');
;

select * from "transaction" t where code_trans in ('MWARPE');
select * from users u where id = 1209;

-- ============================================================================================
-- START UPDATE TAX/PPH
-- ============================================================================================
	
	
	--	START UPDATE PPH BONUS BIZPLAN
	select m.username, bw.user_id, bw."owner", bw.wid, bw.total, bw.voucher, bw.ppn, bw.total_transfer 
	from bonus_weeklies bw 
		left outer join memberships m on bw.user_id = m.uid and bw."owner" = m."owner"  
	where bw.wid = 300
--		 and m.username in ('indra120289'
--							)
	 order by bw."owner", bw.total;

	select * from memberships m where username ='endang220246';
select * from bonus_weeklies bw where "owner" = '0ad45beb-c1be-4377-8f42-c94cbe486b1c' and wid = 323;
--	select * from week_periodes wp where wp.id > 321 order by id ;
	
	select "owner", wid, total, voucher, ppn, total_transfer 
	from bonus_weeklies bw 
	where wid = 323
		and "owner" in (   
						select m.owner
						from memberships m 
						where m.username in ('indra120289'
											)
					)
	 order by "owner", total;
	--	END UPDATE PPH BONUS BIZPLAN
	
	select * from bonus_weeklies bw where wid = 323 and "owner" = '06b72e95-c214-4a96-b569-299f46fd7b93';
	select * from prepared_data_joys pdj where wid = 323 ;
	
	--	START UPDATE PPH BONUS JOYPLAN	
	select * from joy_bonus_summaries jbs where "owner" = '026d38b1-10ef-4104-ab15-6ef16e0b6a01' and wid =323;
	select m.username, count(m.username) as "qty", jbs.user_id, jbs."owner", jbs.wid, 
			sum(jbs.xpress) as "xpress", sum(jbs.bgroup) as "bgroup", 
			sum(jbs.leadership) as "leadership", sum(jbs.year_end) as "year_end", 
			round(sum(jbs.voucher)) as "voucher", sum(jbs.tax) as "tax", 
			sum(jbs.total) as "total", round(sum(jbs.transfer)) as "transfer" -- , jbs."date"
	from joy_bonus_summaries jbs  
		left outer join memberships m on jbs.user_id = m.uid and jbs."owner" = m."owner"  
	where jbs.wid > 300
		 and m.username in ('mohamm160986')
	group by  m.username, jbs.user_id, jbs."owner", jbs.wid
--	having count(m.username) > 1
	 order by jbs.wid desc, jbs."owner", sum(jbs.total);
	
	select * from joy_bonus_summaries jbs where "owner" in ('02dbb68d-de44-4466-8223-5bd8ac175541');
	
	select -- * --"owner", wid, total, voucher, tax, transfer, year_end ;
		jbs.id, jbs."date", jbs.wid, jbs."owner", jbs.xpress, jbs.bgroup, jbs.leadership, jbs.year_end, jbs.total, jbs.voucher, jbs.tax, jbs.transfer
	from joy_bonus_summaries jbs 
	where jbs.wid = 323
		and jbs."owner" in (
					select m."owner"
					from memberships m 
					where m.username in ('joysys18','andhik0601181','rilyan0108161','desi14047','mohammad171260','agusev020889')
--							and m.username not in ('joysys18','andhik0601181','rilyan0108161','desi14047','mohammad171260','agusev020889')
		)
		and jbs.deleted_at is null
	order by jbs."owner", jbs.total ; --jbs.id, 
	--	END UPDATE PPH BONUS JOYPLAN

-- ============================================================================================
-- END UPDATE TAX/PPH
-- ============================================================================================



select * from users u where no_ktp is null order by created_at desc;




select m."owner", m.username, u.nama, bw.wid, bw.team, bw.carry_forward, bw.total, bw.ppn, bw.voucher, bw.total_transfer 
from bonus_weeklies bw 
	 inner join memberships m on bw."owner" = m."owner" 
	 inner join users u on m."owner" = u.uid 
where wid = 300
	  and m.username in ('abduls1406841',
						'abdulw2508151',
						'abdulw2508431',
						'agussu180450',
						'amirma111057',
						'ananto220281',
						'anwar210186',
						'anwar210186',
						'anyand210962',
						'asmara070862',
						'atmoja0805361',
						'azzahr190220',
						'bessew210665',
						'burhan250557',
						'darwin020280',
						'desakn240694',
						'desi14047',
						'dewiku010296',
						'diahag2907841',
						'diditj290618',
						'endang220246',
						'endang220246',
						'enriad0311211',
						'ferlin2707821',
						'frisca1909851',
						'gilang1807741',
						'haidar2904991',
						'hennym2707611',
						'hermit220229',
						'hjmagd2807551',
						'idaayu160826',
						'iffala120921',
						'indahs0308711',
						'indra120289',
						'indram0911961',
						'inyoma140279',
						'iputus220321',
						'ivonew0806631',
						'joy201741',
						'joysys18',
						'joysys20',
						'junaid300125',
						'khusnu1209421',
						'laodep160554',
						'liliok300118',
						'maryan150349',
						'masito050191',
						'moelja1301911',
						'mohammad171260',
						'muarif180323',
						'nining2507921',
						'ninyom080285',
						'nununn271137',
						'nurain0811941',
						'nurdin1102261',
						'nuryan171272',
						'pauzia211022',
						'pebip.200264',
						'ponowi130234',
						'rahmaw200956',
						'ratnaa180785',
						'rdnend0408721',
						'ridwan080753',
						'rohime07034',
						'rundia2303631',
						'sittin060790',
						'sulaesih061017',
						'sumrat0607501',
						'supriy15053',
						'suraya230820',
						'sutris040975',
						'tripuj0506851',
						'wendri290683',
						'winadi0207861',
						'yuliar310734',
						'zahara2808361'
						);

