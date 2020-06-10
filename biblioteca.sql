CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE tb_editora (
    id_editora INT NOT NULL UNIQUE AUTO_INCREMENT,
    descricao VARCHAR(30) NOT NULL,
    endereco VARCHAR(50)
);

CREATE TABLE tb_livro (
    id_livro INT NOT NULL UNIQUE AUTO_INCREMENT,
    titulo VARCHAR(50) NOT NULL,
    preco NUMERIC(9 , 2 ) NOT NULL,
    id_editora INT NOT NULL
);

CREATE TABLE tb_autor (
    id_autor INT NOT NULL UNIQUE AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(01) NOT NULL,
    dt_nasc DATE NOT NULL
);

CREATE TABLE tb_autoria (
    id_autoria INT NOT NULL UNIQUE AUTO_INCREMENT,
    id_livro INT NOT NULL,
    id_autor INT NOT NULL
);

CREATE TABLE tb_funcionario (
    id_funcionario INT NOT NULL UNIQUE AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    sexo CHAR(01) NOT NULL
);

ALTER TABLE tb_editora ADD CONSTRAINT pk_editora PRIMARY KEY (id_editora);

ALTER TABLE tb_livro ADD CONSTRAINT pk_livro PRIMARY KEY (id_livro);

ALTER TABLE tb_autor ADD CONSTRAINT pk_autor PRIMARY KEY (id_autor);

ALTER TABLE tb_autoria ADD CONSTRAINT pk_autoria PRIMARY KEY (id_autoria);

ALTER TABLE tb_funcionario ADD CONSTRAINT pk_funcionario PRIMARY KEY (id_funcionario);

ALTER TABLE tb_livro ADD CONSTRAINT fk_livro_editora FOREIGN KEY (id_editora) REFERENCES tb_editora(id_Editora);

ALTER TABLE tb_autoria ADD CONSTRAINT fk_autoria_livro FOREIGN KEY (id_livro) REFERENCES tb_livro(id_livro);

ALTER TABLE tb_autoria ADD CONSTRAINT fk_autoria_autor FOREIGN KEY (id_autor) REFERENCES tb_autor(id_autor);

ALTER TABLE tb_autor ADD constraint ck_sexo_autor check (sexo IN ('F', 'M'));

ALTER TABLE tb_funcionario ADD constraint ck_sexo_funcionario check (sexo IN ('F', 'M'));

INSERT INTO tb_editora (descricao, endereco) VALUES ('Campus', 'Rua do Timbó'),('Abril', NULL),('Globo', NULL),('Teste', NULL);

SELECT 
    *
FROM
    tb_editora;

INSERT INTO tb_livro (titulo, preco, id_editora) VALUES ('Banco de dados', 100.0, 1), ('SGBD', 120.00, 2), ('Redes de computadores', 90.00, 2), ('Binco de dados', 10.0, 1);

SELECT 
    *
FROM
    tb_livro;

INSERT INTO tb_autor (nome, sexo, dt_nasc) VALUES ('João', 'M', '1970-01-01'), ('Maria', 'F', '1974-05-17'), ('José', 'M', '1977-10-10'), ('Carla', 'F', '1964-12-08');

SELECT 
    *
FROM
    tb_autor;

INSERT INTO tb_autoria (id_livro, id_autor) VALUES (1,1), (1,2), (2,2), (2,4), (3,3);

SELECT 
    *
FROM
    tb_autoria;
    
INSERT INTO tb_funcionario (nome, sexo) VALUES ('João', 'M'), ('Carla', 'F'), ('Osvaldo', 'M');

SELECT 
    *
FROM
    tb_funcionario;

-- Desabilita o safe update
SET SQL_SAFE_UPDATES = 0;

-- Atualizar o endereço da Editora Campus para ‘Av. ACM’
UPDATE tb_editora 
SET 
    endereco = 'AV. ACM'
WHERE
    UPPER(descricao) = 'CAMPUS';
    
SELECT 
    *
FROM
    tb_editora;

-- Atualizar os preços dos livros em 10%
UPDATE tb_livro 
SET 
    preco = preco * 1.10
WHERE
    id_livro > 0;

SELECT 
    *
FROM
    tb_livro;

-- Excluir o endereço da editora Campus
UPDATE tb_editora 
SET 
    endereco = NULL
WHERE
    UPPER(descricao) = 'CAMPUS';
    
SELECT 
    *
