-- CRIAR DATABASE NOMEADA "7SOJAS"
create database 7sojas;

-- USAR DATABASE NOMEADA "7SOJAS"
use 7sojas;

-- 1ª TABELA ========================================================

-- CRIAR UMA TABELA PARA ARMAZENAR INFORMAÇÕES DO USUÁRIO, 
-- TENDO O ID DO USUÁRIO COMO CHAVE PRIMÁRIA QUE SE INCREMENTA A PARTIR DE 1
create table informacoesUsuario (
idUsuario int primary key auto_increment,
nomeUsuario varchar(45),
emailUsuario varchar(75) unique, 
-- "UNIQUE" ESTÁ SENDO UTILIZADO PARA INFORMAR QUE ESSE VALOR (EMAIL) DEVE SER ÚNICO, NÃO PERMITINDO REPETIÇÃO NOS DADOS
senhaUsuario varchar(20)
);

-- INSERINDO AS INFORMAÇÕES NA TABELA USUÁRIO, COM O NOME DA EMPRESA, EMAIL E SENHA
-- QUANDO UM VALOR É AUTO_INCREMENT OU NULL, NÃO É NECESSÁRIO COLOCAR SEUS DADOS NA TABELA, POIS ELES SE PREENCHEM SOZINHOS
insert into informacoesUsuario (nomeUsuario, emailUsuario, senhaUsuario) values
('Samil', 'samil@gmail.com', '#7SGR40S'),
('Soya Silo', 'soyasilo@gmail.com', '#7SS1L0S'),
('GNova', 'wgnova@gmail.com', '#7S4RM4Z3N4M3NT0');

-- EXIBIR DADOS INSERIDOS NA TABELA DE USUÁRIO
select * from informacoesUsuario;


-- 2ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SILOS CONTENDO INFORMAÇÕES DO ID DO SILO, NUMERO DE SILOS E TAMANHO DOS SILOS
-- ALÉM DE OBTER UMA CHAVE ESTRANGEIRA RETIRADA DA 1ª TABELA, ONDE ELA PUXA >SOMENTE< A CHAVE PRIMÁRIA DA TABELA ANTERIOR
create table silos (
idSilo int primary key auto_increment,
numSilo int, 
tamanhoSilo int,
fkInformacoesUsuario int,
-- CHAVES ESTRANGEIRAS COSTUMAM VIR COMO "NULL" NAS TABELAS
constraint fk_informacoes_usuario foreign key (fkinformacoesUsuario) references informacoesUsuario(idUsuario)
);

-- INSERIR VALORES NA TABELA DE SILOS, NOVAMENTE EXCLUINDO O ID POR SER AUTO_INCREMENT
-- SE NÃO TIVESSE DEFINIDO OS VALORES DA CHAVE ESTRANGEIRA (ULTIMA COLUNA) ABAIXO, OS VALORES SERIAM NULOS
-- É BOM DEFINIR PARA QUESTÃO DE ORGANIZAÇÃO DA TABELA
insert into silos (numSilo, tamanhoSilo, fkInformacoesUsuario) values
(2, 1000, 1),
(2, 2000, 1),
(1, 500, 2),
(1, 720, 3);

-- EXIBIR INFORMAÇÕES DA TABELA DE SILOS
select * from silos;

