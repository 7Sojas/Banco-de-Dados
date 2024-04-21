-- Criação do banco de dados
create database sojas7;


-- utilizar o banco
use sojas7;

-- Tabela usuário, onde conterá todas as informções pertinentes para o cadastro do cliente em nosso sistema
create table usuario (
idUsuario int primary key auto_increment,
nome varchar(50) not null,
cpf varchar(11) not null,
email varchar(80) not null,
senha varchar(40) not null,
telefone_1 varchar(11) not null,
telefone_2 varchar(11) null
);

-- Dados inseridos na tabela Usuario
insert into usuario (nome, cpf,email, senha, telefone_1, telefone_2)
values('Bianca Almeida','42312343343','rafaalmeida@gmail.com','','11987651233','11936521478'),
('Murillo Rodrigues','25485698512','mrodrigues@gmail.com','','11914523698','11998765412'),
('Gustavo Alencar','96325874112','gusalencar@gmail.com','','11968532147','11965483249'),
('Ana Beatriz Costa','54687932145','anabeacosta@gmail.com','','11914578236','11998984547'),
('Miguel Pinho','96478512354','mipinho@gmail.com','','11998765413','11965425115'),
('Davi de Souza','15975365487','davisouza@gmail.com','','11960605454','11912365478');


-- Tabela endereço que se relacionará com a tabela Usuário 
create table endereco (
idEndereco int primary key auto_increment,
logradouro varchar(50),
numeroLogradouro int,
bairro varchar(50),
cidade varchar(50),
pais varchar(50), 
fkUsuario int,
constraint fk_Usuario_Endereco foreign key (fkUsuario) references usuario (idUsuario)
);

-- Dados inseridos na tabela endereco
insert into endereco (logradouro,numeroLogradouro, bairro, cidade, pais, fkUsuario)
values ('Rua Frei Caneca',12,'Novo Horizonte','Osasco','Brasil', 1),
('Rua Adalberto Sampaio',432,'Vila Dirce','Mogi das Cruzes','Brasil', 2),
('Av. Jupiter',23,'Planalto','Embu das Artes','Brasil', 3),
('Rua Cachoeira Poraque',325,'Conceição','Cotia','Brasil', 4),
('Rua Trilho Alto',112,'Jardim da Glória','Itaquera','Brasil', 5),
('Rua Rio Bravo',2443,'Santa Maria','Guarulhos','Brasil', 6);


--  a Tabela Propriedade onde o usuário irá informa onde se encontra a fazenda em que os silos serão aplicados
create table propriedade (
idPropriedade int primary key auto_increment,
nome varchar(45) not null,
proprietario varchar(45) null,
CEP varchar(8) not null,
fkUsuario int not null,
constraint fk_Usuario_Propriedade foreign key (fkUsuario) references usuario (idUsuario)
);

-- Dados inseridos na tabela propriedade
insert into propriedade (nome,proprietario,CEP, fkUsuario)
values ('Grãos Porte','Ailton Menezes','06541215', 1),
('Outra Soja','Lucas Nobrega','06541215', 2),
('Nova Grains','Raissa Martins','06541215', 3),
('Agro Grãos','Moacir Estefano','06541215', 4),
('Plante Grains','Silvia Montes','06541215', 5),
('Natura Grãos','Carlos Silva','06541215', 6 );

-- Tabela de Silos, interligada com a propriedade para qual será destinada (capacidade em toneladas)
create table silos (
idSilo int primary key auto_increment,
tipo varchar(45) not null,
capacidade_Max int not null,
sensores varchar(45) not null,
fkPropriedade int not null,
constraint fk_Propriedade_Silos foreign key (fkPropriedade) references propriedade (idPropriedade)
);

insert into silos (tipo, capacidade_Max, sensores,fkPropriedade )
values('metálico','60','LM35 e DHT11',1),
('metálico','80','LM35 e DHT11',2),
('metálico','60','LM35 e DHT11',3),
('metálico','60','LM35 e DHT11',4),
('metálico','80','LM35 e DHT11',5),
('metálico','60','LM35 e DHT11',6);

-- Tabela dos sensores, interligado a tabela silos
create table sensor (
idSensor int primary key auto_increment,
tipo varchar(45) not null,
quantidade int not null,
fkSilo int not null,
constraint fk_silo_sensor foreign key (fkSilo) references silos (idSilo),
constraint check_tipo check (tipo in ('LM35','DHT11'))
);

insert into sensor(tipo,quantidade,fksilo)
values('LM35',4,1),
('DHT11',4,1),
('LM35',3,2),
('DHT11',3,2),
('LM35',2,3),
('DHT11',2,3),
('LM35',4,4),
('DHT11',4,4),
('LM35',2,5),
('DHT11',2,5),
('LM35',4,6),
('DHT11',4,6);

-- Tabela para a leitura dos sensores com auxilia da API
create table leituraSensor (
id int primary key auto_increment,
temperaturaDht float not null,
umidadeDht float not null,
temperaturaLm float not null,
dataHora datetime null,
fkSensor int null,
constraint fk_sensor_leitura foreign key (fkSensor) references sensor (idSensor)
);


-- Selecionar todos os dados de cada tabela
select * from usuario;
select * from endereco;
select * from propriedade;
select * from silos;
select * from sensor;
select * from leituraSensor;


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
