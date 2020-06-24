create database plugado;

use plugado;

CREATE TABLE tb_endereco (
    id_endereco INT AUTO_INCREMENT NOT NULL,
    estado VARCHAR(45),
    cidade VARCHAR(45),
    logradouro VARCHAR(100) NOT NULL,
    numero INT NOT NULL,
    cep VARCHAR(10),
    obs MEDIUMTEXT,
    PRIMARY KEY (id_endereco)
);

CREATE TABLE tb_cliente (
    id_cliente INT AUTO_INCREMENT NOT NULL,
    id_endereco INT NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(200) NOT NULL,
    email VARCHAR(256) NOT NULL,
    senha VARCHAR(30) NOT NULL,
    PRIMARY KEY (id_cliente),
    CONSTRAINT fk_endereco FOREIGN KEY (id_endereco)
        REFERENCES tb_endereco (id_endereco)
);

CREATE TABLE tb_telefone (
    id_telefone INT AUTO_INCREMENT NOT NULL,
    id_cliente INT NOT NULL,
    ddi VARCHAR(5) NOT NULL,
    ddd VARCHAR(5) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    PRIMARY KEY (id_telefone),
    CONSTRAINT fk_clienteTelefone FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente)
);

CREATE TABLE tb_produto (
    id_produto INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao MEDIUMTEXT,
    preco DECIMAL(6 , 2 ) UNSIGNED NOT NULL,
    estoque INT NOT NULL,
    PRIMARY KEY (id_produto)
);

CREATE TABLE tb_categoria (
    id_categoria INT AUTO_INCREMENT NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_categoria)
);

CREATE TABLE tb_categoria_produto (
    id_categoria_produto INT AUTO_INCREMENT NOT NULL,
    id_categoria INT NOT NULL,
    id_produto INT NOT NULL,
    PRIMARY KEY (id_categoria_produto),
    CONSTRAINT fk_categoria FOREIGN KEY (id_categoria)
        REFERENCES tb_categoria (id_categoria),
    CONSTRAINT fk_categoria_produto FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto)
);

CREATE TABLE tb_pedido (
    id_pedido INT AUTO_INCREMENT NOT NULL UNIQUE,
    id_cliente INT NOT NULL,
    PRIMARY KEY (id_pedido),
    CONSTRAINT fk_clientePedido FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente)
);

CREATE TABLE tb_status (
    id_status INT AUTO_INCREMENT NOT NULL UNIQUE,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_status)
);

CREATE TABLE tb_pedido_status (
    id_pedido_status INT AUTO_INCREMENT NOT NULL,
    id_status INT NOT NULL,
    id_pedido INT NOT NULL,
    data_hora DATETIME NOT NULL,
    PRIMARY KEY (id_pedido_status),
    CONSTRAINT fk_status FOREIGN KEY (id_status)
        REFERENCES tb_status (id_status),
    CONSTRAINT fk_pedido_status FOREIGN KEY (id_pedido)
        REFERENCES tb_pedido (id_pedido)
);

CREATE TABLE tb_pedido_produto (
    id_pedido_produto INT AUTO_INCREMENT NOT NULL,
    id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    quantidade INT NOT NULL,
    preco_total DECIMAL(6 , 2 ) UNSIGNED NOT NULL,
    PRIMARY KEY (id_pedido_produto),
    CONSTRAINT fk_pedido FOREIGN KEY (id_pedido)
        REFERENCES tb_pedido (id_pedido),
    CONSTRAINT fk_produto FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto)
);

CREATE TABLE tb_modelo (
    id_modelo INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_modelo)
);

CREATE TABLE tb_marca (
    id_marca INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_marca)
);

CREATE TABLE tb_roupa (
    id_roupa INT AUTO_INCREMENT NOT NULL,
    id_marca INT NOT NULL,
    id_modelo INT NOT NULL,
    PRIMARY KEY (id_roupa),
    CONSTRAINT fk_marca FOREIGN KEY (id_marca)
        REFERENCES tb_marca (id_marca),
    CONSTRAINT fk_modelo FOREIGN KEY (id_modelo)
        REFERENCES tb_modelo (id_modelo)
);

CREATE TABLE tb_tamanho (
    id_tamanho INT AUTO_INCREMENT NOT NULL,
    nome ENUM('PP', 'P', 'M', 'G', 'GG', 'XGG') NOT NULL,
    PRIMARY KEY (id_tamanho)
);

CREATE TABLE tb_cor (
    id_cor INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_cor)
);

CREATE TABLE tb_tamanho_cor (
    id_tamanho_cor INT AUTO_INCREMENT NOT NULL,
    id_tamanho INT NOT NULL,
    id_cor INT NOT NULL,
    PRIMARY KEY (id_tamanho_cor),
    CONSTRAINT fk_tamanho FOREIGN KEY (id_tamanho)
        REFERENCES tb_tamanho (id_tamanho),
    CONSTRAINT fk_cor_tamanho FOREIGN KEY (id_cor)
        REFERENCES tb_cor (id_cor)
);

