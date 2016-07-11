CREATE TABLE "scc2-edgecfd".dl_mat1 AS
  SELECT * FROM "scc2-edgecfd".dl_mat WHERE visc < 0.0002;

CREATE TABLE "scc2-edgecfd".dl_mat3 AS
  SELECT * FROM "scc2-edgecfd".dl_mat WHERE visc > 0.0006 AND visc <= 0.0008;

CREATE TABLE "scc2-edgecfd".oedgecfdpre1 AS
  SELECT dlmat.visc,mat.* FROM "scc2-edgecfd".oedgecfdpre AS mat INNER JOIN "scc2-edgecfd".dl_mat1 AS dlmat ON mat.dl_matid=dlmat.rid;

CREATE TABLE "scc2-edgecfd".oedgecfdpre3 AS
  SELECT dlmat.visc,mat.* FROM "scc2-edgecfd".oedgecfdpre AS mat INNER JOIN "scc2-edgecfd".dl_mat3 AS dlmat ON mat.dl_matid=dlmat.rid;

--fragmentação vertical
CREATE TABLE "scc2-edgecfd".osetsolverconfig1
(
  key integer NOT NULL DEFAULT nextval(('scc2-edgecfd.osetsolverconfig_seq'::text)::regclass),
  previoustaskid integer,
  nexttaskid integer,
  dat character varying(250)
);

INSERT INTO "scc2-edgecfd".osetsolverconfig1
SELECT key, previoustaskid, nexttaskid, dat FROM "scc2-edgecfd".osetsolverconfig;


-- dl_mat1 alter table
ALTER TABLE "scc2-edgecfd".dl_mat1
ADD CONSTRAINT dl_mat1_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_mat1
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_mat1
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE "scc2-edgecfd".dl_solver2 AS
  SELECT * FROM "scc2-edgecfd".dl_solver WHERE velocity_0 > 0.35;

CREATE TABLE "scc2-edgecfd".oedgecfdsolver2 AS
  SELECT solver.* FROM "scc2-edgecfd".oedgecfdsolver AS solver INNER JOIN "scc2-edgecfd".dl_solver2 AS dlsolver ON solver.dl_solverid=dlsolver.rid;

-- oedgecfdpre1 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdpre1
ADD CONSTRAINT oedgecfdpre1_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdpre1
ADD CONSTRAINT dl_matid_fk FOREIGN KEY (dl_matid)
      REFERENCES "scc2-edgecfd".dl_mat1 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdpre1
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

-- dl_mat3 alter table
ALTER TABLE "scc2-edgecfd".dl_mat3
ADD CONSTRAINT dl_mat3_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_mat3
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_mat3
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

-- oedgecfdpre3 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdpre3
ADD CONSTRAINT oedgecfdpre3_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdpre3
ADD CONSTRAINT dl_matid_fk FOREIGN KEY (dl_matid)
      REFERENCES "scc2-edgecfd".dl_mat3 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdpre3
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

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

--criando índice
CREATE INDEX dl_mat1_key_index
  ON "scc2-edgecfd".dl_mat1
  USING btree
  (visc);

CREATE INDEX dl_mat3_key_index
  ON "scc2-edgecfd".dl_mat3
  USING btree
  (visc);