FROM
    tb_editora;

-- Excluir a editora Teste
DELETE FROM tb_editora 
WHERE
    UPPER(descricao) = 'TESTE';

SELECT 
    *
FROM
    tb_editora;

-- Apresentar o nome e data de nascimento de todos os autores
SELECT 
    nome, dt_nasc
FROM
    tb_autor;

-- Apresentar o nome e a data de nascimento dos autores do sexo feminino ordenados pelo nome.
SELECT 
    nome, dt_nasc
FROM
    tb_autor
WHERE
    sexo = 'F'
ORDER BY nome;

-- Apresentar o nome das editoras que não tem o endereço cadastrado.
SELECT 
    descricao
FROM
    tb_editora
WHERE
    endereco IS NULL;

-- Apresentar o título do livro e o nome da sua editora
SELECT 
    titulo, descricao
FROM
    tb_livro,
    tb_editora
WHERE
    tb_livro.id_editora = tb_editora.id_editora;

-- Outra maneira de fazer a consulta anterior
SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro,
    tb_editora AS editora
WHERE
    livro.id_editora = editora.id_editora;

-- Outra maneira de fazer a consulta anterior
SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro
        JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;

-- Apresentar os nomes das editoras sem repetição
SELECT DISTINCT
    editora.descricao
FROM
    tb_livro AS livro
        JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;

-- Apresentar o título do livro e o nome da sua editora. Caso haja alguma editora sem livro publicado, informar os dados da editora com valores nulos para os livros.
SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro
        RIGHT JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;

-- Apresentar o título do livro e o nome dos seus autores
SELECT 
    livro.titulo, autor.nome
FROM
    tb_livro AS livro
        JOIN
    tb_autoria AS autoria ON livro.id_livro = autoria.id_livro
        JOIN
    tb_autor AS autor ON autor.id_autor = autoria.id_autor;

-- Apresentar o nome da editora e o nome dos autores que já publicaram algum livro na editora.
SELECT 
    editora.descricao, autor.nome
FROM
    tb_livro AS livro
        JOIN
    tb_autoria AS autoria ON livro.id_livro = autoria.id_livro
        JOIN
    tb_autor AS autor ON autor.id_autor = autoria.id_autor
        JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;

-- Apresentar o título dos livros que começam a string ‘Banco’ ou 'Binco'.
SELECT 
    titulo
FROM
    tb_livro
WHERE
    UPPER(titulo) LIKE 'B_NCO%';

-- Apresentar o título dos livros que tem a string ‘do’.
SELECT 
    titulo
FROM
    tb_livro
WHERE
    UPPER(titulo) LIKE '%DO%';

-- Apresentar o nome de cada livro e seu preço reajustado em 5%
SELECT 
    titulo, preco, preco * 1.05 AS preco_reajustado
FROM
    tb_livro;

-- Apresentar o nome dos autores que nasceram no mês de outubro
SELECT 
    nome
FROM
    tb_autor
WHERE
    MONTH(dt_nasc) = 10;

-- Apresentar o número de livros do acervo
-- Apresentar o somatório dos preços dos livros do acervo
-- Apresentar o maior preço dentre todos os livros do acervo.
SELECT 
    COUNT(*) AS quantidade_livros,
    SUM(preco) AS soma_precos,
    MAX(preco) AS maior_preco
FROM
    tb_livro;

-- Apresentar o número de autores do livro ‘Banco de Dados’
SELECT 
    COUNT(*) AS qntd_autores_BD
FROM
    tb_autor
        INNER JOIN
    tb_autoria USING (id_autor)
        INNER JOIN
    tb_livro USING (id_livro)
WHERE
    UPPER(tb_livro.titulo = 'BANCO DE DADOS');

-- Apresentar a média de preços dos livros da editora Campus
SELECT 
    AVG(preco) AS media_precos
FROM
    tb_livro
        INNER JOIN
    tb_editora USING (id_editora)
WHERE
    UPPER(tb_editora.descricao) = 'CAMPUS';

-- Apresentar a data de nascimento do autor mais velho
SELECT 
    MIN(dt_nasc) AS menor_dt_nasc
FROM
    tb_autor;

-- Apresentar o número de livros por editora  
SELECT 
    COUNT(*) AS qntd_livros, e.descricao
FROM
    tb_livro AS l
        JOIN
    tb_editora AS e ON e.id_editora = l.id_editora
