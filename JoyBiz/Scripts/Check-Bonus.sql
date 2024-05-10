-- CHECK BONUS 
select * from week_periodes wp where to_char("eDate" , 'YYYY-MM') = '2024-05' order by "eDate" limit 10;


-- BONUS JOY
select *
from joy_bonus_summaries jbs 
where jbs.wid = 331
order by jbs."date"  desc 
limit 100;

-- BONUS PLAN
select * 
from bonus_weeklies bw 
where bw.wid = 331
order by bw.created_at desc, bw.total_transfer
limit 100;

-- BONUS PUC/MPU
select *
from fee_pucs fp 
--where fp."owner" in (select "owner" from memberships m where m.username in ('sumari2604911','franky1110191'))
--	  and fp."date" = '2024-03-20'
order by fp.created_at desc
limit 100;

-- CHECK VOUCHER
select * from joy_bonus_summaries jbs order by jbs.wid desc;


-- CHECK CONVERT TO VOUCHER
-- JOY + BIZ NETT
select bw."owner", u.username, 
		bw.total + jbs.total as "total_bonus",
		bw.voucher2 , bw.voucher as "biz_voucher", bw.ppn as "biz_tax", bw.total as "total_biz", bw.total_transfer  as "total_transfer_biz", (bw.total - (bw.voucher + bw.ppn)) as "biz_transfer_h",
		jbs.total as "total_joy", jbs.voucher as "joy_voucher", jbs.tax as "joy_tax", jbs.transfer as "total_transfer_joy", (jbs.total - (jbs.voucher + jbs.tax)) as "joy_transfer_h",
	  (bw.total - (bw.voucher + bw.ppn)) + (jbs.total  - (jbs.voucher + jbs.tax)) as "total_bonus_transfer"
from bonus_weeklies bw 
	 inner join joy_bonus_summaries jbs on bw."owner" = jbs."owner" and bw.wid = jbs.wid 
	 inner join users u on bw."owner" = u.uid 
where bw.wid = 330 and bw.total + jbs.total >= 90000
order by (bw.total - (bw.voucher + bw.ppn)) + (jbs.total - (jbs.voucher + jbs.tax)) -- bw.total
limit 100; 

select bw.id, bw.wid, bw.created_at, bw."owner", u.username, bw.total, bw.voucher, bw.ppn, bw.total_transfer, 
		case 
			when (bw.total_transfer - (bw.voucher + bw.ppn)) < 0 then 0
			else (bw.total_transfer - (bw.voucher + bw.ppn)) 
		end as "nett_bonus"
from bonus_weeklies bw 
	inner join users u on bw."owner" = u.uid 
where bw.wid = 330 and (bw.total_transfer - (bw.voucher + bw.ppn)) < 60000 
order by bw.total
limit 100; 


select * from joy_bonus_summaries jbs where wid = 330 and "date" in ('2024-04-14', '2024-04-15') order by "date" desc;
update joy_bonus_summaries jbs set confirmed = true, published = true  where wid = 330 and "date" in ('2024-04-14', '2024-04-15');

se;lect 

select * from bonus_expresses be where code_trans in ('SFLNUJ');

select transaction_date , * from "transaction" t where is_pickup = 1 and pickup_stock_pack = 'MPUC003' order by transaction_date desc;

select * from stock_packs sp where sp.code = 'MPUC002';
select * from memberships m where "owner" = 'd3e238a4-3aff-4b3b-a215-990a9872b547';

select * from memberships m where username in ('supyan2810451','supyan2810451');
select * from users u where username in ('supyan2810451','supyan2810451');

select * 
from joy_bonus_summaries jbs 
where "owner" in ('c53131c3-d9ae-4e62-9a2b-d434bda60395')
	  and wid between 298 and 302
order by "owner", wid desc;

select * 
from bonus_weeklies bw 
where "owner" in ('96867ffc-936f-46e7-a37e-d5dd1bf0b66a','d3e238a4-3aff-4b3b-a215-990a9872b547')
	  and wid between 298 and 302
order by "owner", wid desc;


select m2.username as "Sponsor", u2.nama as "Nama Sponsor",
--		m.spid, m.username, 
		u.username, u.nama, u.handphone, sum(t.pv_total) as PV  -- , t.transaction_date m.jbid, t.id_cust_fk, 
from "transaction" t 
	 inner join memberships m on t.id_cust_fk = m.jbid 
	 inner join memberships m2 on m.spid = m2.jbid 
	 inner join users u on m."owner" = u.uid 
	 left outer join users u2 on m2.username = u2.username
where to_char(t.transaction_date , 'YYYY-MM-DD') between '2024-02-29' and '2024-03-27'
	And t.deleted_at is null
	and t.status in('PC', 'S', 'A', 'I') -- PAID
