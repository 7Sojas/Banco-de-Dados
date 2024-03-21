-- Database Sojas
create database 7sojas;
use 7sojas;
drop database 7sojas;

-- Tabela com informações dos clientes
create table Cliente(
idCliente			INT auto_increment primary key,
nomeCliente			varchar(45) not null,
emailCliente		varchar(45) not null,
senhaCliente		varchar(15) not null,
qtdSilos			INT not null
);

insert into Cliente (nomeCliente, emailCliente, senhaCliente, qtdSilos)
values	('Rodrigo', 'rodrigo@soja', 'dinheiro', 2);

select * from Cliente;
drop table Cliente;

-- Tabela com informações dos silos
create table Silo(
idSilo			INT auto_increment primary key,
tamanhoSilo		INT not null,
fkCliente		INT,
constraint fkCliente_Silo foreign key (fkCliente) references Cliente(idCliente)
);

insert into Silo (tamanhoSilo, fkCliente)
values	(1000, 1);

select * from Silo;
drop table Silo;

-- Tabela com informações dos sensores
create table Sensor(
idSensor				INT auto_increment primary key,
tipoSensor				varchar(12),
qtdSensor				INT,
dataLeituraSensor       DATETIME,
fkCliente				INT,
constraint fkCliente_Sensor foreign key (fkCliente) references Cliente(idCliente)
);

insert into Sensor(tipoSensor, qtdSensor, dataLeituraSensor, fkCliente)
values	('temperatura', 2, '2024-03-20 12:00:00', 1);

update Sensor set tipoSensor = 'umidade' where idSensor = 1;

select * from Sensor;
drop table Sensor;

-- Selecionar as colunas desejadas e apelidar as tabelas
select ce.nomeCliente, ce.emailCliente, ce.qtdSilos,
so.tamanhoSilo, sr.qtdSensor, sr.tipoSensor, sr.dataLeituraSensor
from Cliente as ce
inner join Silo as so on so.fkCliente = ce.idCliente
inner join Sensor as sr on sr.fkCliente = ce.idCliente;

-- Limpar dados das tabelas
truncate table Cliente;
truncate table Silo;
truncate table Sensor;

-- Excluir todas as tabelas
drop table if exists Sensor;
drop table if exists Silo;
drop table if exists Cliente;

-- Excluir o banco de dados
drop database if exists 7sojas;