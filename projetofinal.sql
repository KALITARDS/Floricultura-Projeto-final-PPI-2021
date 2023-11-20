
--- Criação das tabelas do banco:
CREATE TABLE cliente (
CPF INTEGER PRIMARY KEY,
nome VARCHAR (200) NOT NULL,
rua VARCHAR(30),
numero INTEGER,
CEP INTEGER NOT NULL,
cidade VARCHAR(20) ,
estado VARCHAR(2),
telefone VARCHAR (15),
email VARCHAR (30)
);

CREATE TABLE categoria(
cod_categoria SERIAL PRIMARY KEY,
descricao VARCHAR(200)
);

CREATE TABLE produto(
cod_produto SERIAL PRIMARY KEY,
nome VARCHAR (200) NOT NULL,
categoria integer references categoria (cod_categoria),
preco NUMERIC(4,2) NOT NULL
);

CREATE TABLE pedido(
ID_pedido SERIAL PRIMARY KEY,
data date,
cpf_cliente integer references cliente (CPF) NOT NULL,
cod_item integer references produto (cod_produto) NOT NULL
);

---Comandos CRUD:

---Inserindo dados nas tabelas
INSERT INTO cliente(CPF, nome, CEP, cidade)
VALUES
(0125487632, 'Fábio', 21546328, 'Rio de Janeiro'),
(1508796547, 'Gustavo', 63946587, 'São Paulo',
(0849760124, 'Marcia', 52145689, 'Brasília'),
(2045965174, 'Brenda', 45123658, 'Recife'),
(0695265802, 'Maria', 87457842, 'Recife'),
(1497504588, 'Carol', 58749658, 'Brasília'),
(0248706512, 'Paulo', 71246325, 'Rio de Janeiro'),
(2056472507, 'Kátia', 12456326, 'Salvador'),
(1018647841, 'Daniel', 32154785, 'São Paulo'),
(2047892321, 'Dalila', 95125475, 'Salvador');
 
INSERT INTO categoria(descricao)
VALUES
('cravos'),
('tulipas'),
('rosas'),
('girassol'),
('orquídeas'),
('violetas'),
('lírios'),
('begônias'),
('margaridas'),
('rosas');
  
INSERT INTO produto(nome, categoria, preco)
VALUES
('buquê de rosas', 3, 45.90),
('cesta de tulipas', 2, 39.99),
('mix de girassóis', 4, 67.99),
('mini buquê de violetas', 6, 29.59),
('arranjo de de lírios', 7, 59.90),
('arranjo três margaridas e caixa de chocolate', 9, 99.90),
('bergônias em vaso de cristal', 8, 97.99),
('cesta de cravos', 1, 79.90),
('buquê de orquídeas', 5, 89.99);
select* from produto

INSERT INTO pedido (data, cpf_cliente, cod_item)
VALUES
('10-05-2021', 0125487632, 1),
('25-08-2020', 1508796547, 2),
('25-08-2020', 1508796547, 9),
('05-07-2021', 0849760124, 3),
('19-11-2020', 2045965174, 4),
('09-05-2020', 0849760124, 8),
('07-08-2020', 0695265802, 5),
('09-05-2020', 1497504588, 7),
('31-10-2021', 0248706512, 1),
('25-05-2020', 2056472507, 2),
('10-02-2021', 1018647841, 6),
('09-05-2020', 2047892321, 3),
('24-04-2021', 2045965174,5);

---Removendo dados das tabelas:
 
--Removendo a categoria Rosa que está repetida
DELETE FROM categoria
WHERE (cod_categoria= 10);
 
--Removendo pedido do dia 05-07-2021
DELETE FROM pedido
WHERE (data= '05-07-2021');
 
 
---Atualizando os dados das tabelas
 
--Atualizando cidade da cliente Brenda:
UPDATE cliente
SET cidade='Goiânia'
WHERE(nome='Brenda');

--Atualizando preço do buquê de rosas:
UPDATE produto
SET preco= 74.99
WHERE(nome='buquê de rosas');
 
--Atualizando CEP do cliente Fábio:
UPDATE cliente
SET CEP=54879564
WHERE(nome='Fábio');
 
---Lendo os dados das tabelas
 
---Lendo todos os dados da tabela cliente:
SELECT * FROM cliente;

---Lendo os nomes dos produtos cadastrados na tabela produto:
SELECT (nome) FROM produto;

---Lendo as datas de compras e o CPF do cliente na tabela pedido, com o resultado em ordem crescente de data: 
SELECT (data, cpf_cliente) FROM pedido
order by data;
 
---Consultas:
 
---1) Buscando qual menor preço cadastrado na loja
SELECT MIN (preco) as "Menor Preço"
FROM produto;

