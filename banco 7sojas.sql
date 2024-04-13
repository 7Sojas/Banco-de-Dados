-- Criando o banco de dados
create database sojas7;

-- Acessando o banco
use sojas7;

-- Tabela com os dados do cliente contratante
create table cliente
( 
 idCliente int auto_increment primary key,
    nome varchar(45) not null,
    dataNasc date not null,
    cpf char(11) not null,
    email varchar(45) not null,
    senha varchar(25) not null,
    telefonePrincipal varchar(12) not null,
    telefoneOpcional varchar(12)
);

-- Um cliente pode ter muitos endereços
create table endereco
(
      logradouro varchar(45) not null,
    numLogradouro varchar(20) not null,
    bairro varchar(45) not null,
    cidade varchar(45) not null,
    pais varchar(45) not null,
    idCliente int,
    constraint idCliente foreign key(idCLiente) references cliente(idCliente)
);

-- Propriedade do cliente
create table propriedade
(
 idPropriedade int auto_increment primary key,
    nome varchar(45),
    dataFundacaoOuCompra date not null,
    logradouro varchar(45) not null,
    numLogradouro varchar(20) not null,
    bairro varchar(45) not null,
    cidade varchar(45) not null,
    pais varchar(45) not null,
    idCliente int,
    constraint dono foreign key(idCliente) references cliente(idCliente)
);


-- Dados do silo
create table silo
(
 idSilo int auto_increment primary key,
    nome varchar(45) not null,
    capacidadeMaxima decimal,
    tamanho decimal,
    idPropriedade int not null,
    constraint foreign key(idPropriedade) references propriedade(idPropriedade)
);

-- Dados do sensor
create table sensor
(
 idSensor int auto_increment primary key,
    tipo varchar(20) not null,
    nome varchar(20) not null,
    idSilo int not null,
    constraint idSilo foreign key(idSilo) references silo(idSilo)
);

-- leituras feitas
create table leituraSensor
(
 idLeituraSensor int auto_increment primary key,
    dataHora date not null,
    leitura varchar(45) not null,
    idSensor int not null,
    constraint idSensor foreign key(idSensor) references sensor(idSensor)
);