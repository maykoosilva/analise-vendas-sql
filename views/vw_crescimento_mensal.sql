CREATE OR REPLACE VIEW vw_atingimento_metas AS( 
 SELECT fmv.vendedor_id,
    fmv.vendedor,
    fmv.mes,
    fmv.faturamento,
    m.valor_meta AS meta,
    round(fmv.faturamento / NULLIF(m.valor_meta::numeric, 0::numeric), 2) * 100::numeric AS percentual
   FROM vw_faturamento_mensal_vendedores fmv
     JOIN metas m ON m.vendedor_id = fmv.vendedor_id AND fmv.mes = m.mes )