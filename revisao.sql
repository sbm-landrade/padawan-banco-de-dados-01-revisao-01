/*inicio dos desafios
* Desafios de Consultas SQL *
* Básico */
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
-- Ordene os funcionários por idade em ordem crescente. 
select * from funcionarios order by idade;
-- Selecione os funcionários cujo nome começa com 'A'. 
select * from funcionario where 'A';
--  Conte quantos projetos estão na tabela. 
select count(*) from projetos;
--  Selecione os projetos que ainda não começaram. 
select count(*) from projetos where data_inicio > curdate() or  data_inicio is null;
--  Conte quantos funcionários têm mais de 35 anos. *
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
select nome, round(salario, 2) as salario_arredondado
from funcionarios;
-- Selecione os projetos que terminam antes de '2023-07-01'. --
select * from projetos where data_fim < '2023-07-01';
-- Liste os funcionários com idade entre 25 e 30 anos. --
select * from  funcionarios where idade >=25 and idade <=30;
-- Selecione os projetos onde nenhum funcionário foi atribuído. --
select *
from atribuicoes
where papel is null;
-- Liste os funcionários que não estão atribuídos a nenhum projeto.
select *
FROM atribuicoes
WHERE id_projeto is null;
-- Selecione os funcionários que estão atribuídos a mais de um projeto. --
select funcionarios.id, funcionarios.nome, count(atribuicoes.id_projeto) as total_projetos
from funcionarios
join atribuicoes on funcionarios.id = atribuicoes.id_funcionario
group by funcionarios.id, funcionarios.nome
having count(atribuicoes.id_projeto) > 1;
-- Liste os projetos com a média de idade dos funcionários atribuídos. --
select projetos.nome as nome_Projeto, round(avg(funcionarios.idade), 2) AS media_Idade
from projetos
join atribuicoes on projetos.id = atribuicoes.id_projeto
join funcionarios on atribuicoes.id_funcionario = funcionarios.id
group by projetos.id;
-- Selecione os funcionários que são gerentes de projeto. --
select funcionarios.nome, funcionarios.cargo
from funcionarios
join atribuicoes on funcionarios.id = atribuicoes.id_funcionario
where atribuicoes.papel = 'Gerente de Projeto';
-- Liste os projetos com a maior e a menor data de término. --
select max(data_fim) as maior_DataFim, min(data_fim) as menor_DataFim
from projetos;
-- Selecione os funcionários que têm o mesmo salário. --
SELECT salario
FROM funcionarios
GROUP BY salario
HAVING COUNT(*) > 1;
-- Liste os projetos que têm funcionários com idade média superior a 30 anos. --
select projetos.nome, funcionarios.nome
from projetos
join atribuicoes on projetos.id = atribuicoes.id_projeto
join funcionarios on atribuicoes.id = funcionarios.id
group by projetos.id, funcionarios.id
having avg(funcionarios.idade) > 30;
-- Selecione os funcionários que têm o maior salário em cada cargo. --
select nome, cargo, salario
from funcionarios f1
where salario = (select max(salario) from funcionarios f2 where f1.cargo = f2.cargo);
-- Liste os projetos com a maior diferença de dias entre data_inicio e data_fim. --
select nome, datediff(data_fim, data_inicio) as diferenca_Dias
from projetos
order by diferenca_Dias desc
limit 1;
-- Selecione os funcionários que têm sido atribuídos a projetos por mais de um ano. --
select distinct funcionarios.nome
from funcionarios
join atribuicoes on funcionarios.id = atribuicoes.id_funcionario
join projetos on atribuicoes.id_projeto = projetos.id
where DATEDIFF(projetos.data_fim, projetos.data_inicio) > 365;
-- Liste os projetos e os funcionários que têm o papel de 'Analista' em cada projeto. 
SELECT projetos.nome AS NomeProjeto, funcionarios.nome AS NomeFuncionario, atribuicoes.papel
FROM projetos
JOIN atribuicoes ON projetos.id = atribuicoes.id_projeto
JOIN funcionarios ON atribuicoes.id_funcionario = funcionarios.id
WHERE atribuicoes.papel LIKE '%Analista%';
