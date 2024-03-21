-- CRIANDO DATABASE COM O COMANDO "CREATE"
CREATE DATABASE 7Sojas;

-- USAR DATABASE COM O COMANDO "USE"
USE 7Sojas;

-- CRIANDO TABELA DO USUARIO COM "CREATE TABLE"
CREATE TABLE usuario (
idUsuario INT PRIMARY KEY,
nomeEmpresa varchar(45),
emailEmpresa varchar(45) unique, 
senhaEmpresa varchar(20)
);

-- INSERINDO INFORMACOES NA TABLEA COM "INSERT INTO+NOME DA TABELA
insert into usuario(idUsuaruio, nomeEmpresa, emailEmpresa, senhaEmpresa) 
values(1, 'Sojas Brasil', 'brasilsojas@gmail.com', 'Sojasbrasil0000'),
(2, 'Tony-Silos', 'silostony@gmail.com', 'tonysilos987'),
(3, 'Jsojas', 'jsojas@gmail.com', 'joanasojas777666');

-- EXIBIR OS DADOS DA TABELA COM O COMANDO "SELECT*FROM"
SELECT*FROM usuario;




-- CRIANDO SEGUNDA TABELA
create table silos (
idSilo INT PRIMARY KEY AUTO_INCREMENT,
numeroSilo INT, 
tamanhoSilo INT,
fkInformacoesUsuario VARCHAR(6),
CONSTRAINT fk_usuario FOREIGN KEY (fkUsuario) REFERENCES usuario(idUsuario)
);

-- COLOCANDO INFORMACOES NA TABELA
insert into silos (numeroSilo, tamanhoSilo, fkUsuario)
 values ('si1', 1000, '1'),
('si2', 2000, '2'),
('si1', 500, '1'),
('si3', 720, '3');


-- EXIBIR INFORMAÇÕES DA TABELA DE SILOS
select * from silos;

-- CRIANDO TERCEIRA TABELA
CREATE TABLE sensores (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
numSensor INT,
dtInstalacao DATE,
tipoSensor VARCHAR(1) NOT NULL,
fkSilo INT,
fkUsuario INT,
constraint check (tipoSensor in('T', 'U')),
constraint fk_silo foreign key (fkSilo) references silos(idSilo)
);

-- INSERINDO INFORMACOES DOS SENSORES DE UMIDADE "U"
insert into sensores (serialSensor, numSensor, dtInstalacao, tipoSensor, fkSilo, fkUsuario) 
values('SU_1', 1, '2024-05-22', 'U', 'si1', 1),
('SU_1', 2, '2024-05-22', 'U', 'si1', 1),
('SU_3', 3, '2024-05-22', 'U', 'si1', 1),
('SU_4', 4, '2024-05-22', 'U', 'si1', 1),
('SU_5', 5, '2024-05-22', 'U', 'si1', 1),		
('SU_6', 1, '2024-05-22', 'U', 'si2', 1),
('SU_7', 2, '2024-05-22', 'U', 'si2', 1),
('SU_8', 3, '2024-05-22', 'U', 'si2', 1),
('SU_9', 4, '2024-05-22', 'U', 'si2', 1),
('SU_10', 5, '2024-05-22', 'U', 'si2', 1),
('SU_11', 1, '2023-12-31', 'U', 'si3', 1),
('SU_12', 2, '2023-12-31', 'U', 'si3', 2),
('SU_13', 3, '2023-12-31', 'U', 'si3', 2),
('SU_14', 4, '2023-12-31', 'U', 'si3', 2),
('SU_15', 5, '2023-12-31', 'U', 'si3', 2),
('SU_16', 1, '2024-01-30', 'U', 'si4', 3),
('SU_17', 2, '2024-01-30', 'U', 'si4', 3),
('SU_18', 3, '2024-01-30', 'U', 'si4', 3),
('SU_19', 4, '2024-01-30', 'U', 'si4', 3),
('SU_20', 5, '2024-01-30', 'U', 'si4', 3),
-- INSERINDO INFORMACOES DOS SENSORES DE TEMPERATURA "T"
('ST_1', 1, '2024-05-22', 'T', 'si_1', 1),
('ST_2', 2, '2024-05-22', 'T', 'si_1', 1),
('ST_3', 3, '2024-05-22', 'T', 'si_1', 1),
('ST_4', 4, '2024-05-22', 'T', 'si_1', 1),
('ST_5', 5, '2024-05-22', 'T', 'si_1', 1),
('ST_6', 1, '2024-05-22', 'T', 'si_2', 1),
('ST_7', 2, '2024-05-22', 'T','si_2', 1),
('ST_8', 3, '2024-05-22', 'T', 'si_2', 1),
('ST_9', 4, '2024-05-22', 'T', 'si_2', 1),
('ST_10', 5, '2024-05-22', 'T', 'si_2', 1),
('ST_11', 1, '2023-12-31', 'T', 'si_3', 2),
('ST_12', 2, '2023-12-31', 'T', 'si_3', 2),
('ST_13', 3, '2023-12-31', 'T', 'si_3', 2),
('ST_14', 4, '2023-12-31', 'T', 'si_3', 2),
('ST_15', 5, '2023-12-31', 'T','si_3', 2),
('ST_16', 1, '2024-01-30', 'T', 'si_4', 3),
('ST_17', 2, '2024-01-30', 'T', 'si_4', 3),
('ST_18', 3, '2024-01-30', 'T', 'si_4', 3),
('ST_19', 4, '2024-01-30', 'T', 'si_4', 3),
('ST_20', 5, '2024-01-30', 'T', 'si_4', 3);

-- EXIBIR INFORMAÇÕES DA TABELA DE SENSORES
SELECT* FROM sensores;

-- MOSTRANDO TABELA INSERINDO APELIDOS
SELECT*FROM usuario AS us
INNER JOIN silos as sl
inner join sensores as sn 
on sn.fkSilo = sl.idSilo
and sl.usuario = iu.idUsuario;

select us.nomeEmpresa, us.emailEmpresa, 
sl.numSilo, sl.tamanhoSilo,
sn.idSensor, sn.numSensor, sn.dtInstalacao, sn.tipoSensor 
from usuario as us
inner join silos as sl
inner join sensores as sn 
on sn.fkSilo = sl.idSilo 
and sl.fkInformacoesUsuario = iu.idAtivacao;

