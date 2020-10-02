-- Criando uma funcao
CREATE OR REPLACE FUNCTION FC_CALCULA_AREA_RETANGULO
(
    vBase number,
    vAltura number default 4
)
RETURN NUMBER
AS vArea number;
BEGIN
    vArea := vBase * vAltura;
    RETURN vArea;
END;

-- Diferente de procedures, as funcoes podem ser chamadas com comandos SQL
SELECT FC_CALCULA_AREA_RETANGULO(2,5) FROM DUAL;

SELECT FC_CALCULA_AREA_RETANGULO(2) FROM DUAL;

-- Eleva o preco ao quadrado
CREATE OR REPLACE FUNCTION FC_PRECO_AO_QUADRADO
(
    pPreco number
)
RETURN number
AS
BEGIN
    RETURN pPreco**2;
END;

-- Chamando funcao com o campo de uma tabela
SELECT FC_PRECO_AO_QUADRADO(L.PRECO) FROM TB_LIVRO L;

-- Conta a quantidade de tuplas que uma tabela possui
CREATE OR REPLACE FUNCTION FC_CONTADOR_REGISTROS
(
    pTabela VARCHAR2
)
RETURN INTEGER
IS vRetorno INTEGER;
BEGIN
    -- Transforma uma string num comando
    EXECUTE IMMEDIATE
        'SELECT COUNT(*)
            FROM ' || pTabela
        INTO vRetorno;
    RETURN vRetorno;
END;

SELECT FC_CONTADOR_REGISTROS('TB_LIVRO_AUTOR') FROM DUAL;