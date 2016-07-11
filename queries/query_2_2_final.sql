--TIMING
\timing

--file name query nº node
SELECT mesh, visc, dens, kxx, kyy, kzz FROM "scc2-edgecfd".oedgecfdpre2 T1 
INNER JOIN "scc2-edgecfd".dl_mat2 T2 ON (T1.dl_matid = T2.rid)
