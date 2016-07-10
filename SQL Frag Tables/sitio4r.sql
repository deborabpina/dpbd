CREATE TABLE "scc2-edgecfd".dl_solver2 AS
  SELECT * FROM "scc2-edgecfd".dl_solver WHERE velocity_0 > 0.35;

CREATE TABLE "scc2-edgecfd".oedgecfdsolver2 AS
  SELECT solver.* FROM "scc2-edgecfd".oedgecfdsolver AS solver INNER JOIN "scc2-edgecfd".dl_solver2 AS dlsolver ON solver.dl_solverid=dlsolver.rid;


-- dl_solver2 alter table
ALTER TABLE "scc2-edgecfd".dl_solver2
ADD CONSTRAINT dl_solver2_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_solver2
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_solver2
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
      
-- oedgecfdsolver2 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdsolver2
ADD CONSTRAINT oedgecfdsolver2_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdsolver2
ADD CONSTRAINT dl_solveridfk FOREIGN KEY (dl_solverid)
      REFERENCES "scc2-edgecfd".dl_solver2 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdsolver2
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdsolver2
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
