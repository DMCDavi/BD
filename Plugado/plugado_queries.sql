USE heroku_fe6fdcab2a93815;

-- Informa o nome, valor total e quantidade de produtos vendidos em 2015, ordenado em ordem crescente por quantidade de vendas e/ou valor total, mostrando apenas os que venderam abaixo de 4 ou que o preço do pedido foi abaixo de 400;
SELECT 
    tb_produto.nome,
    SUM(preco_total) AS valor_total,
    SUM(quantidade) AS quantidade_total
FROM
    tb_pedido
        INNER JOIN
    tb_pedido_produto USING (id_pedido)
        INNER JOIN
    tb_pedido_status USING (id_pedido)
        INNER JOIN
    tb_produto USING (id_produto)
WHERE
    YEAR(data_hora) = 2015
GROUP BY tb_produto.nome
HAVING preco_total < 400
    OR quantidade_total < 4
ORDER BY quantidade , valor_total;

-- Informa quais produtos não foram vendidos num determinado evento;
SELECT 
    nome, descricao, preco, estoque
FROM
    tb_produto
WHERE
    id_produto NOT IN (SELECT 
            id_produto
        FROM
            tb_pedido_status
                INNER JOIN
            tb_pedido_produto USING (id_pedido)
                INNER JOIN
            tb_status USING (id_status)
                INNER JOIN
            tb_produto USING (id_produto)
        WHERE
            tb_status.nome = 'Feito'
                AND MINUTE(data_hora) IN (MINUTE((SELECT 
                        data_hora
                    FROM
                        tb_evento
                    WHERE
                        id_evento = 3)) , MINUTE((SELECT 
                            data_hora_final
                        FROM
                            tb_evento
                        WHERE
                            id_evento = 3))))
GROUP BY id_produto;

-- Informa quem são os devedores e a quantia da dívida;
SELECT 
    C.nome, S.preco_total
FROM
    tb_pedido_produto AS S
        INNER JOIN
    tb_pedido AS P USING (id_pedido)
        INNER JOIN
    tb_cliente AS C USING (id_cliente)
WHERE
    P.id_pedido NOT IN (SELECT 
            T.id_pedido
        FROM
            tb_pedido_status AS T
                INNER JOIN
            tb_status AS S USING (id_status)
        WHERE
            S.nome = 'Pago');
            
-- Retorna todos os produtos disponíveis na loja
SELECT 
    nome, descricao, preco, estoque
FROM
    tb_produto
WHERE
    estoque >= 1;

-- Informa quantas pessoas confirmaram presença num determinado evento.
SELECT 
    COUNT(*)
FROM
    tb_cliente
        INNER JOIN
    tb_cliente_evento AS E USING (id_cliente)
WHERE
    id_evento = 2;

-- Informa quais pessoas confirmaram presença num determinado evento.
SELECT 
    nome
FROM
    tb_cliente
        INNER JOIN
    tb_cliente_evento USING (id_cliente)
WHERE
    id_evento = 2;
   
-- Informa se existem encomendas realizadas e seus respectivos status;
SELECT 
    P.id_pedido, S.nome
FROM
    tb_pedido_status AS P
        INNER JOIN
    tb_status AS S USING (id_status);
    
SELECT 
    MONTH(periodo) AS Mês,
    SUM(preco_unitario * quant_vendida) AS Tirante
FROM
    produto
        JOIN
    orcamento_produto USING (id_produto)
        JOIN
    despesa_orcamento_produto USING (id_orcamento_produto)
WHERE
    UPPER(tipo) = 'TIRANTE'
GROUP BY MONTH(periodo);