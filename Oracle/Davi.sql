-- Cria��o das tabelas

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

-- Cria��o das restri��es de Chave Prim�ria


alter table tb_editora add constraint pk_editora primary key (id_editora);

alter table tb_livro add constraint pk_livro primary key (id_livro);

alter table tb_Autor add constraint pk_autor primary key (id_autor);

alter table tb_livro_Autor add constraint pk_livro_autor primary key (id_livro_autor);

alter table tb_Funcionario add constraint pk_Funcionario primary key (id_Funcionario);

alter table tb_Func_Arq_Morto add constraint pk_Func_Arq_Morto primary key (id_Func_Arq_Morto);

alter table tb_Lotacao add constraint pk_Lotacao primary key (ID_Lotacao);

-- Cria��o das restri��es de Chave Estrangeira

alter table tb_livro add constraint fk_livro_editora foreign key (id_editora) references tb_editora(id_editora);

alter table tb_livro_Autor add constraint fk_livro_autor_livro foreign key (id_livro) references tb_livro(id_livro);

alter table tb_livro_Autor add constraint fk_livro_autor_autor foreign key (id_autor) references tb_autor(id_autor);

alter table tb_Lotacao add constraint fk_Lotacao_Lotacao foreign key (ID_Lotacao_Pai) references tb_Lotacao(ID_Lotacao);

-- Cria��o das restri��es de CHECK

alter table tb_Autor add constraint ck_sexo CHECK (Sexo in ('M','F'));


-- Cria��o das sequencias (Auto-Incremento)

create sequence sq_editora;
create sequence sq_livro;
create sequence sq_autor;
create sequence sq_livro_autor;
create sequence sq_funcionario;
create sequence sq_func_arq_morto;

-- Povoamento das tabelas do schema
ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';
-- Inser��es em tb_editora
insert into tb_editora values (sq_editora.nextval,'Campus', 'Rua do Timb�');
insert into tb_editora values (sq_editora.nextval,'Abril', null);
insert into tb_editora values (sq_editora.nextval,'Editora Teste',null);

-- Inser��es em tb_autor
insert into tb_autor values (sq_autor.nextval,'Jo�o','M','01.01.1970');
insert into tb_autor values (sq_autor.nextval,'Maria','F','17.05.1974');
insert into tb_autor values (sq_autor.nextval,'Jos�','M','20.10.1976');

-- Inser��es em tb_livro
insert into tb_livro values (sq_livro.nextval,'1234567890','Banco de Dados',2, 120.00,1);
insert into tb_livro values (sq_livro.nextval,'2345678901','Redes de Computadores',1, 110.00,2);
insert into tb_livro values (sq_livro.nextval,'3456789012','Interface Homem-M�quina',3, 90.00,1);


-- Inser��es em tb_Livro_Autor
insert into tb_Livro_Autor values (sq_livro_autor.nextval,1,1); 
insert into tb_Livro_Autor values (sq_livro_autor.nextval,1,2);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,2,3);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,3,2);
insert into tb_Livro_Autor values (sq_livro_autor.nextval,3,3);

-- Inser��es em tb_Funcionario
insert into tb_Funcionario values (sq_funcionario.nextval,'Jo�o','M');
insert into tb_Funcionario values (sq_funcionario.nextval,'Carla','F');
insert into tb_Funcionario values (sq_funcionario.nextval,'Osvaldo','M');


-- Inser��es em tb_Lotacao
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

-- Calcular a �rea do tri�ngulo e apresentar na tela
DECLARE
    vBase number;
    vAltura number;
    vArea number;
BEGIN
    -- vBase := 2;
    -- vAltura := 3;
    vArea := &vBase * &vAltura / 2;
    DBMS_OUTPUT.PUT_LINE('A �rea da figura �: ' || vArea);
END;

ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';

DECLARE
    vDataPedido Date := '01/04/2010';
    vDataEntrega Date;
    vDataAtual Date;
BEGIN
    DBMS_OUTPUT.PUt_LINE('A data do pedido �: ' || vDataPedido);
    vDataEntrega := vDataPedido + 2;
    DBMS_OUTPUT.PUT_LINE('A data da entrega �: ' ||  vDataEntrega);
    DBMS_OUTPUT.PUT_LINE('A data atual do servidor �: ' ||  sysdate);
    DBMS_OUTPUT.PUT_LINE('A data/hora atual do servidor �: ' ||  to_char(sysdate, 'dd-mm-yyyy hh24:mi:ss'));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias �: ' ||  (sysdate - vDataPedido));
    DBMS_OUTPUT.PUT_LINE('A quantidade de dias �: ' ||  floor(sysdate - vDataPedido));
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
        DBMS_OUTPUT.PUT_LINE('O tri�ngulo � equil�tero');
    ELSIF ( (vLado1 <> vLado2) AND ( vLado1 <> vLado3 ) AND ( vLado2 <> vLado3 ) ) THEN
        DBMS_OUTPUT.PUT_LINE('O tri�ngulo � escaleno');
    ELSE
        DBMS_OUTPUT.PUT_LINE('O tri�ngulo � is�sceles');
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
            DBMS_OUTPUT.PUT_LINE('Vi�vo');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Outros');
    END CASE;
END;

DECLARE
    vTentativa Binary_Integer := 0;
BEGIN
    LOOP
        vTentativa := vTentativa + 1;
        IF vTentativa > 3 THEN
            EXIT;
        END IF;
        DBMS_OUTPUT.PUT_LINE(vTentativa);
    END LOOP;
END;

DECLARE
    vTentativa Binary_Integer := 0;
BEGIN
    WHILE vTentativa < 5 LOOP
        DBMS_OUTPUT.PUT_LINE(vTentativa);
        vTentativa := vTentativa + 1;
    END LOOP;
END;

BEGIN
    FOR i IN 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

BEGIN
    FOR i IN REVERSE 1..3 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
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
    x number := 5;
    y number := null;
BEGIN
    -- Troca o valor de y para 0 caso ele seja null
    -- y := NVL(y, 0);
    IF x != y THEN
        DBMS_OUTPUT.PUT_LINE('x eh diferente de y');
    ELSIF x = y THEN
        DBMS_OUTPUT.PUT_LINE('x eh iagual a y');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Indefinido');
    END IF;
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
        
    DBMS_OUTPUT.PUT_LINE('O endere�o da Editora Campus �: ' || vROWID);
    
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
        
    DBMS_OUTPUT.PUT_LINE('O primeiro livro da Editora Campus �: ' || vTitulo);
    
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
        DBMS_OUTPUT.PUT_LINE('T�tulo e pre�o do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
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
        DBMS_OUTPUT.PUT_LINE('T�tulo e pre�o do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
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
            DBMS_OUTPUT.PUT_LINE('T�tulo e pre�o do livro: ' || vRegLivros.Titulo || ', ' || vRegLivros.Preco);
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
        DBMS_OUTPUT.PUT_LINE('T�tulo e pre�o do livro: ' || vTitulo || ', ' || vPreco);
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