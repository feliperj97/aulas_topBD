
create schema cli_pess;
create schema cli_bank;


-- dados pessoais
DROP TABLE if exists cli_pess.site1;
create table cli_pess.site1 as(
SELECT codcli, nome, sexo, cidade, uf FROM correntista
UNION
SELECT codcli, nome, sexo, cidade, uf FROM correntista
);

-- dados bancários

CREATE TABLE cli_bank.site2 AS (
SELECT codcli, agencia, conta, saldo FROM correntista
union
SELECT codcli, agencia, conta, saldo FROM correntista
);
-- nome e saldo

select p.nome as nome, b.saldo as saldo from cli_pess.site1 p
join cli_bank.site2 b on b.codcli = p.codcli;























