﻿CREATE TABLE "scc2-edgecfd".dl_solver1 AS
  SELECT * FROM "scc2-edgecfd".dl_solver WHERE velocity_0 <= 0.35;

CREATE TABLE "scc2-edgecfd".oedgecfdsolver1 AS
  SELECT solver.* FROM "scc2-edgecfd".oedgecfdsolver AS solver INNER JOIN "scc2-edgecfd".dl_solver1 AS dlsolver ON solver.dl_solverid=dlsolver.rid;

--fragmentação vertical
CREATE TABLE "scc2-edgecfd".osetsolverconfig2
(
  ewkfid integer NOT NULL,
  key integer NOT NULL DEFAULT nextval(('scc2-edgecfd.osetsolverconfig_seq'::text)::regclass),
  previousactid integer,
  nextactid integer,
  mid double precision,
  mesh character varying(250),
  processes double precision,
  dl_preid integer,
  ninn character varying(250),
  nmat character varying(250)
);


INSERT INTO "scc2-edgecfd".osetsolverconfig2
SELECT ewkfid, key, previousactid, nextactid, mid, mesh, processes, dl_preid, ninn, nmat FROM "scc2-edgecfd".osetsolverconfig;

-- dl_solver_1 alter table
ALTER TABLE "scc2-edgecfd".dl_solver1
ADD CONSTRAINT dl_solver1_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_solver1
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_solver1
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
      
-- oedgecfdsolver_1 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdsolver1
ADD CONSTRAINT oedgecfdsolver1_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdsolver1
ADD CONSTRAINT dl_solveridfk FOREIGN KEY (dl_solverid)
      REFERENCES "scc2-edgecfd".dl_solver1 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdsolver1
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdsolver1
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;
