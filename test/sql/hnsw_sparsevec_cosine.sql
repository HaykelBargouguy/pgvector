SET enable_seqscan = off;

CREATE TABLE t (val sparsevec);
INSERT INTO t (val) VALUES ('{}'), ('{0:1,1:2,2:3}'), ('{0:1,1:1,2:1}'), (NULL);
CREATE INDEX ON t USING hnsw (val sparsevec_cosine_ops);

INSERT INTO t (val) VALUES ('{0:1,1:2,2:4}');

SELECT * FROM t ORDER BY val <=> '{0:3,1:3,2:3}';
SELECT COUNT(*) FROM (SELECT * FROM t ORDER BY val <=> '{}') t2;
SELECT COUNT(*) FROM (SELECT * FROM t ORDER BY val <=> (SELECT NULL::sparsevec)) t2;

DROP TABLE t;
