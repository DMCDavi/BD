DECLARE
    vReglivros TB_LIVRO%ROWTYPE;
CURSOR cLivros IS
    SELECT
        L.*
    FROM
        TB_LIVRO L
    JOIN 
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    WHERE
        UPPER(E.DESCRICAO) = 'CAMPUS';
BEGIN
    OPEN cLivros;
    LOOP
        FETCH cLivros INTO vReglivros;
        EXIT WHEN cLivros%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Titulo e preco do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
    END LOOP;
    CLOSE cLivros;
END;

DECLARE
    vReglivros TB_LIVRO%ROWTYPE;
CURSOR cLivros IS
    SELECT
        L.*
    FROM
        TB_LIVRO L
    JOIN 
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    WHERE
        UPPER(E.DESCRICAO) = 'CAMPUS';
BEGIN
    OPEN cLivros;
    LOOP
        FETCH cLivros INTO vReglivros;
        EXIT WHEN cLivros%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Titulo e preco do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
    END LOOP;
    CLOSE cLivros;
END;

DECLARE
    vDescEditora TB_EDITORA.DESCRICAO%TYPE;
CURSOR cLivros IS
    SELECT
        L.*
    FROM
        TB_LIVRO L
    JOIN 
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    WHERE
        UPPER(E.DESCRICAO) = vDescEditora;
BEGIN
    vDescEditora := 'CAMPUS';
    FOR vRegLivros IN cLivros
        LOOP
            DBMS_OUTPUT.PUT_LINE('Titulo e preco do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
        END LOOP;
END;

DECLARE
    vTitulo TB_LIVRO.TITULO%TYPE;
    vPreco TB_LIVRO.PRECO%TYPE;
CURSOR cLivros IS
    SELECT
        L.TITULO, L.PRECO
    FROM
        TB_LIVRO L
    JOIN 
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    WHERE
        UPPER(E.DESCRICAO) = 'CAMPUS';
BEGIN
    OPEN cLivros;
    LOOP
        FETCH cLivros INTO vTitulo, vPreco;
        EXIT WHEN cLivros%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Titulo e preco do livro: ' || vTitulo || ', ' || vPreco);
    END LOOP;
    CLOSE cLivros;
END;

DECLARE
    vPreco TB_LIVRO.PRECO%TYPE;
    vDescEditora TB_EDITORA.DESCRICAO%TYPE;
    vPrecReajuste number;
CURSOR cLivros IS
    SELECT
        L.PRECO, UPPER(E.DESCRICAO)
    FROM
        TB_LIVRO L
    JOIN 
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    -- Diz ao banco que a requisicao tera um update para realizar o bloqueio de concorrencia correto
    FOR UPDATE OF L.PRECO;
BEGIN
    OPEN cLivros;
    LOOP
        FETCH cLivros INTO vPreco, vDescEditora;
        EXIT WHEN cLivros%NOTFOUND;
        
        IF vDescEditora = 'CAMPUS' THEN
            vPrecReajuste := 5;
        ELSE
            vPrecReajuste := 10;
        END IF;
        
        UPDATE TB_LIVRO
        SET PRECO = PRECO + (PRECO * vPrecReajuste / 100)
        WHERE CURRENT OF cLivros;
        
    END LOOP;
    CLOSE cLivros;
END;