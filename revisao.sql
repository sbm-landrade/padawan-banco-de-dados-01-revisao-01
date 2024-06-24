-- inicio dos desafios
/* Desafios de Consultas SQL */
/* Básico */
use funcionarios;
-- Selecione todos os funcionários
select * from funcionarios;
--  Selecione os projetos com suas descrições
select descricao from projetos;
-- Selecione os funcionários com salário maior que 5000.
select * from funcionarios where salario > 5000;
-- Conte o número total de funcionários.
select count(*) from funcionarios;
-- Selecione os projetos que começam depois de '2023-01-01'. 
select * from projetos where data_inicio > '2023-01-01';
-- Ordene os funcionários por idade em ordem crescente. /
select * from funcionarios order by idade;
-- Selecione os funcionários cujo nome começa com 'A'. /
select * from funcionario where 'A';
--  Conte quantos projetos estão na tabela. /
select count(*) from projetos;
--  Selecione os projetos que ainda não começaram. /
select count(*) from projetos where data_inicio > curdate() or  data_inicio is null;
--  Conte quantos funcionários têm mais de 35 anos. */
select count(nome) from funcionarios where idade > 35;