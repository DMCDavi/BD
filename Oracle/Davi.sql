-- Criação das tabelas

create table tb_editora 
(
 ID_editora int not null,
 descricao varchar(30) not null,
 endereco varchar(70)
);

create table tb_livro
(
 ID_Livro int not null, 
 ISBN char(10) not null,
 Titulo varchar(50) not null,
 edicao smallint not null,
 Preco numeric (9,2) not null,
 ID_Editora int not null
);

create table tb_Autor 
(
 ID_Autor int not null, 
 nome varchar(50) not null,
 sexo char(01) not null,
 Data_Nascimento date not null
);

create table tb_Livro_Autor 
(
 ID_Livro_Autor int not null, 
 ID_Livro int not null,
 ID_Autor int not null
);


create table tb_funcionario 
(
 ID_Funcionario int not null, 
 nome varchar(50) not null,
 sexo char(01) not null
);
 
create table tb_func_arq_morto 
(
 ID_Func_Arq_Morto int not null, 
 nome varchar(50) not null
);

create table tb_Lotacao 
(
 ID_Lotacao int not null, 
 sigla varchar(30) not null,
 ID_Lotacao_Pai int
);

-- Criação das restrições de Chave Primária


alter table tb_editora add constraint pk_editora primary key (id_editora);

alter table tb_livro add constraint pk_livro primary key (id_livro);

alter table tb_Autor add constraint pk_autor primary key (id_autor);

alter table tb_livro_Autor add constraint pk_livro_autor primary key (id_livro_autor);

alter table tb_Funcionario add constraint pk_Funcionario primary key (id_Funcionario);

alter table tb_Func_Arq_Morto add constraint pk_Func_Arq_Morto primary key (id_Func_Arq_Morto);

alter table tb_Lotacao add constraint pk_Lotacao primary key (ID_Lotacao);

-- Criação das restrições de Chave Estrangeira

alter table tb_livro add constraint fk_livro_editora foreign key (id_editora) references tb_editora(id_editora);

alter table tb_livro_Autor add constraint fk_livro_autor_livro foreign key (id_livro) references tb_livro(id_livro);

alter table tb_livro_Autor add constraint fk_livro_autor_autor foreign key (id_autor) references tb_autor(id_autor);

alter table tb_Lotacao add constraint fk_Lotacao_Lotacao foreign key (ID_Lotacao_Pai) references tb_Lotacao(ID_Lotacao);

-- Criação das restrições de CHECK

alter table tb_Autor add constraint ck_sexo CHECK (Sexo in ('M','F'));


-- Criação das sequencias (Auto-Incremento)

create sequence sq_editora;
create sequence sq_livro;
create sequence sq_autor;
create sequence sq_livro_autor;
create sequence sq_funcionario;
create sequence sq_func_arq_morto;

-- Povoamento das tabelas do schema
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
-- Inserções em tb_editora
insert into tb_editora values (sq_editora.nextval,'Campus', 'Rua do Timbó');
insert into tb_editora values (sq_editora.nextval,'Abril', null);
insert into tb_editora values (sq_editora.nextval,'Editora Teste',null);

-- Inserções em tb_autor
insert into tb_autor values (sq_autor.nextval,'João','M','01.01.1970');
insert into tb_autor values (sq_autor.nextval,'Maria','F','17.05.1974');
insert into tb_autor values (sq_autor.nextval,'José','M','20.10.1976');

-- Inserções em tb_livro
insert into tb_livro values (sq_livro.nextval,'1234567890','Banco de Dados',2, 120.00,1);
insert into tb_livro values (sq_livro.nextval,'2345678901','Redes de Computadores',1, 110.00,2);
insert into tb_livro values (sq_livro.nextval,'3456789012','Interface Homem-Máquina',3, 90.00,1);


-- Inserções em tb_Livro_Autor
insert into tb_Livro_Autor values (sq_livro_autor.nextval,1,1); 
insert into tb_Livro_Autor values (sq_livro_autor.nextval,1,2);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,2,3);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,3,2);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,3,3);

-- Inserções em tb_Funcionario
insert into tb_Funcionario values (sq_funcionario.nextval,'João','M');
insert into tb_Funcionario values (sq_funcionario.nextval,'Carla','F');
insert into tb_Funcionario values (sq_funcionario.nextval,'Osvaldo','M');


-- Inserções em tb_Lotacao
insert into tb_Lotacao values (1,'PRODEB',null); 
insert into tb_Lotacao values (2,'DSS', 1);
insert into tb_Lotacao values (3,'DRA',1);
insert into tb_Lotacao values (4,'GSD', 2);
insert into tb_Lotacao values (5,'GSE', 3);
insert into tb_Lotacao values (6,'COADA',4);
insert into tb_Lotacao values (7,'COEX1',5);
  
commit;

SELECT * FROM USER_OBJECTS;

SELECT * FROM USER_OBJECTS WHERE OBJECT_TYPE = 'TABLE';

SELECT * FROM USER_TAB_COLUMNS;

SELECT * FROM
USER_OBJECTS,
USER_TAB_COLUMNS
WHERE TABLE_NAME = OBJECT_NAME
AND DATA_TYPE = 'NUMBER';

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

-- Calcular a área do triângulo e apresentar na tela
DECLARE
    vBase number;
    vAltura number;
    vArea number;
BEGIN
    -- vBase := 2;
    -- vAltura := 3;
    vArea := &vBase * &vAltura / 2;
    DBMS_OUTPUT.PUT_LINE('A área da figura é: ' || vArea);
END;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';

DECLARE
    vDataPedido Date := '01/04/2010';
    vDataEntrega Date;
    vDataAtual Date;
BEGIN
    DBMS_OUTPUT.PUt_LINE('A data do pedido é: ' || vDataPedido);
    vDataEntrega := vDataPedido + 2;
    DBMS_OUTPUT.PUT_LINE('A data da entrega é: ' ||  vDataEntrega);
    DBMS_OUTPUT.PUT_LINE('A data atual do servidor é: ' ||  sysdate);
    DBMS_OUTPUT.PUT_LINE('A data/hora atual do servidor é: ' ||  to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias é: ' ||  (sysdate - vDataPedido));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias é: ' ||  floor(sysdate - vDataPedido));
END;

DECLARE
    vLado1 number;
    vLado2 number;
    vLado3 number;
BEGIN
    vLado1 := 1;
    vLado2 := 3;
    vLado3 := 2;
    IF ( (vLado1 = vLado2) AND ( vLado1 = vLado3 ) ) THEN
        DBMS_OUTPUT.PUT_LINE('O triângulo é equilátero');
    ELSIF ( (vLado1 <> vLado2) AND ( vLado1 <> vLado3 ) AND ( vLado2 <> vLado3 ) ) THEN
        DBMS_OUTPUT.PUT_LINE('O triângulo é escaleno');
    ELSE
        DBMS_OUTPUT.PUT_LINE('O triângulo é isósceles');
    END IF;
END;

DECLARE
    vEstCivil char(01);
BEGIN
    vEstCivil := 'C';
    CASE vEstCivil
        WHEN 'S' THEN
            DBMS_OUTPUT.PUT_LINE('Solteiro');
        WHEN 'C' THEN
            DBMS_OUTPUT.PUT_LINE('Casado');
        WHEN 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Viúvo');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Outros');
    END CASE;
END;