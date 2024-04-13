create database 7sojas;
use 7sojas;

create table empresa(
idEmpresa INT PRIMARY KEY auto_increment,
nomeEmpresa VARCHAR(60),
email 	VARCHAR(50) UNIQUE,
senha  VARCHAR (10),
qtdSilos INT
);

insert into empresa(idEmpresa, nomeEmpresa, email, senha, qtdSilos)
values (NULL, 'AgroTech','agrotech@gmail.com','123456AGRO','1'),
	   (NULL, 'VerdTech','verdtech@gmail.com','654321VERD','1'),
       (NULL, 'GardenTech','gardentech@gmail.com','9GARDEN','1'),
	   (NULL, 'farmTech','farmtech@gmail.com','farmtech1','2');
       
       SELECT * from empresa;


create table silos(
idSilos INT PRIMARY KEY auto_increment,
tamanhoSilo DECIMAL (5),
qtdSensores INT,
fk_Empresa INT,
CONSTRAINT fk_Empresa_silos foreign key (fk_Empresa) references empresa(IdEmpresa) -- cria
);

insert into silos (idSilos, tamanhoSilo, qtdSensores, fk_Empresa)
values (NULL, '10000','4', NULL), -- EMPRESA 1 (baseado na ordem de inserção)
	   (NULL, '5000','2', NULL ), -- EMPRESA 2
       (NULL, '5000','2', NULL ), -- EMPRESA 3
       (NULL, '5000','2', NULL ), -- EMPRESA 4
       (NULL, '5000','2', NULL ); -- EMPRESA 4
       
       
       update silos set fk_Empresa = 1 where idSilos = 1; -- EMPRESA 1 -- Silo 1 para Empresa 1
       update silos set fk_Empresa = 2 where idSilos = 2; -- EMPRESA 2 -- Silo 2 para Empresa 2
       update silos set fk_Empresa = 3 where idSilos = 3; -- EMPRESA 3 -- Silo 3 para Empresa 3
       update silos set fk_Empresa = 4 where idSilos = 4; -- EMPRESA 4 -- Silo 4 para Empresa 4
       update silos set fk_Empresa = 4 where idSilos = 5; -- EMPRESA 4 -- Silo 5 para Empresa 4

       select * from silos;


create table sensores(
idSensores INT PRIMARY KEY auto_increment,
tipoSensor VARCHAR (1),
dtInstalacao DATE,
fk_Silo INT, # Chave estrangeira que referencia a coluna idSilos na tabela silos
CONSTRAINT ck_tipoSensor check(tipoSensor in('T','U')), -- Restrição para tipoSensor (T=TEMPERATURA ou U=UMIDADE)
CONSTRAINT fk_Silos_sensores foreign key (fk_Silo) references Silos(IdSilos) -- Chave estrangeira
);

insert into sensores
values (NULL, 'T','2024-03-19', NULL), -- EMPRESA 1 -EMPRESA 1 TEM 4 SENSORES CONFORME A TABELA SILOS, 2 DE CADA (T E U)
	   (NULL, 'U','2024-03-19', NULL), -- EMPRESA 1
       (NULL, 'T','2024-03-19', NULL), -- EMPRESA 1
	   (NULL, 'U','2024-03-19', NULL), -- EMPRESA 1
       (NULL, 'T','2024-03-19', NULL), -- EMPRESA 2 -EMPRESA 2 TEM 2 SENSORES CONFORME A TABELA SILOS, 1 DE CADA (T E U)
	   (NULL, 'U','2024-03-19', NULL), -- EMPRESA 2 
       (NULL, 'T','2024-03-19', NULL), -- EMPRESA 3 
	   (NULL, 'U','2024-03-19', NULL), -- EMPRESA 3
       (NULL, 'T','2024-02-20', NULL), -- EMPRESA 4 -EMPRESA 4 TEM 2 SILOS CONFORME A TABELA EMPRESA E EM CADA SILO TEM 2 SENSORES CONFORME A TABELA SILOS, 2 DE CADA (T E U) --silo 1
       (NULL, 'U','2024-02-20', NULL), -- EMPRESA 4 
       (NULL, 'T','2024-02-20', NULL), -- EMPRESA 4 
	   (NULL, 'U','2024-02-20', NULL); -- EMPRESA 4 -EMPRESA 4 TEM 2 SILOS CONFORME A TABELA EMPRESA E EM CADA SILO TEM 2 SENSORES CONFORME A TABELA SILOS, 2 DE CADA (T E U) --silo 1
       
	update sensores set fk_Silo = 1 where idSensores = 1; -- EMPRESA 1 -- NO FK_SILO 1 SERÁ INSERIDO O SENSOR DE ID = 1 até ID= 4
	update sensores set fk_Silo = 1 where idSensores = 2; -- EMPRESA 1
    update sensores set fk_Silo = 1 where idSensores = 3; -- EMPRESA 1
    update sensores set fk_Silo = 1 where idSensores = 4; -- EMPRESA 1
    update sensores set fk_Silo = 2 where idSensores = 5; -- EMPRESA 2
    update sensores set fk_Silo = 2 where idSensores = 6; -- EMPRESA 2
    update sensores set fk_Silo = 3 where idSensores = 7; -- EMPRESA 3
    update sensores set fk_Silo = 3 where idSensores = 8; -- EMPRESA 3
    update sensores set fk_Silo = 4 where idSensores = 9; -- EMPRESA 4 -- A EMPRESA TEM 2 SILOS, NO FK_SILO 4 SERÁ INSERIDO O SENSOR DE ID = 9 até ID= 10
    update sensores set fk_Silo = 4 where idSensores = 10; -- EMPRESA 4
    update sensores set fk_Silo = 5 where idSensores = 11; -- EMPRESA 4 -- A EMPRESA TEM 2 SILOS, NO FK_SILO 5 SERÁ INSERIDO O SENSOR DE ID = 1 até ID= 12
    update sensores set fk_Silo = 5 where idSensores = 12; -- EMPRESA 4
    
	select * from sensores;


# Explicação 
select * -- Seleciona todas as colunas
from empresa as emp -- Seleciona da tabela `empresa` com o alias(APELIDO) `emp`
inner join sensores as sen -- Faz uma conexão com a tabela `sensores` com o alias `sen`
inner join silos as si -- Faz uma conexão com a tabela `silos` com o alias `si`
on sen.fk_Silo = si.IdSilos -- A coluna `fk_Silo` da tabela `sensores` é igual à coluna `IdSilos` da tabela `silos`
and si.fk_Empresa = emp.IdEmpresa; -- E a coluna `fk_Empresa` da tabela `silos` é igual à coluna `IdEmpresa` da tabela `empresa`


select * from empresa as emp
inner join sensores as sen 
inner join silos as si on sen.fk_Silo = si.IdSilos and si.fk_Empresa = emp.IdEmpresa;

-- INNER JOIN SEM APELIDOS
select idEmpresa, nomeEmpresa, email, qtdSilos, idSensores, tipoSensor, idSilos, qtdSensores from empresa 
inner join sensores 
inner join silos on sensores.fk_Silo = silos.IdSilos and silos.fk_Empresa = empresa.IdEmpresa;


drop database 7sojas;

