-- Criação do banco de dados
drop database sojas7;

create database sojas7;
-- utilizar o banco
use sojas7;

-- Tabela usuário, onde conterá todas as informções pertinentes para o cadastro do cliente em nosso sistema
create table usuario (
id int primary key auto_increment,
nome varchar(50) not null,	
email varchar(80) not null,
cpf varchar(11) not null,
senha varchar(40) not null
);

-- Dados inseridos na tabela Usuario
insert into usuario (nome, email, cpf, senha)
values('Bianca Almeida', 'bialmeida@gmail.com', '42312343343', 'Bianca123@'),
('Murillo Rodrigues', 'murirodrigues@gmail.com', '25485698512', 'Murillo#123'),
('Gustavo Alencar', 'gusalencar@gmail.com', '96325874112', 'Gustavo*123'),
('Ana Beatriz Costa', 'anabeacosta@gmail.com', '54687932145', 'Ana@#123'),
('Miguel Pinho', 'mipinho@gmail.com', '96478512354', 'Miguel#123'),
('Davi de Souza', 'davisouza@gmail.com', '15975365487', 'Davi@123*');


-- Tabela endereço que se relacionará com a tabela Usuário 
create table endereco (
id int primary key auto_increment,
logradouro varchar(50) not null,
numero int not null,
cep varchar(50) not null
);

-- Dados inseridos na tabela endereco
insert into endereco (logradouro,numero, cep)
values ('Rua Frei Caneca', 12,'01317122'),
('Rua Adalberto Sampaio', 432,'01421123'),
('Avenida Jupiter', 23,'03288012'),
('Rua Cachoeira Poraque', 325,'01211001'),
('Rua Trilho Alto', 112,'02020123'),
('Rua Rio Bravo', 2443,'04141000');


--  a Tabela Propriedade onde o usuário irá informa onde se encontra a fazenda em que os silos serão aplicados
create table propriedade (
id int primary key auto_increment,
nome varchar(45) not null,
proprietario varchar(45) null,
fkEndereco int not null,
fkUsuario int not null,
constraint fk_endereco_propriedade foreign key (fkEndereco) references endereco (id),
constraint fk_usuario_propriedade foreign key (fkUsuario) references usuario (id)
);

-- Dados inseridos na tabela propriedade
insert into propriedade (nome,proprietario, fkEndereco, fkUsuario)
values ('Grãos Porte','Ailton Menezes', 1, 1),
('Outra Soja', 'Lucas Nobrega', 2, 2),
('Nova Grains', 'Raissa Martins', 3, 3),
('Agro Grãos', null, 4, 4),
('Plante Grains', 'Silvia Montes', 5, 5),
('Natura Grãos', null, 6, 6);

-- Tabela de Silos, interligada com a propriedade para qual será destinada (capacidade em toneladas)
create table silos (
id int primary key auto_increment,
tipo varchar(45) null,
temperaturaMax decimal(10, 2) not null,
temperaturaMin decimal(10, 2) not null,
umidadeMax decimal(10, 2) not null,
umidadeMin decimal(10, 2) not null,
fkPropriedade int not null,
constraint fk_propriedade_silos foreign key (fkPropriedade) references propriedade (id)
);

insert into silos (tipo, temperaturaMax, temperaturaMin, umidadeMax, umidadeMin, fkPropriedade )
values('metálico', '40', '30', '70', '60',1),
('metálico', '40', '30', '70', '60', 2),
('metálico', '39', '31', '70', '60', 3),
('metálico', '41', '29', '65', '55', 4),
('metálico', '38', '30', '60', '50', 5),
('metálico', '40', '30', '50', '40', 6);

-- Tabela dos sensores, interligado a tabela silos
create table sensor (
id int primary key auto_increment,
tipo varchar(45) not null,
fkSilo int not null,
constraint fk_silo_sensor foreign key (fkSilo) references silos (id),
constraint check_tipo check (tipo in ('LM35','DHT11', 'DHT11 e LM35'))
);

insert into sensor(tipo,fksilo)
values
('DHT11 e LM35', 1),
('DHT11 e LM35', 1),
('DHT11 e LM35', 1),
('DHT11 e LM35', 1),
('DHT11 e LM35', 2),
('DHT11 e LM35', 2),
('DHT11 e LM35', 2),
('DHT11 e LM35', 2),
('DHT11 e LM35', 3),
('DHT11 e LM35', 3),
('DHT11 e LM35', 3),
('DHT11 e LM35', 3),
('DHT11 e LM35', 4),
('DHT11 e LM35', 4),
('DHT11 e LM35', 4),
('DHT11 e LM35', 4);

-- select fkSilo por id do Sensor
select id from sensor where fkSilo = 1 and tipo = 'LM35';


-- Tabela para a leitura dos sensores com auxilia da API
create table leituraSensor (
id int primary key auto_increment,
umidadeDht float not null,
temperaturaLm float not null,
dataHora timestamp not null default current_timestamp,
fkSensor int not null,
constraint fk_sensor_leitura foreign key (fkSensor) references sensor (id)
);

-- Tabela para alertas de um determinado sensor
create table alerta (
id int primary key auto_increment,
alertaVermelho decimal(10,2),
alertaAmarelo decimal(10,2),
fkLeitura int not null,
constraint fk_leituraSensor_alerta foreign key (fkLeitura) references leituraSensor (id)
);

-- Selecionar todos os dados de cada tabela
select * from usuario;
select * from endereco;
select * from propriedade;
select * from silos;
select * from sensor;
select * from leituraSensor;

-- Selecionar os valores de temperatura, umidade e dataHora para determinado fkSensor
select * from leituraSensor where fkSensor = 1;
select * from leituraSensor where fkSensor = 2;
select * from leituraSensor where fkSensor = 3;
select * from leituraSensor where fkSensor = 4;

-- inner join iD sensor com dados do sensor;
select sens.id, leitura.umidadeDht, leitura.temperaturaLm, leitura.dataHora
from sensor sens
inner join leituraSensor leitura on leitura.fkSensor = sens.id;

select s.id Sensor, 
       ls.temperaturaLm Temperatura, 
       ls.umidadeDht Umidade, 
       ls.dataHora DataHora
from leituraSensor as ls
inner join sensor as s on s.id = ls.fkSensor
where fkSensor >= 1 and fkSensor <= 3;



select *
from propriedade p
inner join silos s on s.fkpropriedade = p.id
inner join sensor sen on sen.fksilo = s.id
inner join leituraSensor ls on ls.fkSensor = sen.id;