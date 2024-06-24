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
-- Intermediário
-- Liste os funcionários com seus respectivos projetos atribuídos.
select funcionarios.nome as nome_Funcionario, projetos.nome as nome_Projeto
from atribuicoes
join funcionarios on atribuicoes.id_funcionario = funcionarios.id
join projetos on atribuicoes.id_projeto = projetos.id;
-- Liste os projetos com a contagem de funcionários atribuídos a cada um. --
select projetos.descricao, count(funcionarios.id) as numero_de_funcionarios
from atribuicoes
join funcionarios on atribuicoes.id_funcionario = funcionarios.id
join projetos on atribuicoes.id_projeto = projetos.id
group by projetos.descricao;
-- Selecione os funcionários que estão atribuídos ao projeto 'Projeto A'. --
select funcionarios.nome as nome_funcionarios
from atribuicoes
join funcionarios on atribuicoes.id_funcionario = funcionarios.id
join projetos on atribuicoes.id_projeto = projetos.id
where projetos.nome = 'Projeto A';
-- Liste os funcionários ordenados pelo salário em ordem decrescente. --
select *
from funcionarios
order by salario desc;
-- Selecione os projetos com descrição que contenha a palavra 'banco'. --
select * from projetos
where projetos.descricao like '%banco%';
-- Liste os funcionários e seus salários, arredondados para duas casas decimais. --
-- Selecione os projetos que terminam antes de '2023-07-01'. --
-- Liste os funcionários com idade entre 25 e 30 anos. --
-- Selecione os projetos onde nenhum funcionário foi atribuído. --
-- Liste os funcionários que não estão atribuídos a nenhum projeto.
