-- query 5 without replication on node 2
SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T2 ON (T2.nexttaskid = T1.previoustaskid)
WHERE T2.visc=0.0003
