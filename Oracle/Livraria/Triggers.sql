CREATE OR REPLACE TRIGGER TR_MENOR_16_ANOS
BEFORE INSERT OR UPDATE
ON TB_AUTOR
FOR EACH ROW
DECLARE vIdade INT;
BEGIN
    vIdade := EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM :NEW.Data_Nascimento);
    IF (vIdade = 16) THEN
        IF (
            EXTRACT (MONTH FROM SYSDATE) >
            EXTRACT (MONTH FROM :NEW.Data_Nascimento)
        ) THEN
            vIdade := vIdade - 1;
        END IF;
    END IF;
        
        IF ( vIdade < 16 ) THEN
            RAISE_APPLICATION_ERROR(-20301, 'Autor nao pode ter menos de 16 anos');
        END IF;
END;

INSERT INTO TB_AUTOR VALUES (SQ_AUTOR.NEXTVAL, 'Mario', 'M', '10.10.2012');

-- Cria uma tupla na tabela log para registrar quem apagou a tupla da editora
CREATE OR REPLACE TRIGGER TB_LOG_EDITORA
BEFORE DELETE
ON TB_EDITORA
FOR EACH ROW
BEGIN
    INSERT INTO TB_LOG VALUES (SQ_LOG.NEXTVAL, USER, SYSDATE, :OLD.DESCRICAO) ;
END;

SELECT * FROM TB_LOG;
SELECT * FROM TB_EDITORA;

DELETE FROM TB_EDITORA WHERE ID_EDITORA = 3;

-- Nao permite que o preco de um livro seja reajustado em mais de 50%
CREATE OR REPLACE TRIGGER TB_LIMITE_REAJUSTE_LIVRO
BEFORE UPDATE
ON TB_LIVRO
FOR EACH ROW
BEGIN
    IF(:NEW.preco > :OLD.preco * 1.5) THEN
        RAISE_APPLICATION_ERROR(-20334, 'Reajuste nao permitido!!');
    END IF;
END;

-- Da baixa no estoque do livro ao criar um pedido
CREATE OR REPLACE TRIGGER TB_BAIXA_ESTOQUE
BEFORE INSERT
ON TB_ITENS_PEDIDO
FOR EACH ROW
DECLARE 
    estoque TB_LIVRO.QTDE_ESTOQUE%TYPE;
BEGIN
    SELECT 
        QTDE_ESTOQUE
    INTO
        estoque
    FROM 
        TB_LIVRO 
    WHERE 
        ID_LIVRO = :NEW.ID_LIVRO;
        
    IF(estoque - :NEW.QUANTIDADE < 0) THEN
        RAISE_APPLICATION_ERROR(-20334, 'A quantidade de livros do pedido ultrapassa a quantidade em estoque!!');
    ELSE
        UPDATE 
            TB_LIVRO
        SET
            QTDE_ESTOQUE = QTDE_ESTOQUE - :NEW.QUANTIDADE
        WHERE
            ID_LIVRO = :NEW.ID_LIVRO;
    END IF;
END;

INSERT INTO TB_ITENS_PEDIDO VALUES (SQ_ITENS_PEDIDO.NEXTVAL,1,1,1,100.00);

SELECT * FROM TB_LIVRO;

-- Nao permite pedidos que custam mais de 500 reais
CREATE OR REPLACE TRIGGER TB_LIMITE_PEDIDO
BEFORE INSERT OR UPDATE
ON TB_ITENS_PEDIDO
FOR EACH ROW
DECLARE valor NUMBER;
BEGIN

    SELECT 
        SUM(PRECO)
    INTO
        valor
    FROM 
        TB_ITENS_PEDIDO
    WHERE 
        ID_PEDIDO = :NEW.ID_PEDIDO;
        
    valor := valor + :NEW.PRECO;
    
    IF(valor > 500) THEN
        RAISE_APPLICATION_ERROR(-20334, 'O preco do pedido excede 500 reais!!');
    END IF;
    
END;

INSERT INTO TB_ITENS_PEDIDO VALUES (SQ_ITENS_PEDIDO.NEXTVAL,1,1,1,50.00);

-- Muda a data de entrega automaticamente para 5 dias após a data do pedido
CREATE OR REPLACE TRIGGER TR_DATA_ENTREGA
BEFORE INSERT
ON TB_PEDIDO
FOR EACH ROW
BEGIN
    :NEW.DATA_ENTREGA := :NEW.DATA_PEDIDO + 5;
END;

INSERT INTO TB_PEDIDO VALUES (SQ_PEDIDO.NEXTVAL, SYSDATE, SYSDATE);

SELECT * FROM TB_PEDIDO;

-- Registra comandos DDL
CREATE OR REPLACE TRIGGER TR_REGISTRO_DDL
AFTER DDL ON SCHEMA
DECLARE
    vOperacao VARCHAR2(50);
BEGIN
    vOperacao := 'DDL - ' || ORA_SYSEVENT ||
                      ' ' || ORA_DICT_OBJ_TYPE ||
                      ' ' || ORA_DICT_OBJ_NAME;
                      
    INSERT INTO TB_LOG VALUES (SQ_LOG.NEXTVAL, USER, SYSDATE, vOperacao);
END;

CREATE TABLE TESTE (ID INT NOT NULL);

SELECT * FROM TB_LOG;

DROP TABLE TESTE;

-- Registra login no banco de dados
CREATE OR REPLACE TRIGGER TR_REGISTRO_LOGON
AFTER LOGON ON DATABASE
DECLARE
    vOperacao VARCHAR2(50);
BEGIN
    vOperacao := 'LOGON - ' || SYS_CONTEXT('USERENV', 'HOST');    
    INSERT INTO TB_LOG VALUES (SQ_LOG.NEXTVAL, USER, SYSDATE, vOperacao);
END;