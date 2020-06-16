# -------------------------------------------------------
# CRIA O BANCO DE DADOS
create database loja;

# -------------------------------------------------------
# USA O BANCO DE DADOS
use loja;

# -------------------------------------------------------
# CRIA A TABELA DE PROFISSOES
CREATE TABLE profissoes (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) UNIQUE,
    PRIMARY KEY (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE PROFISSOES
insert into profissoes (nome) values 
	("Enfermagem"), 
	("Medicina"), 
	("Psicologia"), 
	("Nutrição"), 
	("Medicina Veterinária"), 
	("Odontologia"), 
	("Fisioterapia"), 
	("Farmácia");

# -------------------------------------------------------
# CRIA A TABELA DE ESTADOS
CREATE TABLE estados (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) UNIQUE,
    sigla VARCHAR(2) UNIQUE,
    PRIMARY KEY (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE ESTADOS
insert into estados (nome, sigla) values 
	("Bahia", "BA"), 
	("Distrito Federal", "DF"), 
    ("São Paulo", "SP"), 
    ("Rio de Janeiro", "RJ"), 
    ("Acre", "AC"), 
    ("Amazonas", "AM"), 
    ("Pernambuco", "PE"), 
    ("Rio Grande do Sul", "RS");

# -------------------------------------------------------
# CRIA A TABELA DE ENDERECO
CREATE TABLE endereco (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    id_estado INT UNSIGNED NOT NULL,
    rua VARCHAR(60) NOT NULL,
    numero INT NOT NULL,
    cep VARCHAR(10) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (id_estado)
        REFERENCES estados (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE ENDERECO
insert into endereco (id_estado, rua, numero, cep) values 
	("1", "Rua Câncer", "680", "69317-486"), 
	("2", "Rua Dicionarista Aurélio Buarque de Holanda", "7780", "67517-486"),  
    ("3", "Rua José Vernior", "80", "69317-478"),  
    ("4", "Rua Davi Marivaldo", "5360", "48517-486"), 
    ("5", "Rua do Poeta", "70", "78542-486");

# -------------------------------------------------------
# CRIA A TABELA DE CLIENTE
CREATE TABLE cliente (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    id_profissao INT UNSIGNED NOT NULL,
    id_endereco INT UNSIGNED NOT NULL,
    nome VARCHAR(60) NOT NULL,
    senha VARCHAR(60) NOT NULL,
    data_nascimento DATE NOT NULL,
    genero ENUM('M', 'F', 'I') DEFAULT 'I',
    email VARCHAR(60) NOT NULL UNIQUE,
    cpf VARCHAR(15) UNIQUE,
    status_cliente BOOL DEFAULT 1,
    PRIMARY KEY (id),
    FOREIGN KEY (id_profissao)
        REFERENCES profissoes (id),
    FOREIGN KEY (id_endereco)
        REFERENCES endereco (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE CLIENTE
insert into cliente 
(
	id_profissao, 
	id_endereco, 
	nome, 
	senha, 
	data_nascimento, 
	genero, 
	email, 
	cpf, 
	status_cliente
) values 
	("1", "1","Marivaldo", "680", "2001-11-25", 'M', "marivaldo@hotmail.com", "458.589.145-25", '0'), 
	("2", "2","Luciano", "7780", "1998-01-25", 'M', "luciano@hotmail.com", "856.589.456-25", '0'),  
    ("3", "3","Davi", "80", "1945-07-12", 'M', "davi@hotmail.com", "458.478.785-45", '0'),  
    ("4", "4","Maria", "5360", "1986-01-14", 'F', "maria@hotmail.com", "423.589.785-25", '1'), 
    ("5", "5","Fernanda", "70", "1999-11-15", 'F', "fernanda@hotmail.com", "456.589.789-65", '1');

# -------------------------------------------------------
# CRIA A TABELA DE TELEFONE
CREATE TABLE telefone (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    ddi VARCHAR(5),
    ddd VARCHAR(3),
    numero VARCHAR(10),
    PRIMARY KEY (id),
    FOREIGN KEY (id_cliente)
        REFERENCES cliente (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE TELEFONE
insert into telefone (id_cliente, ddi, ddd, numero) values 
	("1", "+55", "075", "69317-4869"), 
	("2", "+65", "071", "67517-4869"),  
    ("3", "+78", "079", "69317-4789"),  
    ("4", "+42", "011", "48517-4869"), 
    ("5", "+69", "013", "78542-4896");

# -------------------------------------------------------
# CRIA A TABELA DE PRODUTOS

CREATE TABLE produtos (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    nome VARCHAR(60) NOT NULL,
    tipo ENUM('Curso', 'Livro') NOT NULL,
    descricao TEXT,
    valor FLOAT NOT NULL,
    valor_promo FLOAT NOT NULL,
    quantidade INT UNSIGNED DEFAULT 0,
    em_promo BOOL DEFAULT 0,
    PRIMARY KEY (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE PRODUTOS
insert into produtos (nome, tipo, descricao, valor, valor_promo, quantidade, em_promo) values 
	("Harry Potter", "Livro", "Livro perfeito", 45.99, 39.99, 225, 1),
    ("Miseraveis", "Livro", "Livro perfeito", 415.99, 390.99, 274, 0),
    ("Coraline", "Livro", "Livro perfeito", 78.99, 59.99, 225, 1),
    ("JS", "Curso", "Curso perfeito", 1145.99, 1139.99, 258, 1),
    ("PHP", "Curso", "Curso perfeito", 4445.99, 3449.99, 225, 0);

# -------------------------------------------------------
# CRIA A TABELA DE PEDIDOS

CREATE TABLE pedidos (
    id INT UNSIGNED AUTO_INCREMENT NOT NULL,
    id_cliente INT UNSIGNED NOT NULL,
    id_produto INT UNSIGNED NOT NULL,
    status_pedido ENUM('Criado', 'Pago', 'Enviado', 'Finalizado', 'Abandonado') DEFAULT 'Criado',
    pagamento ENUM('Parcelado', 'À vista') NOT NULL,
    quantidade INT UNSIGNED DEFAULT 0,
    criado_em DATE,
    PRIMARY KEY (id)
);

# -------------------------------------------------------
# POPULA A TABELA DE PEDIDOS
insert into pedidos (id_cliente, id_produto, status_pedido, pagamento, quantidade, criado_em) values 
	(1, 1, "Criado","Parcelado", 5, "2020-03-28"),
    (2, 2, "Pago", "Parcelado", 6, "2020-03-28"),
    (3, 3, "Finalizado", "À vista", 7, "2020-03-28"),
    (4, 3, "Pago", "Parcelado", 20, "2019-05-28"),
    (4, 2, "Pago", "Parcelado", 2, "2019-05-28"),
    (3, 5, "Pago", "Parcelado", 12, "2018-05-28"),
    (2, 1, "Pago", "Parcelado", 5, "2019-04-28"),
    (1, 1, "Pago", "Parcelado", 63, "2018-01-28"),
    (5, 5, "Pago", "Parcelado", 5, "2018-05-28"),
    (1, 5, "Pago", "Parcelado", 58, "2019-05-28");

# -------------------------------------------------------
# MOSTRA TODAS AS TABELAS EXISTENTES NO BANCO
SHOW TABLES;

# -------------------------------------------------------
# RETORNA TODAS AS PROFISSÕES
SELECT 
    *
FROM
    profissoes;

# -------------------------------------------------------
# RETORNA TODAS AS PROFISSÕES QUE COMEÇAM COM A LETRA "M"
SELECT 
    *
FROM
    profissoes
WHERE
    nome LIKE 'm%';

# -------------------------------------------------------
# RETORNA TODAS AS PROFISSÕES QUE TERMINAM COM A LETRA "A"
SELECT 
    *
FROM
    profissoes
WHERE
    nome LIKE '%a';

# -------------------------------------------------------
# RETORNA TODAS AS PROFISSÕES QUE CONTEM "RI"
SELECT 
    *
FROM
    profissoes
WHERE
    nome LIKE '%ri%';

# -------------------------------------------------------
# RETORNA TODOS OS ESTADOS QUE A SIGLA COMECA COM A LETRA "R"
SELECT 
    *
FROM
    estados
WHERE
    sigla LIKE 'R%';

# -------------------------------------------------------
# RETORNA TODOS OS ESTADOS COM MAIS DE 12 CARACTERES
SELECT 
    *
FROM
    estados
WHERE
    LENGTH(nome) > 12;

# -------------------------------------------------------
# RETORNA TODOS OS DADOS DE TODOS OS CLIENTES DO SEXO FEMININO
SELECT 
    *
FROM
    (((cliente AS cli
    INNER JOIN endereco AS ende ON cli.id_endereco = ende.id)
    INNER JOIN estados AS est ON ende.id_estado = est.id)
    INNER JOIN telefone AS tel ON tel.id_cliente = cli.id)
        INNER JOIN
    profissoes AS pro ON cli.id_profissao = pro.id
WHERE
    genero = 'F';

# -------------------------------------------------------
# RETORNA TODOS OS DADOS DE TODOS OS CLIENTES DO SEXO MASCULINO
SELECT 
    *
FROM
    (((cliente AS cli
    INNER JOIN endereco AS ende ON cli.id_endereco = ende.id)
    INNER JOIN estados AS est ON ende.id_estado = est.id)
    INNER JOIN telefone AS tel ON tel.id_cliente = cli.id)
        INNER JOIN
    profissoes AS pro ON cli.id_profissao = pro.id
WHERE
    genero = 'M';

# -------------------------------------------------------
# RETORNA A QUANTIDADE CLIENTES DO SEXO MASCULINO
SELECT 
    COUNT(*) AS numero_clientes
FROM
    cliente
WHERE
    genero = 'M';

# -------------------------------------------------------
# RETORNA TODOS OS DADOS DE TODOS OS CLIENTE QUE MORAM NA BAHIA OU ACRE OU 
# QUE TRABALHAM NA AREA DE MEDICINA OU PSICOLOGIA
SELECT 
    *
FROM
    (((cliente AS cli
    INNER JOIN endereco AS ende ON cli.id_endereco = ende.id)
    INNER JOIN estados AS est ON ende.id_estado = est.id)
    INNER JOIN telefone AS tel ON tel.id_cliente = cli.id)
        INNER JOIN
    profissoes AS pro ON cli.id_profissao = pro.id
WHERE
    ende.id_estado IN (1 , 5)
        OR cli.id_profissao IN (2 , 3);

# -------------------------------------------------------
# SUBTRAI A QUANTIDADE DE PRODUTOS COM A QUANTIDADE DE PRODUTOS VENDIDOS EM CADA PEDIDO
SET SQL_SAFE_UPDATES = 0;
UPDATE produtos AS pro
        INNER JOIN
    pedidos AS ped ON pro.id = ped.id_produto
SET 
    pro.quantidade = pro.quantidade - ped.quantidade
WHERE
    status_pedido = 'Pago'
        OR status_pedido = 'Finalizado';

# -------------------------------------------------------
# RETORNA TODOS OS DADOS DO CLIENTE MAIS JOVEM
SELECT 
    *
FROM
    (((cliente AS cli
    INNER JOIN endereco AS ende ON cli.id_endereco = ende.id)
    INNER JOIN estados AS est ON ende.id_estado = est.id)
    INNER JOIN telefone AS tel ON tel.id_cliente = cli.id)
        INNER JOIN
    profissoes AS pro ON cli.id_profissao = pro.id
WHERE
    TIMESTAMPDIFF(DAY,
        cli.data_nascimento,
        CURDATE()) = TIMESTAMPDIFF(DAY,
        (SELECT 
                MAX(data_nascimento)
            FROM
                cliente),
        CURDATE());

# -------------------------------------------------------
# RETORNA TODOS OS DADOS DO CLIENTE MAIS VELHO
SELECT 
    *
FROM
    (((cliente AS cli
    INNER JOIN endereco AS ende ON cli.id_endereco = ende.id)
    INNER JOIN estados AS est ON ende.id_estado = est.id)
    INNER JOIN telefone AS tel ON tel.id_cliente = cli.id)
        INNER JOIN
    profissoes AS pro ON cli.id_profissao = pro.id
WHERE
    TIMESTAMPDIFF(DAY,
        cli.data_nascimento,
        CURDATE()) = TIMESTAMPDIFF(DAY,
        (SELECT 
                MIN(data_nascimento)
            FROM
                cliente),
        CURDATE());

# -------------------------------------------------------
# RETORNA OS DADOS DOS PRODUTOS E O VALOR TOTAL DOS PEDIDOS QUE JÁ FORAM PAGOS
SELECT 
    ped.id AS id_pedido,
    pro.id AS id_produto,
    nome,
    valor * ped.quantidade AS valor_pedido
FROM
    produtos AS pro
        INNER JOIN
    pedidos AS ped ON id_produto = pro.id
WHERE
    status_pedido = 'Pago';
    
# -------------------------------------------------------
# RETORNA OS DADOS DOS PEDIDOS, PRODUTOS E CLIENTES
SELECT 
    ped.id AS id_pedido,
    pro.id AS id_produto,
    cli.id AS id_cliente,
    pro.nome AS nome_produto,
    ped.quantidade AS quantidade_pedido
FROM
    pedidos AS ped
        INNER JOIN
    produtos AS pro ON id_produto = pro.id
        INNER JOIN
    cliente AS cli ON id_cliente = cli.id;
    
# -------------------------------------------------------
# RETORNA O PRODUTO MAIS VENDIDO DO MES DE MAIO E A QUANTIDADE DE VENDAS
SELECT 
    nome, SUM(ped.quantidade) AS qntd_vendidos
FROM
    pedidos AS ped
        INNER JOIN
    produtos AS pro ON id_produto = pro.id
WHERE
    MONTH(criado_em) = 5
GROUP BY id_produto
HAVING qntd_vendidos = (SELECT 
        MAX(qntd_vendidos) AS maior_venda
    FROM
        (SELECT 
            SUM(quantidade) AS qntd_vendidos
        FROM
            pedidos
        WHERE
            MONTH(criado_em) = 5
        GROUP BY id_produto) AS produtos_vendidos);
        
# -------------------------------------------------------
# RETORNA O PRODUTO MAIS VENDIDO DO PRIMEIRO TRIMESTRE DE 2019 E A QUANTIDADE DE VENDAS
SELECT 
    nome, SUM(ped.quantidade) AS qntd_vendidos
FROM
    pedidos AS ped
        INNER JOIN
    produtos AS pro ON id_produto = pro.id
WHERE
    MONTH(criado_em) >= 1 AND MONTH(criado_em) <= 4 AND YEAR(criado_em) = 2019
GROUP BY id_produto
HAVING qntd_vendidos = (SELECT 
        MAX(qntd_vendidos) AS maior_venda
    FROM
        (SELECT 
            SUM(quantidade) AS qntd_vendidos
        FROM
            pedidos
        WHERE
            MONTH(criado_em) >= 1 AND MONTH(criado_em) <= 4 AND YEAR(criado_em) = 2019
        GROUP BY id_produto) AS produtos_vendidos);
        
# -------------------------------------------------------
# RETORNA O PRODUTO MAIS VENDIDO DO PRIMEIRO TRIMESTRE DE 2019 E A QUANTIDADE DE VENDAS
SELECT 
    nome, SUM(ped.quantidade) AS qntd_vendidos
FROM
    pedidos AS ped
        INNER JOIN
    produtos AS pro ON id_produto = pro.id
WHERE
    YEAR(criado_em) = 2018
GROUP BY id_produto
HAVING qntd_vendidos = (SELECT 
        MAX(qntd_vendidos) AS maior_venda
    FROM
        (SELECT 
            SUM(quantidade) AS qntd_vendidos
        FROM
            pedidos
        WHERE
            YEAR(criado_em) = 2018
        GROUP BY id_produto) AS produtos_vendidos);
        
# -------------------------------------------------------
# RETORNA O CLIENTE QUE REALIZOU MAIS PEDIDOS
SELECT 
    nome, SUM(quantidade) AS qntd_vendidos
FROM
    pedidos AS ped
        INNER JOIN
    cliente AS cli ON id_cliente = cli.id
GROUP BY id_cliente
HAVING qntd_vendidos = (SELECT 
        MAX(qntd_vendidos) AS maior_venda
    FROM
        (SELECT 
            SUM(quantidade) AS qntd_vendidos
        FROM
            pedidos
        GROUP BY id_cliente) AS produtos_vendidos);
        
# -------------------------------------------------------
# 
SELECT 
    cli.nome, SUM(ped.quantidade) AS qntd_promo_comprados
FROM
    cliente AS cli
        INNER JOIN
    pedidos AS ped ON cli.id = id_cliente
        INNER JOIN
    produtos AS pro ON pro.id = id_produto
WHERE
    em_promo = 1
GROUP BY id_cliente
HAVING qntd_promo_comprados = (SELECT 
        MAX(qntd_promo_comprados) AS max_promo_comp
    FROM
        (SELECT 
            SUM(ped.quantidade) AS qntd_promo_comprados
        FROM
            cliente AS cli
        INNER JOIN pedidos AS ped ON cli.id = id_cliente
        INNER JOIN produtos AS pro ON pro.id = id_produto
        WHERE
            em_promo = 1
        GROUP BY cli.id) AS promo_comprados);