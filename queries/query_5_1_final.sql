--TIMING
\timing
-- query 5 withou replicaiton on node 1
(SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T2 ON (T2.nexttaskid = T1.previoustaskid)
INNER JOIN "scc2-edgecfd".dl_mat2 T3 ON (T2.dl_matid = T3.rid)
WHERE T3.visc=0.0003)
UNION ALL
(SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre3 T2 ON (T2.nexttaskid = T1.previoustaskid)
INNER JOIN "scc2-edgecfd".dl_mat3 T3 ON (T2.dl_matid = T3.rid)
WHERE T3.visc=0.0008)

