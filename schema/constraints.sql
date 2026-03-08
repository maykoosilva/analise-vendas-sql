ALTER TABLE metas
ADD CONSTRAINT metas_pkey PRIMARY KEY (meta_id);

ALTER TABLE produtos
ADD CONSTRAINT produtos_pkey PRIMARY KEY (produto_id);

ALTER TABLE vendas
ADD CONSTRAINT vendas_pkey PRIMARY KEY (venda_id);

ALTER TABLE vendedores
ADD CONSTRAINT vendedores_pkey PRIMARY KEY (vendedor_id);

ALTER TABLE metas
ADD CONSTRAINT fk_meta_vendedor
FOREIGN KEY (vendedor_id)
REFERENCES vendedores(vendedor_id);

ALTER TABLE vendas
ADD CONSTRAINT fk_produto
FOREIGN KEY (produto_id)
REFERENCES produtos(produto_id);

ALTER TABLE vendas
ADD CONSTRAINT fk_vendedor
FOREIGN KEY (vendedor_id)
REFERENCES vendedores(vendedor_id);