--	and m.username = 'masito050191'
--	and m.spid in (select m3.jbid from memberships m3 where m3.username in ('wendri290683', 'mocham0409911', 'ipanka1111751', 'ferlin2707821', 'hennym2707611', 'dedemu0409731', 'gilang1807741'))
group by m2.username, u2.nama,
--		m.spid, 
		m."owner", 
		m.username, u.username, m.jbid, t.id_cust_fk, u.nama, u.handphone
having sum(t.pv_total) >= 240
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
	select m.username, bw.user_id, bw."owner", bw.wid, wp."name", bw.total, bw.voucher, bw.ppn, bw.total_transfer 
	from bonus_weeklies bw 
		left outer join memberships m on bw.user_id = m.uid and bw."owner" = m."owner"  
		inner join week_periodes wp on bw.wid = wp.id 
	where 
--		bw.wid = 324
--		 and 
		 m.username ilike 'afidan0508911'
--		 and wp."name" = '2'
		 ; --in ('wati040554')
--							)
	 order by bw."owner", bw.total;

	select * from memberships m where username ='wati040554';
select * from bonus_weeklies bw where "owner" = 'f19f8fdb-e441-4b5e-b1f3-5814e64ef096' and wid = 323;
--	select * from week_periodes wp where wp.id > 321 order by id ;
	
	select "owner", wid, wp."name", total, voucher, ppn, total_transfer 
	from bonus_weeklies bw 
		inner join week_periodes wp on bw.wid = wp.id 
	where wid = 324
		and "owner" in (   
						select m.owner
						from memberships m 
						where m.username in ('jonels1709751')
					)
	 order by "owner", total;
	--	END UPDATE PPH BONUS BIZPLAN
	
	select * from bonus_weeklies bw where wid = 323 and "owner" = '06b72e95-c214-4a96-b569-299f46fd7b93';
	select * from prepared_data_joys pdj where wid = 323 ;
	
	--	START UPDATE PPH BONUS JOYPLAN	
	select * 
	from joy_bonus_summaries jbs 
	where "owner" = '026d38b1-10ef-4104-ab15-6ef16e0b6a01' and wid =323;
	

	select m.username, count(m.username) as "qty", jbs.user_id, jbs."owner", jbs.wid, wp.name,
			sum(jbs.xpress) as "xpress", sum(jbs.bgroup) as "bgroup", 
			sum(jbs.leadership) as "leadership", sum(jbs.year_end) as "year_end", 
			round(sum(jbs.voucher)) as "voucher", sum(jbs.tax) as "tax", 
			sum(jbs.total) as "total", round(sum(jbs.transfer)) as "transfer" -- , jbs."date"
	from joy_bonus_summaries jbs  
		left outer join memberships m on jbs.user_id = m.uid and jbs."owner" = m."owner"  
		left outer join week_periodes wp on jbs.wid = wp.id 
	where 
--		jbs.wid = 325
--		 and 
		 m.username in ('afidan0508911')
	group by  m.username, jbs.user_id, jbs."owner", jbs.wid, wp.name
--	having count(m.username) > 1
	 order by jbs.wid desc, jbs."owner", sum(jbs.total);
	
	
	
	
	
	
	
	select jbs.wid, m.username, jbs."owner", m.username, 
			sum(jbs.xpress) as "xpress", sum(jbs.bgroup) as "bgroup", 
			sum(jbs.leadership) as "leadership", sum(jbs.year_end) as "year_end", 
			sum(jbs.total) as "total", 
			round(sum(jbs.voucher)) as "voucher", sum(jbs.tax) as "tax", 
			round(sum(jbs.transfer)) as "transfer", -- , jbs."date"
			wp.name, jbs.created_at, jbs.updated_at 
	from joy_bonus_summaries jbs  
		left outer join memberships m on jbs.user_id = m.uid and jbs."owner" = m."owner"  
		left outer join week_periodes wp on jbs.wid = wp.id 
	where 
--		jbs.wid = 325
--		 and 
		 m.username in ('afidan0508911')
	group by  m.username, jbs.user_id, jbs."owner", jbs.wid, wp.name, jbs.created_at, jbs.updated_at 
