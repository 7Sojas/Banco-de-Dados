create database 7sojas;
use 7sojas;

create table informacoesUsuario (
idUsuario int primary key auto_increment,
nomeUsuario varchar(45),
emailUsuario varchar(75) unique,
senhaUsuario varchar(20)
);

insert into informacoesUsuario (nomeUsuario, emailUsuario, senhaUsuario) values
('Guilherme Borin', 'guilherme.borin@sptech.school', '#Gf43991404885'),
('Maykon Nogueira', 'maykon.nogueira@sptech.school', '#Gf54263326814'),
('Walleska Lima', 'walleska.lima@sptech.school', '#Gf50275643840');

select * from informacoesUsuario;

create table silos (
idSilo int primary key auto_increment,
qntSilo int, 
tamanhoSilo int,
fkInformacoesUsuario int,
constraint fk_informacoes_usuario foreign key (fkinformacoesUsuario) references informacoesUsuario(idUsuario)
);

insert into silos (qntSilo, tamanhoSilo, fkInformacoesUsuario) values
(2, 1000, 1),
(2, 1000, 1),
(1, 1000, 2),
(1, 1000, 3);

select * from silos;

create table sensores (
serialSensor varchar(5) primary key,
qtdSensor int,
dtInstalacao date,
tipoSensor varchar(1) not null,
fkSilo int,
fkInformacoesUsuario int,
constraint check (tipoSensor in('T', 'U')),
constraint fk_silo foreign key (fkSilo) references silos(idSilo)
);

insert into sensores (serialSensor, qtdSensor, dtInstalacao, tipoSensor, fkSilo, fkInformacoesUsuario) values
('SU001', 1, '2024-02-13', 'U', 1, 1),
('ST001', 1, '2024-02-13', 'T', 1, 1),
('SU002', 2, '2023-12-31', 'U', 2, 1),
('ST002', 2, '2023-12-31', 'T', 2, 1),
('SU003', 1, '2024-01-30', 'U', 3, 2),
('ST003', 1, '2024-01-30', 'T', 3, 2),
('SU004', 1, '2024-03-15', 'U', 4, 3),
('ST004', 1, '2024-03-15', 'T', 4, 3);


select * from informacoesUsuario as iu
inner join silos as sl
inner join sensores as sn on sn.fkSilo = sl.idSilo and sl.fkInformacoesUsuario = iu.idUsuario;


drop database 7sojas;