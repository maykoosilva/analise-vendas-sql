CREATE OR REPLACE VIEW vw_faturamento_mensal_vendedores AS( 
 SELECT ven.vendedor_id,
    ven.nome AS vendedor,
    sum(v.valor_total) AS faturamento,
    date_trunc('month'::text, v.data_venda::timestamp with time zone) AS mes
   FROM vendedores ven
     JOIN vendas v ON v.vendedor_id = ven.vendedor_id
  GROUP BY ven.vendedor_id, ven.nome, (date_trunc('month'::text, v.data_venda::timestamp with time zone)))