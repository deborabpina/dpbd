-- query 5 without replication on node 2
SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T2 ON (T1.previoustaskid=T2.nexttaskid )
WHERE T2.visc=0.0003
