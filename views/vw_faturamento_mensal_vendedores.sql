CREATE OR REPLACE VIEW vw_crescimento_mensal AS( 
 WITH calendario AS (
         SELECT generate_series('2026-01-01'::date::timestamp with time zone, '2026-03-01'::date::timestamp with time zone, '1 mon'::interval) AS datas
        ), base AS (
         SELECT v.vendedor_id,
            v.nome AS vendedor,
            c.datas AS mes
           FROM vendedores v
             CROSS JOIN calendario c
        ), faturamento_mensal AS (
         SELECT b.vendedor_id,
            b.vendedor,
            b.mes,
            COALESCE(fmv.faturamento, 0::numeric) AS faturamento
           FROM base b
             LEFT JOIN vw_faturamento_mensal_vendedores fmv ON fmv.vendedor_id = b.vendedor_id AND fmv.mes = b.mes
        ), faturamento_mensal_anterior AS (
         SELECT faturamento_mensal.vendedor_id,
            faturamento_mensal.vendedor,
            faturamento_mensal.mes,
            faturamento_mensal.faturamento,
            COALESCE(lag(faturamento_mensal.faturamento) OVER (PARTITION BY faturamento_mensal.vendedor_id ORDER BY faturamento_mensal.mes), 0::numeric) AS faturamento_anterior
           FROM faturamento_mensal
        )
 SELECT vendedor_id,
    vendedor,
    mes,
    faturamento,
    faturamento_anterior,
    round((faturamento - faturamento_anterior) * 100::numeric / NULLIF(faturamento_anterior, 0::numeric), 2) AS crescimento
   FROM faturamento_mensal_anterior)