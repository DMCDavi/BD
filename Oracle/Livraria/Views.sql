CREATE VIEW NOME_VIEW
AS
    SELECT
        E.DESCRICAO,
        COUNT(*) Acervo
    FROM 
        TB_EDITORA E
    JOIN
        TB_LIVRO L
    USING
        (ID_EDITORA)
    GROUP BY
        E.DESCRICAO;

SELECT * FROM NOME_VIEW
WHERE ACERVO >= 2
ORDER BY DESCRICAO;