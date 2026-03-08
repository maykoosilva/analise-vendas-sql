CREATE OR REPLACE VIEW vw_analise_performance_vendedores AS( 
 SELECT fmv.vendedor_id,
    fmv.vendedor,
    fmv.faturamento,
    am.meta,
    am.percentual AS atingimentos_metas,
    cm.crescimento,
    fmv.mes,
    sm.status
   FROM vw_faturamento_mensal_vendedores fmv
     JOIN vw_atingimento_metas am ON am.vendedor_id = fmv.vendedor_id AND am.mes = fmv.mes
     JOIN vw_crescimento_mensal cm ON cm.vendedor_id = fmv.vendedor_id AND cm.mes = fmv.mes
     JOIN vw_status_metas sm ON sm.vendedor_id = fmv.vendedor_id AND sm.mes = fmv.mes)