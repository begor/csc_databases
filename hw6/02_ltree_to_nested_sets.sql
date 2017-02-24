DROP VIEW IF EXISTS Helper;

CREATE VIEW Helper AS
  SELECT K.id,
         K.value,
         nlevel(K.path) AS node_depth,
         ROW_NUMBER(*) OVER (ORDER BY K.path) AS dfs_order,
         COUNT(*) AS tree_size
  FROM KeywordLtree K,
       KeywordLtree KChild
  WHERE KChild.path <@ K.path
  GROUP BY K.id, K.value;
SELECT '#',
       id,
       value,
       1 + (dfs_order - 1) * 2 - node_depth as lft,
       (dfs_order + tree_size - 1) * 2 - node_depth as rgt
FROM Helper
ORDER BY lft;
