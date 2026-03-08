CREATE VIEW vw_ranking_vendedores AS
SELECT
    vendedor_id,
    vendedor,
    faturamento,
    mes,
    RANK() OVER (PARTITION BY mes ORDER BY faturamento DESC) AS rank
FROM vw_faturamento_mensal_vendedores;