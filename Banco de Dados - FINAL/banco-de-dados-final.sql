-- CRIAR DATABASE NOMEADA "7SOJAS"
create database 7sojas;

-- USAR DATABASE NOMEADA "7SOJAS"
use 7sojas;

-- 1ª TABELA ========================================================

-- CRIAR UMA TABELA PARA ARMAZENAR INFORMAÇÕES DO USUÁRIO (NOME, EMAIL E SENHA) 
-- TENDO O ID DE ATIVAÇÃO DE CONTA DO USUÁRIO COMO CHAVE PRIMÁRIA
create table informacoesUsuario (
idAtivacao varchar(6) primary key,
nomeUsuario varchar(45),
emailUsuario varchar(75) unique, -- "UNIQUE" ESTÁ SENDO UTILIZADO PARA INFORMAR QUE ESSE VALOR (EMAIL) DEVE SER ÚNICO, NÃO PERMITINDO REPETIÇÃO NOS DADOS
senhaUsuario varchar(20)
);

-- INSERINDO AS INFORMAÇÕES NA TABELA USUÁRIO
insert into informacoesUsuario(idAtivacao, nomeUsuario, emailUsuario, senhaUsuario) values
('#7S001', 'Samil', 'samil@gmail.com', 'S4M1LGR40S'),
('#7S002', 'Soya Silo', 'soyasilo@gmail.com', '#S0YM0SSYL0S'),
('#7S003', 'GNova', 'wgnova@gmail.com', 'GN0VAEHFUTUR0!');


-- 2ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SILOS CONTENDO INFORMAÇÕES DO ID DO SILO, NUMERO DE SILOS E TAMANHO DOS SILOS
-- USAR CHAVE ESTRANGEIRA PARA REFERENCIAR UMA CHAVE PRIMÁRIA DE OUTRA COLUNA
create table silos (
idSilo int primary key auto_increment,
numSilo int, 
tamanhoSilo int,
fkInformacoesUsuario varchar(6),
constraint fk_informacoes_usuario foreign key (fkinformacoesUsuario) references informacoesUsuario(idAtivacao)
-- CONSTRAINT SÃO OS REGRAS EM UMA TABELA DEFININDO SUA CHAVE (primary, foreign) E VALOR (null, not null),
-- ALÉM DE FAZER VALIDAÇÃO DE INFORMAÇÕES (check), UMA VEZ QUE A REGRA É CRIADA, ELA PODERÁ SER REUTILIZADA
);

-- INSERINDO AS INFORMAÇÕES NA TABELA SILOS
insert into silos (numSilo, tamanhoSilo, fkInformacoesUsuario) values
(1, 1000, '#7S001'),
(2, 2000, '#7S001'),
(1, 500, '#7S002'),
(1, 720, '#7S003');


-- 3ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SENSORES, ONDE CONTEM O NÚMERO CEREAL DO SENSOR DIVIDIDO ENTRE TEMPERATURA (ST) E UMIDADE (SU) 
create table sensores (
serialSensor varchar(5) primary key,
numSensor int,
dtInstalacao date,
tipoSensor varchar(1) not null,
fkSilo int,
constraint check (tipoSensor in('T', 'U')), -- É DADO UM CHECK PARA GARANTIR QUE OS TIPOS DE SENSORES SEJAM SOMENTE TEMPERATURA (T) E/OU UMIDADE (U)
constraint fk_silo foreign key (fkSilo) references silos(idSilo)
);

-- INSERINDO AS INFORMAÇÕES NA TABELA SENSORES
insert into sensores (serialSensor, numSensor, dtInstalacao, tipoSensor, fkSilo) values
('SU001', 1, '2024-02-13', 'U', 1), -- COMEÇANDO PELOS SENSORES DE UMIDADE (SU)
('SU002', 2, '2024-02-13', 'U', 1),
('SU003', 3, '2024-02-13', 'U', 1),
('SU004', 4, '2024-02-13', 'U', 1),
('SU005', 5, '2024-02-13', 'U', 1),
('SU006', 1, '2024-02-14', 'U', 2),
('SU007', 2, '2024-02-14', 'U', 2),
('SU008', 3, '2024-02-14', 'U', 2),
('SU009', 4, '2024-02-14', 'U', 2),
('SU010', 5, '2024-02-14', 'U', 2),
('SU011', 1, '2023-12-31', 'U', 3),
('SU012', 2, '2023-12-31', 'U', 3),
('SU013', 3, '2023-12-31', 'U', 3),
('SU014', 4, '2023-12-31', 'U', 3),
('SU015', 5, '2023-12-31', 'U', 3),
('SU016', 1, '2024-01-30', 'U', 4),
('SU017', 2, '2024-01-30', 'U', 4),
('SU018', 3, '2024-01-30', 'U', 4),
('SU019', 4, '2024-01-30', 'U', 4),
('SU020', 5, '2024-01-30', 'U', 4),

('ST001', 1, '2024-02-13', 'T', 1), -- LOGO APÓS OS SENSORES DE TEMPERATURA (ST)
('ST002', 2, '2024-02-13', 'T', 1),
('ST003', 3, '2024-02-13', 'T', 1),
('ST004', 4, '2024-02-13', 'T', 1),
('ST005', 5, '2024-02-13', 'T', 1),
('ST006', 1, '2024-02-14', 'T', 2),
('ST007', 2, '2024-02-14', 'T', 2),
('ST008', 3, '2024-02-14', 'T', 2),
('ST009', 4, '2024-02-14', 'T', 2),
('ST010', 5, '2024-02-14', 'T', 2),
('ST011', 1, '2023-12-31', 'T', 3),
('ST012', 2, '2023-12-31', 'T', 3),
('ST013', 3, '2023-12-31', 'T', 3),
('ST014', 4, '2023-12-31', 'T', 3),
('ST015', 5, '2023-12-31', 'T', 3),
('ST016', 1, '2024-01-30', 'T', 4),
('ST017', 2, '2024-01-30', 'T', 4),
('ST018', 3, '2024-01-30', 'T', 4),
('ST019', 4, '2024-01-30', 'T', 4),
('ST020', 5, '2024-01-30', 'T', 4);



-- EXIBIÇÃO DE DADOS DE UMA MANEIRA MAIS LIMPA, ONDE É APRESENTADO:
select iu.nomeUsuario, iu.emailUsuario, -- NOME E EMAIL DO USUARIO
sl.numSilo, sl.tamanhoSilo, -- NÚMERO E TAMANHO DOS SILOS
sn.serialSensor, sn.numSensor, sn.dtInstalacao, sn.tipoSensor -- CÓDIGO CERAL, NÚMERO, DATA DE INSTALAÇÃO E TIPO DE SENSOR 
from informacoesUsuario as iu
inner join silos as sl
inner join sensores as sn 
on sn.fkSilo = sl.idSilo -- PARA UMA APRESENTAÇÃO CLARA E CORRETA, DEFINO QUE OS VALORES DEVEM SER IGUAIS NAS TABELAS SELECIONADAS
and sl.fkInformacoesUsuario = iu.idAtivacao;

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