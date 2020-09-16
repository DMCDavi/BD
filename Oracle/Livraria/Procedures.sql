CREATE OR REPLACE PROCEDURE SP_TESTE
(
    -- Parametros in sao apenas para leitura 
    pParam1 in number,
    -- Parametros in out servem como se fossem ponteiros 
    pParam2 in out number,
    -- Parametros out servem como se fossem ponteiros mas chegam como null
    pParam3 out number
)
AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Valores dentro da procedure (1): ' || pParam1 || ' ' || pParam2 || ' ' || pParam3);
    -- Parametros do tipo in nao podem ser alterados dentro da procedure
    -- pParam1 := pParam1 * 1.5;
    pParam2 := pParam1 * 2;
    pParam3 := pParam1 * 3;
    DBMS_OUTPUT.PUT_LINE('Valores dentro da procedure (1): ' || pParam1 || ' ' || pParam2 || ' ' || pParam3);
END;


-- Executa a procedure dentro de um bloco anonimo
DECLARE
    vParam1 number := 100;
    vParam2 number := 100;
    vParam3 number := 100;
BEGIN
    SP_TESTE(vParam1, vParam2, vParam3);
    DBMS_OUTPUT.PUT_LINE('Valores fora da procedure: ' || vParam1 || ' ' || vParam2 || ' ' || vParam3);
END;

CREATE OR REPLACE PROCEDURE SP_CALCULA_AREA_RETANGULO
(
    -- Se nao colocar in ou out o default eh in
    pBase number,
    pAltura number,
    pArea out number
)
AS
BEGIN
    pArea := pBase * pAltura;
END;

-- Chama uma procedure dentro de outra
CREATE OR REPLACE PROCEDURE SP_CALCULA_AREA
AS vArea number;
BEGIN
    SP_CALCULA_AREA_RETANGULO(2,4,vArea);
    DBMS_OUTPUT.PUT_LINE('A area do retangulo eh: ' || vArea);
END;

-- Executa uma procedure fora de um bloco anonimo
EXEC SP_CALCULA_AREA;

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

-- Chama uma funcao dentro de uma procedure
CREATE OR REPLACE PROCEDURE SP_CALCULA_AREA2
AS vArea number;
BEGIN
    vArea := FC_CALCULA_AREA_RETANGULO(3);
    DBMS_OUTPUT.PUT_LINE('A area do retangulo eh: ' || vArea);
END;

EXEC SP_CALCULA_AREA2;

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