-- 3ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SENSORES, ONDE CONTEM O NÚMERO CEREAL DO SENSOR (NUMERO ÚNICO DE IDENTIFICAÇÃO,
-- ESCOLHI DEIXAR UM LIMITE DE CARÁCTER DE 5 PARA DIVIDIR OS NUMEROS CEREAIS EM ST000 (SENSOR TEMPERATURA) OU SU000 (SENSOR UMIDADE)
-- COLOCAMOS A CHAVE ESTRANGEIRA DA 2ª TABELA PARA LIGAR O NÚMERO DO SILO COM OS SENSORES APROPRIADOS,
-- TAMBÉM COLOCAMOS NOVAMENTE AS INFORMAÇÕES DE USUÁRIO PARA LIGAÇÃO DE CLAREZA NA ORGANIZAÇÃO DOS DADOS
create table sensores (
serialSensor varchar(5) primary key,
numSensor int,
dtInstalacao date,
tipoSensor varchar(1) not null,
fkSilo int,
fkInformacoesUsuario int,
constraint check (tipoSensor in('T', 'U')),
-- É DADO UM CHECK PARA GARANTIR QUE OS TIPOS DE SENSORES SEJAM SOMENTE TEMPERATURA (T) E/OU UMIDADE (U)
constraint fk_silo foreign key (fkSilo) references silos(idSilo)
);

-- FOI ADICIONADO CINCO SENSORES DE UMIDADE E CINCO SENSORES DE TEMPERATURA POR SILO
-- OU SEJA, QUEM TEM DOIS SILOS, OBTÉM VINTE VALORES DE SENSOR NO TOTAL
insert into sensores (serialSensor, numSensor, dtInstalacao, tipoSensor, fkSilo, fkInformacoesUsuario) values
-- A ORGANIZAÇÃO DOS DADOS FOI FEITA DA SEGUINTE FORMA:
-- PRIMEIRO COLOCAMOS OS NÚMEROS CEREAIS DOS SENSORES DE UMIDADE, COLOCANDO A QUANTIDADE, 
-- DATA DE INSTALAÇÃO, TIPO DE SENSOR, A QUAL ID DE SILO ELE PERTENCE E A QUAL ID DE USUÁRIO PERTENCE
('SU001', 1, '2024-02-13', 'U', 1, 1),
('SU002', 2, '2024-02-13', 'U', 1, 1),
('SU003', 3, '2024-02-13', 'U', 1, 1),
('SU004', 4, '2024-02-13', 'U', 1, 1),
('SU005', 5, '2024-02-13', 'U', 1, 1),
('SU006', 1, '2024-02-14', 'U', 2, 1),
('SU007', 2, '2024-02-14', 'U', 2, 1),
('SU008', 3, '2024-02-14', 'U', 2, 1),
('SU009', 4, '2024-02-14', 'U', 2, 1),
('SU010', 5, '2024-02-14', 'U', 2, 1),
('SU011', 1, '2023-12-31', 'U', 3, 2),
('SU012', 2, '2023-12-31', 'U', 3, 2),
('SU013', 3, '2023-12-31', 'U', 3, 2),
('SU014', 4, '2023-12-31', 'U', 3, 2),
('SU015', 5, '2023-12-31', 'U', 3, 2),
('SU016', 1, '2024-01-30', 'U', 4, 3),
('SU017', 2, '2024-01-30', 'U', 4, 3),
('SU018', 3, '2024-01-30', 'U', 4, 3),
('SU019', 4, '2024-01-30', 'U', 4, 3),
('SU020', 5, '2024-01-30', 'U', 4, 3),
-- LOGO APÓS É INSERIDO OS VALORES DE SENSOR DE TEMPERATURA, SEGUINDO O MESMO ESQUEMA DO ANTERIOR,
-- COMEÇANDO A PARTIR DO 001 POR SER UM NÚMERO CEREAL DIFERENTE
('ST001', 1, '2024-02-13', 'T', 1, 1),
('ST002', 2, '2024-02-13', 'T', 1, 1),
('ST003', 3, '2024-02-13', 'T', 1, 1),
('ST004', 4, '2024-02-13', 'T', 1, 1),
('ST005', 5, '2024-02-13', 'T', 1, 1),
('ST006', 1, '2024-02-14', 'T', 2, 1),
('ST007', 2, '2024-02-14', 'T', 2, 1),
('ST008', 3, '2024-02-14', 'T', 2, 1),
('ST009', 4, '2024-02-14', 'T', 2, 1),
('ST010', 5, '2024-02-14', 'T', 2, 1),
('ST011', 1, '2023-12-31', 'T', 3, 2),
('ST012', 2, '2023-12-31', 'T', 3, 2),
('ST013', 3, '2023-12-31', 'T', 3, 2),
('ST014', 4, '2023-12-31', 'T', 3, 2),
('ST015', 5, '2023-12-31', 'T', 3, 2),
('ST016', 1, '2024-01-30', 'T', 4, 3),
('ST017', 2, '2024-01-30', 'T', 4, 3),
('ST018', 3, '2024-01-30', 'T', 4, 3),
('ST019', 4, '2024-01-30', 'T', 4, 3),
('ST020', 5, '2024-01-30', 'T', 4, 3);

-- EXIBIR INFORMAÇÕES DA TABELA DE SENSORES
select * from sensores;

-- APÓS INSERIR TODOS OS DADOS, UTILIZAMOS O INNER JOIN PARA CONCATENAR (JUNTAR) DADOS DAS TABELAS
-- COM O COMANDO "AS", DEFINIMOS APELIDOS PARA AS NOSSAS TABELAS
select * from informacoesUsuario as iu
-- INNER JOIN É USADO COMO UM "PEGUE TAMBÉM DESSA TABELA"
inner join silos as sl
inner join sensores as sn 
-- APÓS O INNER JOIN, É COLOCADO O COMANDO "ON" PARA COMPARAÇÃO, SE OS DADOS SÃO EQUIVALENTES
-- NAS TABELAS SELECIONADAS, OS RESULTADOS SÃO EXIBIDOS DE MANEIRA MAIS ORGANIZADA
-- EX: SE O VALOR DA CHAVE ESTRANGEIRA REFERENTE AO ID DOS SILOS NA TABELA SENSORES
-- FOR IGUAL AO VALOR DA CHAVE PRIMÁRIA REFERENTE AO ID DOS SILOS NA TABELA SILOS, OS RESULTADOS APARECEM
on sn.fkSilo = sl.idSilo
-- "AND" É UTILIZADO PELO FATO DE EXISTIR MAIS DE DUAS TABELAS A SEREM RELACIONADAS,
-- ENTÃO DIZEMOS QUE SE O VALOR ANTERIOR FOR CORRETO E ESSE TAMBÉM, OS RESULTADOS APARECEM
-- EX: SE O VALOR DA CHAVE ESTRANGEIRA REFERENTE AO ID DO USUÁRIO NA TABELA SENSORES
-- FOR IGUAL AO VALOR DA CHAVE PRIMÁRIA REFERENTE AO ID DO USUÁRIO NA TABELA USUÁRIO, OS RESULTADOS APARECEM  
and sl.fkInformacoesUsuario = iu.idUsuario;

-- PARA LIMPAR OS DADOS DAS TABELAS, USAMOS:
truncate table informacoesUsuario;
truncate table silos;
truncate table sensores;

-- PARA DELETAR AS TABELAS, USAMOS:
drop table informacoesUsuario;
drop table silos;
drop table sensores;


-- PARA FINALIZAR A OPERAÇÃO E EXCLUIR TODOS OS DADOS, USAMOS:
drop database 7sojas;