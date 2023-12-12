/*
CREATE TABLE public.test_transaction (
	id bigserial NOT NULL,
	member_id int NOT NULL,
	amount int null,
	transation_date timestamp(0) null,
	CONSTRAINT test_transaction_pkey PRIMARY KEY (id)
);
*/

/*
WITH RECURSIVE DownlineHierarchy AS (
  SELECT
    m.id AS member_id,
    m.fullname AS fullname,
    m.sponsor_id,
    t.amount AS transaction_amount
  FROM test_member m
  	LEFT JOIN test_transaction t ON m.id = t.member_id

  UNION ALL

  SELECT
    m.id AS member_id,
    m.fullname AS fullname,
    m.sponsor_id,
    t.amount AS transaction_amount
  from test_member m
	JOIN test_transaction t ON m.id = t.member_id
	JOIN DownlineHierarchy d ON m.id = d.sponsor_id
)

SELECT
  member_id,
  COALESCE(SUM(transaction_amount), 0) AS total_transaction_amount
FROM  DownlineHierarchy
GROUP BY  member_id
ORDER BY  member_id;

*/


WITH RECURSIVE DownlineHierarchy AS (
  SELECT
    m.id AS member_id,
    m.fullname AS fullname,
    m.sponsor_id,
    t.amount AS amount
  from test_member m
  	LEFT JOIN test_transaction t ON m.id = t.member_id
--  where m.id = 6

  UNION ALL

  SELECT
    m2.id AS member_id,
    m2.fullname AS fullname,
    m2.sponsor_id,
    t2.amount AS amount
  FROM test_member m2
	  JOIN test_transaction t2 ON m2.id = t2.member_id
	  JOIN DownlineHierarchy d ON m2.id = d.sponsor_id
)

SELECT
  dh.member_id, dh.fullname, -- dh.amount
  COALESCE(SUM(dh.amount), 0) AS total_amount
FROM DownlineHierarchy dh
--	LEFT JOIN test_transaction dt ON dh.member_id = dt.member_id
GROUP BY dh.member_id, dh.fullname --, dh.amount
ORDER BY dh.member_id;





WITH RECURSIVE cte AS (
  -- Start with all members
  SELECT m.id AS member_id,
         m.sponsor_id AS parent_id,
         t.amount AS transaction_amount,
         0 AS group_transaction_sum
  FROM test_member m
  LEFT JOIN test_transaction t ON t.member_id = m.id

  UNION ALL

  -- Add children members and their transaction amounts
  SELECT c.member_id,
         c.parent_id,
         t.amount,
         p.group_transaction_sum + c.transaction_amount AS group_transaction_sum
  FROM cte c
	  JOIN test_member m ON m.sponsor_id = c.member_id
	  LEFT JOIN test_transaction t ON t.member_id = m.id
	  JOIN cte p ON p.member_id = c.parent_id
)

-- Select final results
SELECT member_id, group_transaction_sum
FROM cte
WHERE parent_id IS NULL;
