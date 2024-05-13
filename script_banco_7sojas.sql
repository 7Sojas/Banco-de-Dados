-- Criação do banco de dados
create database sojas7;

-- utilizar o banco
use sojas7;

-- Tabela usuário, onde conterá todas as informções pertinentes para o cadastro do cliente em nosso sistema
create table usuario (
idUsuario int primary key auto_increment,
nomeCompleto varchar(50) not null,
email varchar(80) not null,
cpf varchar(11) not null,
telefone varchar(11) not null,
senha varchar(40) not null
);

-- Dados inseridos na tabela Usuario
insert into usuario (nome, email, cpf, telefone, senha)
values('Bianca Almeida', 'bialmeida@gmail.com', '42312343343', '11987651233', 'Bianca123@'),
('Murillo Rodrigues', 'murirodrigues@gmail.com', '25485698512', '11914523698', 'Murillo#123'),
('Gustavo Alencar', 'gusalencar@gmail.com', '96325874112', '11968532147', 'Gustavo*123'),
('Ana Beatriz Costa', 'anabeacosta@gmail.com', '54687932145', '11914578236', 'Ana@#123'),
('Miguel Pinho', 'mipinho@gmail.com', '96478512354', '11998765413', 'Miguel#123'),
('Davi de Souza', 'davisouza@gmail.com', '15975365487', '11960605454', 'Davi@123*');


-- Tabela endereço que se relacionará com a tabela Usuário 
create table endereco (
idEndereco int primary key auto_increment,
logradouro varchar(50) not null,
numero int not null,
cep varchar(50) not null,
fkUsuario int not null,
constraint fk_usuario_endereco foreign key (fkUsuario) references usuario (idUsuario)
);

-- Dados inseridos na tabela endereco
insert into endereco (logradouro,numero, cep, fkUsuario)
values ('Rua Frei Caneca', 12,'01317122', 1),
('Rua Adalberto Sampaio', 432,'01421123', 2),
('Avenida Jupiter', 23,'03288012', 3),
('Rua Cachoeira Poraque', 325,'01211001', 4),
('Rua Trilho Alto', 112,'02020123', 5),
('Rua Rio Bravo', 2443,'04141000', 6);


--  a Tabela Propriedade onde o usuário irá informa onde se encontra a fazenda em que os silos serão aplicados
create table propriedade (
idPropriedade int primary key auto_increment,
nome varchar(45) not null,
proprietario varchar(45) null,
fkUsuario int not null,
constraint fk_usuario_propriedade foreign key (fkUsuario) references usuario (idUsuario)
);

-- Dados inseridos na tabela propriedade
insert into propriedade (nome,proprietario, fkUsuario)
values ('Grãos Porte','Ailton Menezes', 1),
('Outra Soja', 'Lucas Nobrega', 2),
('Nova Grains', 'Raissa Martins', 3),
('Agro Grãos', null, 4),
('Plante Grains', 'Silvia Montes', 5),
('Natura Grãos', null, 6 );

-- Tabela de Silos, interligada com a propriedade para qual será destinada (capacidade em toneladas)
create table silos (
idSilo int primary key auto_increment,
tipo varchar(45) null,
capacidade_Max decimal(10,2) not null,
sensores varchar(45) not null,
fkPropriedade int not null,
alertaVermelho decimal(10,2) null,
alertaAmarelo decimal(10,2) null,
constraint fk_propriedade_silos foreign key (fkPropriedade) references propriedade (idPropriedade)
);

insert into silos (tipo, capacidade_Max, sensores,fkPropriedade )
values('metálico','60.5','LM35 e DHT11',1),
('metálico','80','LM35 e DHT11',2),
('metálico','70','LM35 e DHT11',3),
('metálico','65','LM35 e DHT11',4),
('metálico','93.5','LM35 e DHT11',5),
('metálico','55','LM35 e DHT11',6);

-- Tabela dos sensores, interligado a tabela silos
create table sensor (
idSensor int primary key auto_increment,
tipo varchar(45) not null,
quantidade int null,
fkSilo int not null,
constraint fk_silo_sensor foreign key (fkSilo) references silos (idSilo),
constraint check_tipo check (tipo in ('LM35','DHT11'))
);

insert into sensor(tipo,quantidade,fksilo)
values('LM35', 4, 1),
('DHT11', 4, 1),
('LM35', 3, 2),
('DHT11', 3, 2),
('LM35', 2, 3),
('DHT11', 2, 3),
('LM35', 4, 4),
('DHT11', 4, 4),
('LM35', 2, 5),
('DHT11', 2, 5),
('LM35', 4, 6),
('DHT11', 4, 6);

-- Tabela para a leitura dos sensores com auxilia da API
create table leituraSensor (
idLeitura int primary key auto_increment,
umidadeDht float not null,
temperaturaLm float not null,
dataHora timestamp not null default current_timestamp,
fkSensor int not null,
constraint fk_sensor_leitura foreign key (fkSensor) references sensor (idSensor)
);


-- Selecionar todos os dados de cada tabela
select * from usuario;
select * from endereco;
select * from propriedade;
select * from silos;
select * from sensor;
select * from leituraSensor;

-- inner join iD sensor com dados do sensor;
select sens.idSensor, leitura.umidadeDht, leitura.temperaturaLm, leitura.dataHora
from sensor sens
inner join leituraSensor leitura on leitura.fkSensor = sens.idSensor;


-- Selecionar o id do Usuario, nome do Usuario, CPF, Email, telefone principal, logradouro, numero, bairro, cidade, pais, nome da propriedade, proprietario e cep da propriedade
select u.idUsuario 'iD Usuario',
       u.nome 'Nome Usuario',
       u.cpf CPF,
       u.email Email,
       u.senha Senha,
       u.telefone_1 Telefone,
       e.logradouro Logradouro,
       e.numeroLogradouro Numero,
       e.bairro Bairro,
       e.cidade Cidade,
       e.pais 'País',
	   p.nome Propriedade,
       p.proprietario Proprietario,
       p.cep CEP
from usuario u
inner join endereco e on e.fkUsuario = u.idUsuario
inner join propriedade p on p.fkUsuario = u.idUsuario;

