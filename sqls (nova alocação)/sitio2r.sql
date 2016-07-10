CREATE TABLE "scc2-edgecfd".dl_mat2 AS
  SELECT * FROM "scc2-edgecfd".dl_mat WHERE visc >= 0.0002 AND visc <= 0.0006;

CREATE TABLE "scc2-edgecfd".dl_mat4 AS
  SELECT * FROM "scc2-edgecfd".dl_mat WHERE visc > 0.0008;

CREATE TABLE "scc2-edgecfd".oedgecfdpre2 AS
  SELECT mat.* FROM "scc2-edgecfd".oedgecfdpre AS mat INNER JOIN "scc2-edgecfd".dl_mat2 AS dlmat ON mat.dl_matid=dlmat.rid;

CREATE TABLE "scc2-edgecfd".oedgecfdpre4 AS
  SELECT mat.* FROM "scc2-edgecfd".oedgecfdpre AS mat INNER JOIN "scc2-edgecfd".dl_mat4 AS dlmat ON mat.dl_matid=dlmat.rid;

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

CREATE TABLE "scc2-edgecfd".dl_solver2 AS
  SELECT * FROM "scc2-edgecfd".dl_solver WHERE velocity_0 > 0.35;

CREATE TABLE "scc2-edgecfd".oedgecfdsolver2 AS
  SELECT solver.* FROM "scc2-edgecfd".oedgecfdsolver AS solver INNER JOIN "scc2-edgecfd".dl_solver2 AS dlsolver ON solver.dl_solverid=dlsolver.rid;


-- dl_mat2 alter table
ALTER TABLE "scc2-edgecfd".dl_mat2
ADD CONSTRAINT dl_mat2_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_mat2
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_mat2
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

-- oedgecfdpre2 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdpre2
ADD CONSTRAINT oedgecfdpre2_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdpre2
ADD CONSTRAINT dl_matid_fk FOREIGN KEY (dl_matid)
      REFERENCES "scc2-edgecfd".dl_mat2 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdpre2
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

-- dl_mat4 alter table
ALTER TABLE "scc2-edgecfd".dl_mat4
ADD CONSTRAINT dl_mat4_pkey PRIMARY KEY (rid);

ALTER TABLE "scc2-edgecfd".dl_mat4
ADD CONSTRAINT ewkfid_fk FOREIGN KEY (ewkfid)
      REFERENCES public.eworkflow (ewkfid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".dl_mat4
ADD CONSTRAINT taskid_fk FOREIGN KEY (taskid)
      REFERENCES public.eactivation (taskid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

-- oedgecfdpre4 alter table
ALTER TABLE "scc2-edgecfd".oedgecfdpre4
ADD CONSTRAINT oedgecfdpre4_pkey PRIMARY KEY (key);

ALTER TABLE "scc2-edgecfd".oedgecfdpre4
ADD CONSTRAINT dl_matid_fk FOREIGN KEY (dl_matid)
      REFERENCES "scc2-edgecfd".dl_mat4 (rid) MATCH SIMPLE
      ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE "scc2-edgecfd".oedgecfdpre4
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
CREATE INDEX dl_mat2_key_index
  ON "scc2-edgecfd".dl_mat2
  USING btree
  (visc);

CREATE INDEX dl_mat4_key_index
  ON "scc2-edgecfd".dl_mat4
  USING btree
  (visc);