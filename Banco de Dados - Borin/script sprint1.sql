create database 7Sojas;
use 7Sojas;

-- Tabela Usuario
create table Usuario(
idUsuario int primary key auto_increment,
nome varchar(45),
email varchar(45),
senha varchar(45)
);

-- Inserção de valores na tabela Usuario
insert into Usuario values
(null, 'Guilherme', 'guilherme@gmail.com', 'senha12345'),
(null, 'Maykon', 'maykon@gmail.com', 'senha43210'),
(null, 'Yasmim', 'yasmim@gmail.com', 'senha01010'),
(null, 'Walleska', 'walleska@gmail.com', 'senha11111'),
(null, 'Davi', 'Davi@gmail.com', 'senha55555');
 
-- Tabela Silo 
create table Silo(
idSilo int primary key,
qtdSilo varchar(45),
tamanho varchar(45),
fkUsuario int,
constraint fkUsuario_Silo foreign key (fkUsuario) references Usuario (idUsuario)
);

-- Inserção de valores na tabela Silo
insert into Silo(idSilo, qtdSilo, tamanho, fkUsuario) values
(1, 3, 700, 1),
(2, 2, 600, 2),
(3, 1, 500, 3),
(4, 3, 850, 4),
(5, 2, 800, 5); 

-- Exibitr informações da table Silo
select * from Silo;  

-- Tabela Sensor
create table Sensor(
idSensor int primary key,
dataInstalacao date,
tipoSensor varchar(45),
fkSilo int,
constraint check(tipoSensor in('Temperatura','Umidade')),
constraint fkSilo_Sensor foreign key (fkSilo) references Silo (idSilo)
);

-- Inserção de valores na tabela Sensor
insert into Sensor(idSensor, dataInstalacao, tipoSensor, fkSilo) values 
(1, '2024-03-19', 'Temperatura', 5),
(2, '2003-07-20', 'Umidade', 4) ,
(3, '2004-09-17', 'Umidade', 3),
(4, '2006-02-15', 'Temperatura', 2),
(5, '2021-09-08', 'Temperatura', 1);

-- Exibir dados da tabela usuario com
select U.*, S.*, Se.* from Usuario as U inner join Silo as S on S.fkUsuario = U.idUsuario inner join Sensor as Se on Se.fkSilo = S.idSilo;

drop database 7Sojas;





