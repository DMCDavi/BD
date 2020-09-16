DECLARE
    vValor1 number := 100;
    vValor2 number := 0;
BEGIN
    vValor1 := vValor1 / vValor2;
    
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('Valor 2 nao poder ser zero');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro desconhecido');
END;

DECLARE
    vValor number;
BEGIN

    INSERT INTO tb_editora VALUES (sq_editora.NEXTVAL, 'teste2', 's/n');
    
    SELECT 
        preco
    INTO
        vValor
    FROM
        tb_livro
    WHERE
        id_livro = 100;
        
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Consulta n�o retornou nenhum registro');
        ROLLBACK;
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Consulta retornou mais de um registro');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro desconhecido');
        ROLLBACK;
END;

DECLARE
    vID_Autor int;
    vNome TB_AUTOR.Nome%TYPE;
    vSexo TB_AUTOR.Sexo%TYPE;
BEGIN
    vID_Autor := 100;
    
    -- Begin dentro de begin serve para separar trilhas de codigos distintos
    BEGIN
        SELECT
            NOME, SEXO
        INTO
            vNome, vSexo
        FROM
            TB_AUTOR
        WHERE
            ID_AUTOR = vID_Autor;
    
    -- Exception retornando null serve para continuar o codigo mesmo se uma parte der erro
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            NULL;
    END;
    
    DBMS_OUTPUT.PUT_LINE('Nome e sexo do autor: ' || vNome || ' - ' || vSexo);
    
END;

DECLARE
    vID_Autor int;
    vContador int;
    vNome TB_AUTOR.Nome%TYPE;
    vSexo TB_AUTOR.Sexo%TYPE;
BEGIN
    vID_Autor := 100;
    
    SELECT
        COUNT(*)
    INTO 
        vContador
    FROM
        tb_autor
    WHERE
        id_autor = vID_Autor;
    
    -- Utilizar o count para saber se existe o dado procurado eh uma boa alternativa para nao aparecer erros
    IF(vContador <> 0) THEN
        SELECT
            NOME, SEXO
        INTO
            vNome, vSexo
        FROM
            TB_AUTOR
        WHERE
            ID_AUTOR = vID_Autor;
    END IF;

    DBMS_OUTPUT.PUT_LINE('Nome e sexo do autor: ' || vNome || ' - ' || vSexo);
    
END;

DECLARE
    vCodigo number := 0;
    vErro varchar2(64);
    vData date := '01/01/2020';
    DATA_INVALIDA EXCEPTION;
BEGIN
    vCodigo := 100 / 0;
    
    -- Cria uma exception
    IF vData < SYSDATE THEN
        RAISE DATA_INVALIDA;
    END IF;
    
EXCEPTION
    WHEN DATA_INVALIDA THEN
        DBMS_OUTPUT.PUT_LINE('Data anterior a data do servidor');
    WHEN OTHERS THEN
        vCodigo := SQLCODE;
        vErro := SQLERRM;
        DBMS_OUTPUT.PUT_LINE('Erro: ' || vCodigo || ' : ' || vErro);
        
END;

-- Cria relatorio de erros
DECLARE
    vData date := '01/01/2020';
BEGIN
    IF vData < SYSDATE THEN
        RAISE_APPLICATION_ERROR(-20010, 'Data anterior a data do servidor');
    END IF;
END;