CREATE TABLE tb_roupa_tamanho_cor (
    id_roupa_tamanho_cor INT AUTO_INCREMENT NOT NULL,
    id_roupa INT NOT NULL,
    id_tamanho_cor INT NOT NULL,
    id_produto INT NOT NULL,
    PRIMARY KEY (id_roupa_tamanho_cor),
    CONSTRAINT fk_roupa FOREIGN KEY (id_roupa)
        REFERENCES tb_roupa (id_roupa),
    CONSTRAINT fk_tamanho_cor FOREIGN KEY (id_tamanho_cor)
        REFERENCES tb_tamanho_cor (id_tamanho_cor),
    CONSTRAINT fk_produtoRoupaTamanhoCor FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto)
);

CREATE TABLE tb_evento (
    id_evento INT AUTO_INCREMENT NOT NULL,
    id_endereco INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao LONGTEXT,
    data_hora DATETIME NOT NULL,
    preco_entrada DECIMAL(6 , 2 ),
    PRIMARY KEY (id_evento),
    CONSTRAINT fk_enderecoEvento FOREIGN KEY (id_endereco)
        REFERENCES tb_endereco (id_endereco)
);

CREATE TABLE tb_cliente_evento (
    id_cliente_evento INT AUTO_INCREMENT NOT NULL,
    id_cliente INT NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (id_cliente_evento),
    CONSTRAINT fk_clienteEvento FOREIGN KEY (id_cliente)
        REFERENCES tb_cliente (id_cliente),
    CONSTRAINT fk_eventoCliente FOREIGN KEY (id_evento)
        REFERENCES tb_evento (id_evento)
);

CREATE TABLE tb_banda (
    id_banda INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_banda)
);

CREATE TABLE tb_evento_banda (
    id_evento_banda INT AUTO_INCREMENT NOT NULL,
    id_evento INT NOT NULL,
    id_banda INT NOT NULL,
    PRIMARY KEY (id_evento_banda),
    CONSTRAINT fk_eventoBanda FOREIGN KEY (id_evento)
        REFERENCES tb_evento (id_evento),
    CONSTRAINT fk_bandaEvento FOREIGN KEY (id_banda)
        REFERENCES tb_banda (id_banda)
);

CREATE TABLE tb_artista (
    id_artista INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    sobrenome VARCHAR(100),
    PRIMARY KEY (id_artista)
);

CREATE TABLE tb_banda_artista (
    id_banda_artista INT AUTO_INCREMENT NOT NULL,
    id_banda INT NOT NULL,
    id_artista INT NOT NULL,
    PRIMARY KEY (id_banda_artista),
    CONSTRAINT fk_bandaArtista FOREIGN KEY (id_banda)
        REFERENCES tb_banda (id_banda),
    CONSTRAINT fk_artistaBanda FOREIGN KEY (id_artista)
        REFERENCES tb_artista (id_artista)
);

CREATE TABLE tb_obra (
    id_obra INT AUTO_INCREMENT NOT NULL,
    titulo VARCHAR(100) NOT NULL,
    ano_lancamento YEAR,
    PRIMARY KEY (id_obra)
);

CREATE TABLE tb_banda_obra (
    id_banda_obra INT AUTO_INCREMENT NOT NULL,
    id_banda INT NOT NULL,
    id_obra INT NOT NULL,
    PRIMARY KEY (id_banda_obra),
    CONSTRAINT fk_bandaObra FOREIGN KEY (id_banda)
        REFERENCES tb_banda (id_banda),
    CONSTRAINT fk_obraBanda FOREIGN KEY (id_obra)
        REFERENCES tb_obra (id_obra)
);

CREATE TABLE tb_midia (
    id_midia INT AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_midia)
);

CREATE TABLE tb_obra_midia (
    id_obra_midia INT AUTO_INCREMENT NOT NULL,
    id_obra INT NOT NULL,
    id_midia INT NOT NULL,
    id_produto INT NOT NULL,
    PRIMARY KEY (id_obra_midia),
    CONSTRAINT fk_obra FOREIGN KEY (id_obra)
        REFERENCES tb_obra (id_obra),
    CONSTRAINT fk_midia FOREIGN KEY (id_midia)
        REFERENCES tb_midia (id_midia),
    CONSTRAINT fk_produtoObraMidia FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto)
);

CREATE TABLE tb_bebida (
    id_bebida INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_bebida)
);

CREATE TABLE tb_recipiente (
    id_recipiente INT AUTO_INCREMENT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_recipiente)
);

CREATE TABLE tb_recipiente_bebida (
    id_recipiente_bebida INT NOT NULL AUTO_INCREMENT,
    id_recipiente INT NOT NULL,
    id_bebida INT NOT NULL,
    id_produto INT NOT NULL,
    PRIMARY KEY (id_recipiente_bebida),
    CONSTRAINT fk_recipiente FOREIGN KEY (id_recipiente)
        REFERENCES tb_recipiente (id_recipiente),
    CONSTRAINT fk_bebida FOREIGN KEY (id_bebida)
        REFERENCES tb_bebida (id_bebida),
    CONSTRAINT fk_produtoRecipienteBebida FOREIGN KEY (id_produto)
        REFERENCES tb_produto (id_produto)
);