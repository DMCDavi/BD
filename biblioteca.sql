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
    
UPDATE tb_editora 
SET 
    endereco = 'AV. ACM'
WHERE
    id_editora = 2;
    
SELECT 
    *
FROM
    tb_editora;

UPDATE tb_livro 
SET 
    preco = preco * 1.10
WHERE
    id_livro > 0;

SELECT 
    *
FROM
    tb_livro;

SET SQL_SAFE_UPDATES = 0;

UPDATE tb_editora 
SET 
    endereco = NULL
WHERE
    descricao = 'Campus';
    
SELECT 
    *
FROM
    tb_editora;

DELETE FROM tb_editora 
WHERE
    descricao = 'Globo';

SELECT 
    *
FROM
    tb_editora;

SELECT 
    nome, dt_nasc
FROM
    tb_autor;

SELECT 
    nome, dt_nasc
FROM
    tb_autor
WHERE
    sexo = 'F'
ORDER BY nome;

SELECT 
    descricao
FROM
    tb_editora
WHERE
    endereco IS NULL;
    
SELECT 
    titulo, descricao
FROM
    tb_livro,
    tb_editora
WHERE
    tb_livro.id_editora = tb_editora.id_editora;
    
SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro,
    tb_editora AS editora
WHERE
    livro.id_editora = editora.id_editora;

SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro
        JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;

SELECT DISTINCT
    editora.descricao
FROM
    tb_livro AS livro
        JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;
    
SELECT 
    livro.titulo, editora.descricao
FROM
    tb_livro AS livro
        RIGHT JOIN
    tb_editora AS editora ON livro.id_editora = editora.id_editora;
    
SELECT 
    livro.titulo, autor.nome
FROM
    tb_livro AS livro
        JOIN
    tb_autoria AS autoria ON livro.id_livro = autoria.id_livro
        JOIN
    tb_autor AS autor ON autor.id_autor = autoria.id_autor;
    
SELECT 
    titulo
FROM
    tb_livro
WHERE
    UPPER(titulo) LIKE 'B_NCO%';

SELECT 
    titulo
FROM
    tb_livro
WHERE
    UPPER(titulo) LIKE '%DO%';
    
SELECT 
    titulo, preco, preco * 1.05 AS preco_reajustado
FROM
    tb_livro;
    
SELECT 
    COUNT(*) AS quantidade_livros,
    SUM(preco) AS soma_precos,
    AVG(preco) AS media_precos,
    MIN(preco) AS menor_preco,
    MAX(preco) AS maior_preco
FROM
    tb_livro;
    
SELECT 
    MIN(dt_nasc) AS menor_dt_nasc
FROM
    tb_autor;