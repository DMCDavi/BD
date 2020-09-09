-- Calcular a area do triangulo e apresentar na tela
DECLARE
    vBase number;
    vAltura number;
    vArea number;
BEGIN
    -- vBase := 2;
    -- vAltura := 3;
    vArea := &vBase * &vAltura / 2;
    DBMS_OUTPUT.PUT_LINE('A area da figura eh: ' || vArea);
END;

DECLARE
    vDataPedido Date := '01/04/2010';
    vDataEntrega Date;
    vDataAtual Date;
BEGIN
    DBMS_OUTPUT.PUt_LINE('A data do pedido eh: ' || vDataPedido);
    vDataEntrega := vDataPedido + 2;
    DBMS_OUTPUT.PUT_LINE('A data da entrega eh: ' ||  vDataEntrega);
    DBMS_OUTPUT.PUT_LINE('A data atual do servidor eh: ' ||  sysdate);
    DBMS_OUTPUT.PUT_LINE('A data/hora atual do servidor eh: ' ||  to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias eh: ' ||  (sysdate - vDataPedido));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias eh: ' ||  floor(sysdate - vDataPedido));
END;

DECLARE
    -- Tipos para colunas de uma tabela
    vNome TB_AUTOR.Nome%TYPE;
    vSexo TB_AUTOR.Sexo%TYPE;
BEGIN
    SELECT
        NOME, SEXO
    INTO
        vNome, vSexo
    FROM
        TB_AUTOR
    WHERE
        ID_AUTOR = 1;
        
    DBMS_OUTPUT.PUT_LINE('Nome e sexo do autor: ' || vNome || ' - ' || vSexo);
        
END;

DECLARE
    -- Tipo para uma tupla
    vRegAutor TB_AUTOR%ROWTYPE;
BEGIN
    SELECT
        NOME, SEXO
    INTO
        vRegAutor.Nome, vRegAutor.Sexo
    FROM
        TB_AUTOR
    WHERE
        ID_AUTOR = 1;
        
    DBMS_OUTPUT.PUT_LINE('Nome e sexo do autor: ' || vRegAutor.Nome || ' - ' || vRegAutor.Sexo);
        
END;

DECLARE
    -- UROWID e ROWID sevem para referenciar a coluna id da tabela por�m traz maior desempenho
    vROWID UROWID;
    vTitulo tb_livro.titulo%TYPE;
BEGIN
    SELECT
        ROWID
    INTO
        vROWID
    FROM
        TB_EDITORA
    WHERE
        UPPER(DESCRICAO) = 'CAMPUS';
        
    DBMS_OUTPUT.PUT_LINE('O endereco da Editora Campus eh: ' || vROWID);
    
    SELECT
        L.Titulo
    INTO
        vTitulo
    FROM
        TB_LIVRO L
    JOIN
        TB_EDITORA E ON (L.ID_EDITORA = E.ID_EDITORA)
    WHERE
        E.ROWID = vROWID
    AND
        -- Mostra apenas a primeira tupla
        ROWNUM = 1;
        
    DBMS_OUTPUT.PUT_LINE('O primeiro livro da Editora Campus eh: ' || vTitulo);
    
END;