GROUP BY e.descricao;

-- Apresentar o somatório e média de preço dos livros por editora    
SELECT 
    e.descricao,
    SUM(preco) AS soma_precos,
    AVG(preco) AS media_precos
FROM
    tb_livro AS l
        JOIN
    tb_editora AS e ON e.id_editora = l.id_editora
GROUP BY e.descricao;

-- Apresentar o número de autores por livro, mas apenas dos livros que possuem mais de 1 autor
SELECT 
    COUNT(*) AS qntd_autores, l.titulo
FROM
    tb_autoria AS a
        INNER JOIN
    tb_livro AS l ON a.id_livro = l.id_livro
GROUP BY l.titulo
HAVING qntd_autores > 1
ORDER BY l.titulo;

-- Apresentar a média de preços geral por editora, mas apenas as editoras que possuem média menor que R$ 120,00 
SELECT 
    AVG(preco) AS media_precos
FROM
    tb_editora AS e
        INNER JOIN
    tb_livro AS l USING (id_editora)
GROUP BY e.descricao
HAVING (media_precos) < 120;

-- Apresentar o título e o preço dos livros que são mais baratos que a média de todos os preços do acervo
SELECT 
    titulo, preco
FROM
    tb_livro
WHERE
    preco < (SELECT 
            AVG(preco)
        FROM
            tb_livro);

-- Apresentar o nome, sexo e tipo de todos os autores e funcionários
SELECT 
    nome, sexo, 'Autor' AS tipo
FROM
    tb_autor 
UNION SELECT 
    nome, sexo, 'Funcionário' AS tipo
FROM
    tb_funcionario
ORDER BY 3 , 2;

-- Apresentar o nome dos autores que são funcionários da editora
SELECT 
    a.nome
FROM
    tb_autor AS a
        INNER JOIN
    tb_funcionario AS f ON a.nome = f.nome;

-- Outra maneira de fazer a consulta anterior
SELECT 
    nome
FROM
    tb_autor
WHERE
    nome IN (SELECT 
            a.nome
        FROM
            tb_autor AS a
                INNER JOIN
            tb_funcionario AS f ON a.nome = f.nome);

-- Outra maneira de fazer a consulta anterior
SELECT 
    nome
FROM
    tb_autor AS a
WHERE
    EXISTS( SELECT 
            1
        FROM
            tb_funcionario AS f
        WHERE
            a.nome = f.nome);

/*
-- Outra maneira de fazer a consulta anterior no ORACLE
SELECT nome FROM tb_autor
INTERSECT
SELECT nome FROM tb_funcionario;
*/

-- Outra maneira de fazer a consulta anterior
SELECT 
    a.nome
FROM
    tb_autor AS a
        LEFT JOIN
    tb_funcionario AS f USING (nome)
WHERE
    f.nome IS NULL;

-- Outra maneira de fazer a consulta anterior
SELECT 
    nome
FROM
    tb_autor
WHERE
    nome NOT IN (SELECT 
            a.nome
        FROM
            tb_autor AS a
                INNER JOIN
            tb_funcionario AS f ON a.nome = f.nome);

/*
-- Outra maneira de fazer a consulta anterior no ORACLE
SELECT nome FROM tb_autor
MINUS
SELECT nome FROM tb_funcionario;
*/
            
-- Apresentar o nome dos autores que não são autores do livro Banco de Dados
SELECT 
    nome
FROM
    tb_autor
WHERE
    nome NOT IN (SELECT 
            autor.nome
        FROM
            tb_livro AS livro
                JOIN
            tb_autoria AS autoria ON livro.id_livro = autoria.id_livro
                JOIN
            tb_autor AS autor ON autor.id_autor = autoria.id_autor
        WHERE
            UPPER(livro.titulo) = 'BANCO DE DADOS');
            
-- Apresentar a quantidade de livros da editora Campus e Abril em colunas diferentes.
SELECT 
    campus, abril
FROM
    (SELECT 
        COUNT(*) AS campus
    FROM
        tb_livro
    INNER JOIN tb_editora USING (id_editora)
    WHERE
        UPPER(tb_editora.descricao) = 'CAMPUS') tb_campus,
    (SELECT 
        COUNT(*) AS abril
    FROM
        tb_livro
    INNER JOIN tb_editora USING (id_editora)
    WHERE
        UPPER(tb_editora.descricao) = 'ABRIL') tb_abril;