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
order by fp.created_at desc
limit 100;


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
			sum(jbs.voucher) as "voucher", sum(jbs.tax) as "tax", 
			sum(jbs.total) as "total", sum(jbs.transfer) as "transfer" -- , jbs."date"
	from joy_bonus_summaries jbs  
		left outer join memberships m on jbs.user_id = m.uid and jbs."owner" = m."owner"  
	where jbs.wid = 323
		 and m.username in ('runa1007761',
							'joy201741',
							'masrif2507821',
							'rinida2712501',
							'joy201741',
							'ipanka1111751',
							'idafar1509151',
							'nining2507921',
							'mediaw2709561',
							'suli1409721',
							'nurhas050175',
							'joy201741',
							'sulast1711951',
							'srihar1410891',
							'indra120289',
							'winadi0207861',
							'indram0911961',
							'triwin250412',
							'lutfiy1210391',
							'diniwi230132',
							'abdulm1310721',
							'musasa1711561',
							'aikhod2308481',
							'abdhar3010331',
							'safitr2807831',
							'khusnu1209421',
							'darwin020280',
							'arnyka1304471',
							'andari0408331',
							'lilist0108951',
							'nawari2110911',
							'andika2612201',
							'astria1907621',
							'luhemi0410961',
							'masrif2507821',
							'joy201741',
							'marceb1308651',
							'mocham0409911',
							'evitai1810931',
							'indram0911961',
							'indram0911961',
							'uripha2110331',
							'mamans2907761',
							'indra120289',
							'joy201741',
							'yuniar3007821',
							'nuryan171272',
							'joy201741',
							'nizani0602211',
							'risayu2301431',
							'meilan0502321',
							'nilawa0307631',
							'meilan0502321',
							'niketu250225',
							'matjur0402841',
							'alfrid0407851',
							'abdhar3010331',
							'leoniv2506701',
							'burhan250557',
							'zalufi2606521',
							'indram0911961',
							'sabina0504511',
							'dedeku2901131',
							'winadi0207861',
							'supriy15053',
							'rosmaw2107201',
							'indram0911961',
							'suli1409721',
							'mamans2907761',
							'ekasem110394',
							'herlin280820',
							'naomip140597',
							'dimaku0310291',
							'joy201741',
							'naomip140597',
							'laelas081081',
							'masang1606391',
							'erlenn260961',
							'yudhia0310941',
							'santis0112981',
							'muhamm2802331',
							'dedise3101601',
							'meilan0502321',
							'dhiafa0309321',
							'firman191136',
							'pebip.200264',
							'imaded291288',
							'sumarm0307181',
							'dedesa0912191',
							'yandri0704351',
							'rizkyn12092',
							'inyoma140279',
							'ekasem110394',
							'dedesa0912191',
							'pebip.200264',
							'sukart010728',
							'hanifd3105701',
							'nuryan171272',
							'mamans2907761',
							'ponowi130234',
							'dedesa0912191',
							'joysys16',
							'rutpin301034',
							'indra120289',
							'krisna0612961',
							'hanifd3105701',
							'andhik0601181',
							'dorcet160675',
							'hasisa1801421',
							'niakur0309531',
							'nining2507921',
							'sittin2105361',
							'maryan150349',
							'andika2612201',
							'endang220246',
							'andika2612201',
							'leoniv2506701',
							'widian2308561',
							'liliok300118',
							'enriad0311211',
							'suryan3101751',
							'erwin0311861',
							'yulian2106521',
							'erwin0311861',
							'hasan281075',
							'samsul2405461',
							'inadwi680057',
							'ayunab0111641',
							'arisah0211251',
							'evayun2610431',
							'sudars2111741',
							'amelia0902811',
							'rizkyn12092',
							'joysup100919',
							'meilan0502321',
							'nazili2705651',
							'budian1201551',
							'agusmu0112791',
							'indram0911961',
							'joysys16',
							'joysys16',
							'franky1110191',
							'seseko270352',
							'budian1201551',
							'enriad0311211',
							'joysup100919',
							'joysup100919',
							'enriad0311211',
							'ipanka1111751',
							'hasisa1801421',
							'mohamm160986',
							'hennym2707611',
							'joysup100919',
							'saiful0606871',
							'erwin0311861',
							'joysup100919',
							'erwin0311861',
							'nurhas211126',
							'agussu180450',
							'erwin0311861',
							'joysys16',
							'enriad0311211',
							'erwin0311861',
							'fikrin0107721',
							'suyitn3010141',
							'hashif2003721',
							'wahida121256',
							'fitriy1611991',
							'joysys16',
							'abuwah290275',
							'joysup100919',
							'enriad0311211',
							'joysys16',
							'saiful0606871',
							'enriad0311211',
							'erwin0311861',
							'joysys16',
							'aikhod2308481',
							'supriy15053',
							'pebip.200264',
							'ipanka1111751',
							'indram0911961',
							'enriad0311211',
							'asmara070862',
							'khusnu1209421',
							'wahida121256',
							'anwar210186',
							'alfrid0407851',
							'bungar1201441',
							'nurhas211126',
							'ananda2807901',
							'fikrin0107721',
							'suyitn3010141',
							'hashif2003721',
							'pebip.200264',
							'abuwah290275',
							'ananda2807901',
							'mohamm160986',
							'supriy15053',
							'desakn240694',
							'agussu180450',
							'agussu180450',
							'asmara070862',
							'anwar210186',
							'diniwi230132',
							'haidar2904991',
							'madera140876',
							'ananda2807901',
							'abuwah290275',
							'wahida121256',
							'nurhas211126',
							'pebip.200264',
							'lutfiy1210391',
							'mahast2408911',
							'firdan140915',
							'bungar1201441',
							'haidar2904991',
							'rizkyn12092',
							'wislah250817',
							'aarmis250664',
							'yudinr010848',
							'burhan250557',
							'waoder051134',
							'asmara070862',
							'husnul270384',
							'baguse2408721',
							'ekobud071247',
							'nandio2111871',
							'bungar1201441',
							'ekasem110394',
							'supriy15053',
							'mocham0409911',
							'santis0112981',
							'agusev020889',
							'desi14047',
							'joysys18',
							'mohammad171260',
							'joysys18',
							'rilyan0108161',
							'desi14047',
							'mohammad171260'
							)
	group by  m.username, jbs.user_id, jbs."owner", jbs.wid
--	having count(m.username) > 1
	 order by jbs."owner", sum(jbs.total);
	
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


