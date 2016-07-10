-- query 5 with replication on node 1
SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre3 T3 ON (T3.nexttaskid = T1.previoustaskid)
WHERE T3.visc=0.0008)
UNION ALL
