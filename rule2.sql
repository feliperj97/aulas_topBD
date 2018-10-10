drop table if exists aluno;
create table aluno(
matricula serial primary key,
nome varchar(50),
telefone varchar(15),
nota1 float,
nota2 float,
nota3 float,
nota4 float
);

drop table if exists log_aluno;
create table log_aluno(
id serial,
usuario varchar(15) default current_user,
data timestamp default current_timestamp,
nome varchar(50),
telefone varchar(15),
nota1 float,
nota2 float,
nota3 float,
nota4 float
);

insert into aluno(nome, telefone, nota1, nota2, nota3, nota4) values('Felipe', '3546372', 7.8, 6.5, 8.3, 7.6);
insert into aluno(nome, telefone, nota1, nota2, nota3, nota4) values('Maria', '3526152', 7.2, 5.5, 3.3, 9.6);
insert into aluno(nome, telefone, nota1, nota2, nota3, nota4) values('Julia', '25674845', 8.0, 6.8, 9.3, 7.6);

CREATE OR REPLACE RULE atualiza_log
AS ON UPDATE TO aluno
DO ALSO INSERT INTO log_aluno (nome, telefone, nota1, nota2, nota3, nota4) 
VALUES (new.nome, new.telefone, new.nota1, new.nota2, new.nota3, new.nota4);

UPDATE aluno
SET nota1 = 8.0
WHERE matricula = 1;

drop table if exists log_aluno_delete;
create table log_aluno_delete(
id serial,
usuario varchar(15) default current_user,
data timestamp default current_timestamp,
matricula int,
FOREIGN KEY (matricula) references aluno(matricula)
);


CREATE OR REPLACE RULE log_delete
AS ON DELETE TO aluno
DO INSTEAD INSERT INTO log_aluno_delete(matricula)
VALUES(old.matricula);

DELETE FROM aluno
WHERE matricula = 1;

SELECT * FROM log_aluno_delete;
select * from aluno;