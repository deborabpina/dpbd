SELECT mesh, visc, dens, kxx, kyy, kzz FROM "scc2-edgecfd".oedgecfdpre T1 
INNER JOIN "scc2-edgecfd".dl_mat T2 ON (T1.dl_matid = T2.rid)
WHERE visc>=0.0002 AND visc<=0.0006

SELECT dat from "scc2-edgecfd".osetsolverconfig T1
INNER JOIN "scc2-edgecfd".oedgecfdpre T2 ON (T2.nexttaskid = T1.previoustaskid)
INNER JOIN "scc2-edgecfd".dl_mat T3 ON (T2.dl_matid = T3.rid)
WHERE visc=0.0003 OR visc=0.0008

SELECT T2.mesh, T5.visc, T5.dens, T6.forcing
FROM "scc2-edgecfd".dl_solver T1
INNER JOIN "scc2-edgecfd".oedgecfdsolver T2 ON (T2.dl_solverid = T1.rid)
INNER JOIN "scc2-edgecfd".osetsolverconfig T3 ON (T3.nexttaskid = T2.taskid)
INNER JOIN "scc2-edgecfd".oedgecfdpre T4 ON (T3.previoustaskid = T4.nexttaskid)
INNER JOIN "scc2-edgecfd".dl_mat T5 ON (T4.dl_matid = T5.rid)
INNER JOIN "scc2-edgecfd".dl_in T6 ON (T4.dl_inid = T6.rid)
WHERE T1.velocity_0 > 0.35