---2) Contando a quantidade de pedidos feitos 
SELECT count (ID_pedido)
FROM pedido;

---3) Buscando os pedidos que foram feitos no dia 09-05-2020 ou no dia 25-05-2020
SELECT *
FROM pedido
where data='09-05-2020' OR data='25-05-2020';

---4) Buscando a quantidade de clientes cadastrados por cidade
SELECT cidade, count(*)
FROM cliente
group by cidade
order by cidade;

---5) Buscando produtos que custem 79.90 ou 89.99, e não sejam da categoria 1 (flores do tipo Cravo)
SELECT *
FROM produto
WHERE preco IN(79.90,89.99)
AND categoria != 1;

---6)Buscando pelas descrições de categorias de flores que terminam com "as"
SELECT descricao
FROM categoria
WHERE descricao LIKE '%as'
ORDER BY descricao;

---7) Buscando o nome e preço dos produtos que não sejam das categorias 1,2 e 5
SELECT nome, preco
FROM produto
WHERE categoria NOT IN(1,2,5)
ORDER BY nome;

---8) Verificando quais clientes realizaram algum pedido
SELECT cli.nome, cli.CPF
FROM cliente cli
WHERE EXISTS (SELECT ped.cpf_cliente
 				FROM pedido ped
 				WHERE cli.CPF = ped.cpf_cliente
 ); 

---9)Buscando os códigos dos itens que foram pedidos pelo menos 2 vezes 
SELECT cod_item, count(*)
FROM pedido
group by cod_item
having count (*) >=2;

 
---10)Encontrando a média dos preços das flores
SELECT AVG (preco) as "Média dos Preços"
FROM produto;

---Consultas em múltiplas tabelas:
---11) Buscando pelos clientes que comparam na loja no dia 25-08-2020
SELECT nome, CPF
FROM cliente
INNER JOIN pedido on CPF =cpf_cliente
WHERE data='25-08-2020';
 
---12)Descobrindo quais produtos estão contidos nos pedidos
SELECT ped.ID_pedido as "Número do pedido", prod.nome as "Produto comprado"
FROM  pedido ped
INNER JOIN produto prod on cod_produto= cod_item
 
---13)Descobrindo quanto cada produto vendeu
SELECT COUNT (cod_item) as "Quantidade de vendas", prod.nome as "Nome do produto"
FROM  pedido ped
INNER JOIN produto prod on cod_produto= cod_item
GROUP BY prod.nome
ORDER BY prod.nome
 
---14)Descobrindo a quantidade de vezes que cada cliente já comprou na loja
SELECT count (CPF), nome
FROM cliente
INNER JOIN pedido on CPF =cpf_cliente
GROUP by nome
ORDER BY nome

---15)Procurando pelo cliente que fez pedido do item de código 3 (mix de girassóis), sem deixar de exibir os outros clientes
SELECT cli.nome, cli.CPF, cli.cidade, ped.ID_pedido, ped.data, ped.cod_item
FROM cliente cli
LEFT OUTER JOIN pedido ped on cpf_cliente = CPF and cod_item=3 
ORDER BY cod_item




 




 
 
