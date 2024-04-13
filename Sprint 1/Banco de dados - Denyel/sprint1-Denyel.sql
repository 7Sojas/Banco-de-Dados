create database 7Sojas;
use 7Sojas;
create table empresa (
idEmpresa int primary key auto_increment,
Nome varchar(45) not null,
qtdSilos INT not null
);

insert into empresa ( Nome, qtdSilos) Values
("SojasBrasil", 2),
("SojasSol", 1),
("SacaSojas", 3),
("12Sojas", 1),
("triSoja", 1);
select * from empresa;

create table Silos (
idSilos int primary key auto_increment,
tamanho decimal(7,2),
idEmpresa INT,
constraint idEmpresa_Silos foreign key(idEmpresa) references empresa(idEmpresa));
select * from Silos;

insert into Silos (tamanho, idEmpresa) Values
(1200, 1),
(1520, 2),
(1300, 3),
(200, 4),
(160, 5);
select * from Silos;
drop table Silos;

create table Sensores (
tipo int primary key auto_increment,
qtdSensores int,
idEmpresa INT,
constraint idEmpresa_Sensores foreign key(idEmpresa) references empresa(idEmpresa));



insert into Sensores(qtdSensores, idEmpresa) Values
(15, 1),
(5, 2),
(1, 3),
(10, 4),
(25, 5);
SELECT Silos.*, empresa.Nome AS NomeEmpresa
FROM Silos
INNER JOIN empresa ON Silos.idEmpresa = empresa.idEmpresa
WHERE empresa.Nome = 'SojasBrasil';



SELECT * FROM empresa as em INNER JOIN Silos as si
Inner JOIN Sensores as se on se.idEmpresa = si.idSilos and si.idEmpresa = em.idEmpresa;


 