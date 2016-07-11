--TIMING
\timing
-- query 5 with replication, in site 2
(SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T2 ON (T2.nexttaskid = T1.previoustaskid)
INNER JOIN "scc2-edgecfd".dl_mat2 T3 ON (T2.dl_matid = T3.rid)
WHERE T3.visc=0.0003)

---------------------------------
-- QUERY ON A REMOTE DB - bd_rep1
---------------------------------
UNION ALL
-- query 5 with replication on node 1
(SELECT * FROM dblink('dbname=db_rep1','SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
	INNER JOIN "scc2-edgecfd".oedgecfdpre3 T2 ON (T2.nexttaskid = T1.previoustaskid)
	INNER JOIN "scc2-edgecfd".dl_mat3 T3 ON (T2.dl_matid = T3.rid)
	WHERE T3.visc=0.0008') as t1(dat character varying(250))
)