--TIMING
\timing
-- query 8 in site 1 with replication
(SELECT T2.mesh, T5.visc, T5.dens, T6.forcing
FROM "scc2-edgecfd".dl_solver2 T1
INNER JOIN "scc2-edgecfd".oedgecfdsolver2 T2 ON (T2.dl_solverid = T1.rid)
INNER JOIN "scc2-edgecfd".osetsolverconfig1 T3 ON (T3.nexttaskid = T2.taskid)
INNER JOIN "scc2-edgecfd".oedgecfdpre1 T4 ON (T3.previoustaskid = T4.nexttaskid)
INNER JOIN "scc2-edgecfd".dl_mat1 T5 ON (T4.dl_matid = T5.rid)
INNER JOIN "scc2-edgecfd".dl_in T6 ON (T4.dl_inid = T6.rid))
UNION ALL
(SELECT T2.mesh, T5.visc, T5.dens, T6.forcing
FROM "scc2-edgecfd".dl_solver2 T1
INNER JOIN "scc2-edgecfd".oedgecfdsolver2 T2 ON (T2.dl_solverid = T1.rid)
INNER JOIN "scc2-edgecfd".osetsolverconfig1 T3 ON (T3.nexttaskid = T2.taskid)
INNER JOIN "scc2-edgecfd".oedgecfdpre3 T4 ON (T3.previoustaskid = T4.nexttaskid)
INNER JOIN "scc2-edgecfd".dl_mat3 T5 ON (T4.dl_matid = T5.rid)
INNER JOIN "scc2-edgecfd".dl_in T6 ON (T4.dl_inid = T6.rid))

---------------------------
-- REMOTE QUERY ON DB2
---------------------------
UNION ALl
-- query 8 in site 2 with replication
SELECT * FROM  dblink('dbname=db2','(SELECT T2.mesh, T5.visc, T5.dens, T6.forcing
FROM "scc2-edgecfd".dl_solver2 T1
INNER JOIN "scc2-edgecfd".oedgecfdsolver2 T2 ON (T2.dl_solverid = T1.rid)
INNER JOIN "scc2-edgecfd".osetsolverconfig1 T3 ON (T3.nexttaskid = T2.taskid)
INNER JOIN "scc2-edgecfd".oedgecfdpre2 T4 ON (T3.previoustaskid = T4.nexttaskid)
INNER JOIN "scc2-edgecfd".dl_mat2 T5 ON (T4.dl_matid = T5.rid)
INNER JOIN "scc2-edgecfd".dl_in T6 ON (T4.dl_inid = T6.rid))') as q1_db1(mesh character varying(250), visc double precision, dens double precision,forcing double precision)
UNION ALL

SELECT * FROM  dblink('dbname=db2','(SELECT T2.mesh, T5.visc, T5.dens, T6.forcing
FROM "scc2-edgecfd".dl_solver2 T1
INNER JOIN "scc2-edgecfd".oedgecfdsolver2 T2 ON (T2.dl_solverid = T1.rid)
INNER JOIN "scc2-edgecfd".osetsolverconfig1 T3 ON (T3.nexttaskid = T2.taskid)
INNER JOIN "scc2-edgecfd".oedgecfdpre4 T4 ON (T3.previoustaskid = T4.nexttaskid)
INNER JOIN "scc2-edgecfd".dl_mat4 T5 ON (T4.dl_matid = T5.rid)
INNER JOIN "scc2-edgecfd".dl_in T6 ON (T4.dl_inid = T6.rid))') as q1_db2(mesh character varying(250), visc double precision, dens double precision, forcing double precision)
