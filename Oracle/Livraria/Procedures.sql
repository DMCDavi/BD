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

-- Chama uma funcao dentro de uma procedure
CREATE OR REPLACE PROCEDURE SP_CALCULA_AREA2
AS vArea number;
BEGIN
    vArea := FC_CALCULA_AREA_RETANGULO(3);
    DBMS_OUTPUT.PUT_LINE('A area do retangulo eh: ' || vArea);
END;

EXEC SP_CALCULA_AREA2;

-- Da permissao para que o usuario crie uma tabela dentro de uma procedure
GRANT CREATE TABLE TO C##DAVI;

-- Cria uma nova tabela de acordo aos nomes das editoras
CREATE OR REPLACE PROCEDURE PR_DYNAMIC_SQL
AS
    vDescricao TB_EDITORA.DESCRICAO%TYPE;
    vComand VARCHAR2(32767);
    CURSOR cEditoras IS
    SELECT
        DESCRICAO
    FROM
        TB_EDITORA;
BEGIN
    vComand := 'CREATE TABLE NOVA_TABELA (';
    
    -- Preenche os atributos da tabela de acordo aos nomes das editoras
    OPEN cEditoras;
    LOOP
        FETCH cEditoras INTO vDescricao;
        EXIT WHEN cEditoras%NOTFOUND;
        
        -- Troca os espacos em branco com underline
        vDescricao := REPLACE (vDescricao, ' ', '_');
        -- Coloca o nome da editora como atributo
        vComand := CONCAT(vComand, vDescricao);
        -- Coloca o tipo do atributo
        vComand := CONCAT(vComand, ' INT,');
        
    END LOOP;
    CLOSE cEditoras;
    
    -- Retira a ultima virgula
    vComand := SUBSTR(vComand, 0, LENGTH(vComand) - 1);
    -- Finaliza o comando
    vComand := CONCAT(vComand, ')');
    
    -- Cria a tabela
    EXECUTE IMMEDIATE vComand;
END;

EXEC PR_DYNAMIC_SQL;