--	having count(m.username) > 1
	 order by jbs.wid desc, jbs."owner", sum(jbs.total);
	
	
	
	
	
	
	select * from joy_bonus_summaries jbs where "owner" in ('02dbb68d-de44-4466-8223-5bd8ac175541');
	select * from week_periodes wp where name ilike '24.3.%' order by id desc;	


	select -- * --"owner", wid, total, voucher, tax, transfer, year_end ;
		jbs.id, jbs."date", jbs.wid, jbs."owner", jbs.xpress, jbs.bgroup, jbs.leadership, jbs.year_end, jbs.total, jbs.voucher, jbs.tax, jbs.transfer
	from joy_bonus_summaries jbs 
	where  jbs.wid = 324
		and jbs.total > 0
		and jbs."owner" in (
					select m."owner"
					from memberships m 
					where m.username in (
'abuwah290275',
'adrinn0801811',
'afidan0508911',
'agusev020889',
'agusev020889',
'agussu180450',
'ahmada2104591',
'alfrid0407851',
'aminga1702591',
'amirma111057',
'amirma111057',
'ananda2807901',
'ananda2807901',
'andika2612201',
'anwar210186',
'arnawa0211491',
'asmara070862',
'asmara070862',
'astria1907621',
'bamban2006961',
'bessek2305331',
'besses1901261',
'bessew210665',
'bessew210665',
'bessew210665',
'bessew210665',
'budian1201551',
'budian1201551',
'bungar1201441',
'bungar1201441',
'bungar1201441',
'burhan250557',
'caroli17029',
'caroli17029',
'caroli17029',
'caroli17029',
'chriso1009941',
'darwin020280',
'dedesa0912191',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'didhin0610591',
'diniwi230132',
'drglin150191',
'drglin150191',
'drglin150191',
'drglin150191',
'ekasem110394',
'ekasem110394',
'ekasem110394',
'ekobud071247',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'esters0412451',
'esters0412451',
'esters0412451',
'esters0412451',
'eulism0602611',
'ferlin2707821',
'fitriy1611991',
'franky1110191',
'gilang1807741',
'gilang1807741',
'hanifd3105701',
'haryan221055',
'hasisa1801421',
'hennym2707611',
'hulday0208561',
'iffala120921',
'iffala120921',
'iffala120921',
'iffala120921',
'igedes2101351',
'igedes2101351',
'igitwi1602921',
'indra120289',
'indram0911961',
'indram0911961',
'indram0911961',
'indram0911961',
'indram0911961',
'inyoma140279',
'inyoma140279',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'iputus220321',
'ivonew0806631',
'jonels1709751',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysys16',
'joysys16',
'joysys16',
'joysys16',
'joysys16',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'karwat1602461',
'khairu191098',
'khairu191098',
'khairu191098',
'kiswan0603331',
'kusyen1801681',
'laodep160554',
'laodep160554',
'laodep160554',
'laodep160554',
'mahast2408911',
'mahast2408911',
'mahbub1112701',
'mamans2907761',
'mamans2907761',
'mangga0502451',
'maratu1610761',
'marlan0412111',
'maryan150349',
'maryan150349',
'matjur0402841',
'meilan0502321',
'meilan0502321',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'mohamm160986',
'mohamm160986',
'mohamm160986',
'mohamm160986',
'mohammad171260',
'mohammad171260',
'mohammad171260',
'mohammad171260',
'muarif180323',
'muarif180323',
'muarif180323',
'muhamm0502541',
'muntol080939',
'muthia2910951',
'naomip140597',
'nazili2705651',
'nazili2705651',
'nilawa0108691',
'nining2507921',
'nining2507921',
'nining2507921',
'nining2507921',
'nurhas211126',
'nurmiz2312491',
'oktoer011020',
'pauzia211022',
'pebip.200264',
'pebip.200264',
'pulung031093',
'ratnaa180785',
'ridwan080753',
'ridwan080753',
'rilyan0108161',
'rilyan0108161',
'rilyan0108161',
'rinahe1809561',
'rizkyn12092',
'rizkyn12092',
'rizkyn12092',
'rizkyn12092',
'rosfin1105421',
'rosfin1105421',
'runa1007761',
'rutpin301034',
'samuel0407291',
'sastri141029',
'sitinu0411961',
'sobihi1001191',
'sriagu2707561',
'sriagu2707561',
'sriagu2707561',
'srihar1410891',
'sugian130390',
'sugian130390',
'suhart201021',
'sukart010728',
'supriy15053',
'supriy15053',
'supriy15053',
'supriy15053',
'suyant2811121',
'suyant2811121',
'trihan211013',
'triwin250412',
'wahida121256',
'wendri290683',
'wendri290683',
'wendri290683',
'wendri290683',
'winadi0207861',
'yuyunr1608311',
'zulfin15024',
'zulfin15024'
)
--							and m.username not in ('joysys18','andhik0601181','rilyan0108161','desi14047','mohammad171260','agusev020889')
		)
		and jbs.deleted_at is null
	order by jbs.wid desc, jbs."owner", jbs.total, jbs.voucher ; --jbs.id, 
	--	END UPDATE PPH BONUS JOYPLAN

-- ============================================================================================
-- END UPDATE TAX/PPH
-- ============================================================================================

