CREATE DATABASE escola;

USE escola;

CREATE TABLE aluno (
    id_aluno INT UNIQUE AUTO_INCREMENT NOT NULL,
    matricula INT NOT NULL,
    nome VARCHAR(40) NOT NULL,
    sexo ENUM('M', 'F') DEFAULT 'M',
    id_curso INT NOT NULL,
    PRIMARY KEY (id_aluno)
);

CREATE TABLE curso (
    id_curso INT UNIQUE NOT NULL,
    sigla VARCHAR(20) NOT NULL,
    turno VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_curso)
)
;

CREATE TABLE matriculado (
    id_matriculado INT UNIQUE AUTO_INCREMENT NOT NULL,
    ano INT NOT NULL,
    semestre INT NOT NULL,
    id_aluno INT NOT NULL,
    valor INT NOT NULL,
    PRIMARY KEY (id_matriculado)
)
;

alter table aluno add constraint fk_aluno_curso foreign key (id_curso) references curso (id_curso);

alter table matriculado add constraint fk_matriculado_aluno foreign key (id_aluno) references aluno (id_aluno);

insert into curso (id_curso, sigla, turno) values (10, 'SI', 'M'),(20, 'Adm', 'M'), (30, 'RI', 'N');

SELECT 
    *
FROM
    curso;

insert into aluno (matricula, nome, sexo, id_curso) values (123, 'João Sá', 'M', 20), ( 234, 'Maria Silva', 'F', 10), ( 236, 'Marcos Silva', 'M', 30), (153, 'Davi Costa', 'M', 20);

SELECT 
    *
FROM
    aluno;

insert into matriculado ( ano, semestre, id_aluno, valor) values ( 2019, 1, 1, 800), ( 2019, 1, 2, 750), ( 2019, 2, 1, 850), ( 2020, 1, 1, 800), ( 2019, 2, 2, 900), ( 2019, 2, 3, 400), ( 2020, 2, 4, 700);

SELECT 
    *
FROM
    matriculado;
 
-- LETRA A
SELECT 
    matricula, nome
FROM
    aluno
        INNER JOIN
    curso USING (id_curso)
WHERE
    sexo = 'F' AND sigla = 'SI'
ORDER BY nome;
 
-- LETRA B
SELECT 
    nome, valor
FROM
    aluno
        INNER JOIN
    matriculado USING (id_aluno)
WHERE
    UPPER(nome) LIKE '%SILVA%'
        AND ano = 2019
        AND semestre = 2
ORDER BY nome DESC;

-- LETRA C
SELECT 
    COUNT(sigla) AS qntd_matriculados, sigla
FROM
    aluno
        INNER JOIN
    curso USING (id_curso)
WHERE
    turno = 'M'
GROUP BY sigla
HAVING qntd_matriculados < 2;

-- LETRA D
SELECT 
    nome
FROM
    ALUNO
WHERE
    nome NOT IN (SELECT 
            nome
        FROM
            aluno
                INNER JOIN
            matriculado USING (id_aluno)
        WHERE
            ano = 2020 AND semestre = 1);