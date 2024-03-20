-- criar database 7sojas
create database 7sojas;

-- usando a database criada
use 7sojas;

-- primeira tabela, empresa, que irá conter informações de login do usuario

create table empresa(
idEmpresa int primary key auto_increment,
nomeEmpresa varchar(60),
emailEmpresa varchar(50),
senhaEmpresa varchar (15)
);

insert into empresa
values (null, 'SojaFarm','sojafarm@yahoo.com','fazenda4567'),
	   (null, 'FlexAgro','flexagro@yahoo.com','987agropecuaria'),
       (null, 'PagSoja','pagsoja@yahoo.com','123paganinisoja');
       
       select * from empresa;


create table silos(
idSilos int primary key auto_increment,
tamanhoSilo decimal (5),
qtdSensores int,
fk_Empresa int,
constraint fk_Empresa_silos foreign key (fk_Empresa) references empresa(IdEmpresa)
);

insert into silos
values (null, '7000','1', 1),
	   (null, '8000','3', 2),
       (null, '10000','2', 3);
	
       select * from silos;

create table sensores(
idSensores int primary key auto_increment,
tipoSensor varchar (1),
numeroSensor int,
dtInstalacao datetime,
fk_Silo int,
constraint ck_tipoSensor check(tipoSensor in('T','U')),
constraint fk_Silos_sensores foreign key (fk_Silo) references Silos(IdSilos)
) auto_increment = 1000;

insert into sensores
values (null, 'T', 1, '2024-03-19', 1),
	   (null, 'U', 2, '2024-03-19', 1),
       (null, 'T', 1, '2024-05-21', 2),
       (null, 'U', 2, '2024-05-21', 2),
       (null, 'T', 1, '2024-09-06', 3),
       (null, 'U', 2, '2024-09-06', 3);

	select * from empresa as em
	inner join silos as si
	inner join sensores as se on se.fk_Silo = si.idSilos and si.fk_Empresa = em.idEmpresa;
