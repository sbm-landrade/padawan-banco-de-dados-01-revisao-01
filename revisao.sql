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
-- 1. Listar todos os funcionários e seus respectivos projetos, incluindo nome do funcionário, nome do projeto e papel do funcionário no projeto.
SELECT DISTINCT f.nome AS nome_funcionario, p.nome AS nome_projeto, a.papel AS papel_no_projeto
FROM funcionarios AS f
JOIN atribuicoes AS a ON a.id_funcionario = f.id
JOIN projetos AS p ON a.id_projeto = p.id;

-- 2. Exibir a média salarial dos funcionários por cargo.
SELECT cargo, ROUND(AVG(salario), 2) AS media_salarial
FROM funcionarios
GROUP BY cargo;

-- 3. Mostrar o funcionário mais bem pago e o projeto em que ele trabalha.
SELECT * FROM funcionarios 
WHERE salario = (SELECT MAX(salario) FROM funcionarios);
-- 4. Apresentar a quantidade de projetos em que cada funcionário está participando.
SELECT f.nome AS funcionario, COUNT(a.id_projeto) AS quantidade_projetos
FROM funcionarios f
JOIN atribuicoes a ON f.id = a.id_funcionario
GROUP BY f.id, f.nome
ORDER BY f.nome ASC;

-- 1. Calcular a média salarial dos funcionários que participam de projetos específicos (informar o ID do projeto).
SELECT p.nome as projetos, ROUND(AVG(f.salario), 2) AS media_salarial
FROM funcionarios f
JOIN projetos p ON f.id = p.id
GROUP BY p.nome;
-- 2. Listar os projetos com a maior quantidade de funcionários alocados.
select p.descricao as nome_projeto, count(a.id_funcionario) as quantidade_funcionarios
from projetos as p
inner join atribuicoes as a on a.id_projeto = p.id
group by p.descricao
order by quantidade_funcionarios DESC
LIMIT 1;

-- 3. Apresentar os projetos que possuem a equipe com a maior média salarial.
-- Subconsulta para calcular a média salarial de cada projeto
WITH media_salarios_projetos AS (
    SELECT p.nome AS projeto_nome, AVG(f.salario) AS media_salarial
    FROM funcionarios f
    JOIN projetos p ON f.id = p.id  -- Ajustar conforme o nome da coluna correta
    GROUP BY p.nome
)
SELECT projeto_nome AS projetos, ROUND(media_salarial, 2) AS media_salarial
FROM media_salarios_projetos
WHERE media_salarial = (SELECT MAX(media_salarial) FROM media_salarios_projetos);