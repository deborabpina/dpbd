-- query 5 with replication, in site 2
(SELECT dat from "scc2-edgecfd".osetsolverconfig1 T1
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T2 ON (T2.nexttaskid = T1.previoustaskid)
INNER JOIN "scc2-edgecfd".dl_mat2 T3 ON (T2.dl_matid = T3.rid)
WHERE T3.visc=0.0003)