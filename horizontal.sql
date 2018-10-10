--ESQUEMA CORRENTISTA  EXERCÍCIO02 FRAGMENTAÇÃO HORIZONTAL BY ANDERSON NASCIMENTO
--CORRENTISTA(CODCLI, NOME, SEXO, CIDADE, UF, AGENCIA, CONTA, SALDO)
--CRIANDO A TABELA



CREATE TABLE CORRENTISTA (
CODCLI SERIAL PRIMARY KEY,
NOME VARCHAR(20),
SEXO CHAR(1),
CIDADE CHAR(20),
UF CHAR(2),
AGENCIA CHAR(4),
CONTA CHAR(10),
SALDO DECIMAL (10,2));

--POPULAR TABELA

INSERT INTO CORRENTISTA (NOME, SEXO, CIDADE, UF, AGENCIA, CONTA, SALDO) 
     VALUES ('HUGO', 'M', 'DUQUE DE CAXIAS', 'RJ', '0001', '1234567890', 1000.30),
            ('JACK', 'M', 'DUQUE DE CAXIAS', 'RJ', '0001', '1234500890', 2000.30),
            ('ZELIA', 'F', 'SÃO PAULO', 'SP', '0001', '0000557890', 3050.30),
            ('PAULA', 'F', 'SÃO PAULO', 'SP', '0002', '0000547890', 0150.30),
            ('PAULO', 'F', 'SÃO PAULO', 'SP', '0002', '0001537890', 11150.30),
            ('BRUNA','F', 'RIO DE JANEIRO', 'RJ', '0001', '0000000021', 59000.000),
            ('ANDERSON', 'M','DUQUE DE CAXIAS', 'RJ', '0402', '0000000551', 01001.90),
            ('ANA', 'F','DUQUE DE CAXIAS', 'RJ', '0402', '0000000552', 11201.90),
            ('LUCIA', 'F', 'SÃO PAULO', 'SP', '0002', '0000067190', -0150.30),
            ('ZEFA', 'F', 'SÃO PAULO', 'SP', '0001', '0000067890', 1550.30),
            ('JOAFREI', 'M', 'SÃO PAULO', 'SP', '0002', '0000033890', 1050.90),
            ('BRUNA','F', 'RIO DE JANEIRO', 'RJ', '0001', '0000000021', 59000.000),
            ('LARISSA','F', 'RIO DE JANEIRO', 'RJ', '0001', '0000000022', 72000.000),
            ('LIA','F', 'RIO DE JANEIRO', 'RJ', '0001', '0000000021', 9000.000),
            ('MELISSA', 'F', 'DUQUE DE CAXIAS', 'RJ', '0001', '0000000090', 1200.30);

			
-- CREATE OR REPLACE RULE guardahistorico AS
--   ON UPDATE TO correntista
 --  WHERE old.saldo <> new.saldo DO  INSERT INTO historico (idcorrentista, saldo)
--  VALUES (old.codcli, old.saldo);

CREATE SCHEMA banco_rj;
CREATE SCHEMA banco_sp1;
CREATE SCHEMA banco_sp2;

-- criando fragmento RJ
CREATE TABLE banco_rj.cli_rj AS 
SELECT * FROM correntista
WHERE uf = 'RJ';

-- criando fragmento SP
CREATE TABLE banco_sp1.cli_sp AS 
SELECT * FROM correntista
WHERE uf = 'SP';

-- criando redundância RJ
CREATE TABLE banco_sp2.cli_rj AS 
SELECT * FROM correntista
WHERE uf = 'RJ';

-- criando redundância SP
CREATE TABLE banco_sp2.cli_sp AS 
SELECT * FROM correntista
WHERE uf = 'SP';

-- unindo fragmentos
SELECT distinct avg(s.saldo) as SP, avg(r.saldo) as RJ FROM banco_sp1.cli_sp as s, banco_rj.cli_rj as r
where s.sexo = 'F'
and r.sexo = 'F';


select avg(saldo) FROM(
SELECT * FROM banco_sp1.cli_sp s
UNION
SELECT * FROM banco_rj.cli_rj r
) as r
WHERE sexo = 'F';