select m."owner", m.username 
					from memberships m 
					where m.username in (
'abuwah290275',
'adrinn0801811',
'afidan0508911',
'agusev020889',
'agusev020889',
'agussu180450',
'ahmada2104591',
'alfrid0407851',
'aminga1702591',
'amirma111057',
'amirma111057',
'ananda2807901',
'ananda2807901',
'andika2612201',
'anwar210186',
'arnawa0211491',
'asmara070862',
'asmara070862',
'astria1907621',
'bamban2006961',
'bessek2305331',
'besses1901261',
'bessew210665',
'bessew210665',
'bessew210665',
'bessew210665',
'budian1201551',
'budian1201551',
'bungar1201441',
'bungar1201441',
'bungar1201441',
'burhan250557',
'caroli17029',
'caroli17029',
'caroli17029',
'caroli17029',
'chriso1009941',
'darwin020280',
'dedesa0912191',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'desi14047',
'didhin0610591',
'diniwi230132',
'drglin150191',
'drglin150191',
'drglin150191',
'drglin150191',
'ekasem110394',
'ekasem110394',
'ekasem110394',
'ekobud071247',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'enriad0311211',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'erwin0311861',
'esters0412451',
'esters0412451',
'esters0412451',
'esters0412451',
'eulism0602611',
'ferlin2707821',
'fitriy1611991',
'franky1110191',
'gilang1807741',
'gilang1807741',
'hanifd3105701',
'haryan221055',
'hasisa1801421',
'hennym2707611',
'hulday0208561',
'iffala120921',
'iffala120921',
'iffala120921',
'iffala120921',
'igedes2101351',
'igedes2101351',
'igitwi1602921',
'indra120289',
'indram0911961',
'indram0911961',
'indram0911961',
'indram0911961',
'indram0911961',
'inyoma140279',
'inyoma140279',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'ipanka1111751',
'iputus220321',
'ivonew0806631',
'jonels1709751',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joy201741',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysup100919',
'joysys16',
'joysys16',
'joysys16',
'joysys16',
'joysys16',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'joysys18',
'karwat1602461',
'khairu191098',
'khairu191098',
'khairu191098',
'kiswan0603331',
'kusyen1801681',
'laodep160554',
'laodep160554',
'laodep160554',
'laodep160554',
'mahast2408911',
'mahast2408911',
'mahbub1112701',
'mamans2907761',
'mamans2907761',
'mangga0502451',
'maratu1610761',
'marlan0412111',
'maryan150349',
'maryan150349',
'matjur0402841',
'meilan0502321',
'meilan0502321',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'moelja1301911',
'mohamm160986',
'mohamm160986',
'mohamm160986',
'mohamm160986',
'mohammad171260',
'mohammad171260',
'mohammad171260',
'mohammad171260',
'muarif180323',
'muarif180323',
'muarif180323',
'muhamm0502541',
'muntol080939',
'muthia2910951',
'naomip140597',
'nazili2705651',
'nazili2705651',
'nilawa0108691',
'nining2507921',
'nining2507921',
'nining2507921',
'nining2507921',
'nurhas211126',
'nurmiz2312491',
'oktoer011020',
'pauzia211022',
'pebip.200264',
'pebip.200264',
'pulung031093',
'ratnaa180785',
'ridwan080753',
'ridwan080753',
'rilyan0108161',
'rilyan0108161',
'rilyan0108161',
'rinahe1809561',
'rizkyn12092',
'rizkyn12092',
'rizkyn12092',
'rizkyn12092',
'rosfin1105421',
'rosfin1105421',
'runa1007761',
'rutpin301034',
'samuel0407291',
'sastri141029',
'sitinu0411961',
'sobihi1001191',
'sriagu2707561',
'sriagu2707561',
'sriagu2707561',
'srihar1410891',
'sugian130390',
'sugian130390',
'suhart201021',
'sukart010728',
'supriy15053',
'supriy15053',
'supriy15053',
'supriy15053',
'suyant2811121',
'suyant2811121',
'trihan211013',
'triwin250412',
'wahida121256',
'wendri290683',
'wendri290683',
'wendri290683',
'wendri290683',
'winadi0207861',
'yuyunr1608311',
'zulfin15024',
'zulfin15024'
);

select * from users u where no_ktp is null order by created_at desc;
select * from memberships m where username = 'nazili2705651';
select * from voucher_details vd where vd."owner" = 'c53131c3-d9ae-4e62-9a2b-d434bda60395';


select * from vouchers v where v."owner" = 'c53131c3-d9ae-4e62-9a2b-d434bda60395';

select m."owner", m.username, u.nama, bw.wid, bw.team, bw.carry_forward, bw.total, bw.ppn, bw.voucher, bw.total_transfer 
from bonus_weeklies bw 
	 inner join memberships m on bw."owner" = m."owner" 
	 inner join users u on m."owner" = u.uid 
where m.username in ('abduls1406841',
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




select * from delivery_orders do2 
--where code = '240328318328'
order by id desc
;
					
					

					