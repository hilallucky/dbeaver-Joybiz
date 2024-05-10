-- START TERMINATE USER
/*
 * START STEP 1
 * TABLE users
 * 
 * Add "-terminate" to end of this fields (no_ktp, email, password, handphone)
 * Set "disabled" = 1
*/
select id, uid, username, nama, no_ktp, email, password, handphone ,disabled, updated_at 
from users u 
where u.username in ('mamans0502831');


	    SELECT u.id, u.username::text, u.nama::text,
	    		u.no_ktp::text, u.email::text, 
	    		u.password::text, u.handphone::text, 
	    		u.disabled::int, u.updated_at::timestamp(0), jcf.id,
	    		jcf.small_bv::bigint, jcf.big_bv::bigint, jrvf.id,
	    		jrvf.small_rv::bigint, jrvf.big_rv::bigint
	    FROM users u 
	    	 inner join joy_carry_forwards jcf on u.uid = jcf.owner
	    	 inner join joy_r_v_forwards jrvf on u.uid = jrvf.owner
	    WHERE u.username = 'mamans0502831'
	   		and jcf.id = (select max(jcf2.id) from joy_carry_forwards jcf2 where jcf2.owner = u.uid)
	   		and jrvf.id = (select max(jrvf2.id) from joy_r_v_forwards jrvf2 where jrvf2.owner = u.uid);
/* 
 * END STEP 1
*/

/*
 * START STEP 2
 * TABLE joy_carry_forwards
 *
 * Set big_bv = 0 & small_bv = 0
*/
SELECT lmh_terminate_member('mamans0502831');

select id, "owner", small_bv, big_bv
from joy_carry_forwards_test jcf  
where jcf."owner" in (select u.uid from users u where u.username in ('mamans0502831'))
order by owner, id desc
--limit 1
;

/* 
 * END STEP 2
*/



/*
 * START STEP 3
 * TABLE joy_r_v_forwards
 *
 * Set big_bv = 0 & small_bv = 0
*/
select *
from joy_r_v_forwards_test jrvft  
where jrvft."owner" in (select u.uid from users u where u.username in ('mamans0502831'))
order by id desc 
--limit 1
;
/* 
 * END STEP 3
*/


DO $$ 
	DECLARE
		bv bigint := 0;
		rv bigint := 0;
	    xowner uuid;
	    terminate text := '-terminate';
	    xusername text := 'mamans0502831';
	   
	BEGIN
		select u.uid into xowner --, u.usename
		from users u
		where username = xusername;
	
		update users  
		set no_ktp = concat(no_ktp, terminate), 
			email = concat(no_ktp, terminate), 
			password = concat(no_ktp, terminate), 
			handphone = concat(no_ktp, terminate), 
			disabled = 1,
			updated_at = now()
		where username = xusername;
	
		UPDATE joy_carry_forwards
		SET small_bv = bv, big_bv = bv, updated_at = now()
		WHERE id = (
		    SELECT MAX(id)
		    FROM joy_carry_forwards_test
		    WHERE owner = xowner
		);

		UPDATE joy_r_v_forwards 
		SET small_rv = rv, big_rv = rv, updated_at = now()
		WHERE id = (
		    SELECT MAX(id)
		    FROM joy_r_v_forwards_test 
		    WHERE owner = xowner
		);
		
--		RETURN 'Result: username = %, xowner = % updated', xusername, xowner;
	end
$$;


-- END TERMINATE USER




