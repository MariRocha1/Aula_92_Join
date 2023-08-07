#Criação do banco de dados.
create database ibge;

#Ativando o banco de dados
use ibge;

#criação da tabela de unidades federativas
create table unidades_federativas(
cod_uf int,
uf char(2),
nome_uf varchar(30),
primary key (cod_uf)
);

#Criação da tabela municipios
create table municipios(
cod_municipio int,
cod_uf int,
nome_municipio varchar(40),
populacao int,
primary key (cod_municipio),
foreign key (cod_uf) references unidades_federativas(cod_uf)
);

SELECT m.nome_municipio, u.nome_uf FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf;


SELECT m.nome_municipio,m.populacao,u.uf from municipios m
inner join unidades_federativas u on m.cod_uf= u.cod_uf;

#Listar os municipios e suas unidades federativas,ordenado pelo nome do municipio
SELECT m.nome_municipio, u.nome_uf FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf order by m.nome_municipio;

#Listar os municipios que possuem uma população superior a 100.000 habitantes, juntamente com a sigla da unidade federativa
SELECT m.nome_municipio, u.nome_uf FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf 
where m.populacao >100000;

#Lista dos municipios que tem o mesmo nome que sua respectiva unidade federativa
SELECT m.nome_municipio, u.nome_uf FROM municipios m
INNER JOIN unidades_federativas u ON m.cod_uf = u.cod_uf
where m.nome_municipio = u.nome_uf;

#Calcular a média de população dos municipios para cada unidade federativa
SELECT u.nome_uf, avg(m.populacao) as media_populacao 
from municipios m
inner join unidades_federativas u on m.cod_uf 
group by u.uf;

#Listar os municipios que tem uma população maior que a média da população de todos os municipios
SELECT * from municipios municipios
where populacao > (select avg(m.populacao) as media_populacao
from municipios m);

#Desafio
Select u.nome_uf, count(*) as quantidade_municipios 
from municipios m 
inner join unidades_federativas u on m.cod_uf = u.cod_uf
group by u.uf;