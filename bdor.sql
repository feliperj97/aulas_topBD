-- Exercício 09-10 - BDOR

CREATE TABLE cliente(
id serial,
nome varchar(40),
sexo char(1),
cor varchar[]
);

INSERT INTO cliente (nome, sexo, cor) VALUES('Felipe', 'M', array['Azul', 'Verde', 'Amarelo']), ('Jorge', 'M', array['Vermelho', 'Preto', 'Branco']);

select nome, cor[1], cor[2], cor[3] from cliente;
