-- CRIAR DATABASE NOMEADA "7SOJAS"
create database 7sojas;

-- USAR DATABASE NOMEADA "7SOJAS"
use 7sojas;

-- 1ª TABELA ========================================================

-- CRIAR UMA TABELA PARA ARMAZENAR INFORMAÇÕES DO USUÁRIO, 
-- TENDO O ID DE ATIVAÇÃO DE CONTA DO USUÁRIO COMO CHAVE PRIMÁRIA
create table informacoesUsuario (
idAtivacao varchar(6) primary key,
nomeUsuario varchar(45),
emailUsuario varchar(75) unique, 
-- "UNIQUE" ESTÁ SENDO UTILIZADO PARA INFORMAR QUE ESSE VALOR (EMAIL) DEVE SER ÚNICO, NÃO PERMITINDO REPETIÇÃO NOS DADOS
senhaUsuario varchar(20)
);

-- INSERINDO AS INFORMAÇÕES NA TABELA USUÁRIO, COM O NOME DA EMPRESA, EMAIL E SENHA
insert into informacoesUsuario(idAtivacao, nomeUsuario, emailUsuario, senhaUsuario) values
('#7S001', 'Samil', 'samil@gmail.com', 'S4M1LGR40S'),
('#7S002', 'Soya Silo', 'soyasilo@gmail.com', '#S0YM0SSYL0S'),
('#7S003', 'GNova', 'wgnova@gmail.com', 'GN0VAEHFUTUR0!');

-- EXIBIR DADOS INSERIDOS NA TABELA DE USUÁRIO
select * from informacoesUsuario;


-- 2ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SILOS CONTENDO INFORMAÇÕES DO ID DO SILO, NUMERO DE SILOS E TAMANHO DOS SILOS
-- ALÉM DE OBTER UMA CHAVE ESTRANGEIRA RETIRADA DA 1ª TABELA, ONDE ELA PUXA >SOMENTE< A CHAVE PRIMÁRIA DA TABELA ANTERIOR
create table silos (
idSilo int primary key auto_increment,
numSilo int, 
tamanhoSilo int,
fkInformacoesUsuario varchar(6),
-- CHAVES ESTRANGEIRAS COSTUMAM VIR COMO "NULL" NAS TABELAS
constraint fk_informacoes_usuario foreign key (fkinformacoesUsuario) references informacoesUsuario(idAtivacao)
-- CONSTRAINT SÃO OS REGRAS EM UMA TABELA DEFININDO SUA CHAVE (primary, foreign) E VALOR (null, not null),
-- ALÉM DE FAZER VALIDAÇÃO DE INFORMAÇÕES (check), uma vez que a regra é criada pela constraint na tabela,
-- essa regra poderá ser reutilizada em outras tabelas posteriores
);

-- QUANDO UM VALOR É AUTO_INCREMENT OU NULL, NÃO É NECESSÁRIO COLOCAR SEUS DADOS NA TABELA, POIS ELES SE PREENCHEM SOZINHOS
-- SE NÃO TIVESSE DEFINIDO OS VALORES DA CHAVE ESTRANGEIRA (ULTIMA COLUNA) ABAIXO, OS VALORES SERIAM NULOS
-- É BOM DEFINIR PARA QUESTÃO DE ORGANIZAÇÃO DA TABELA
insert into silos (numSilo, tamanhoSilo, fkInformacoesUsuario) values
(1, 1000, '#7S001'),
(2, 2000, '#7S001'),
(1, 500, '#7S002'),
(1, 720, '#7S003');


-- EXIBIR INFORMAÇÕES DA TABELA DE SILOS
select * from silos;

-- 3ª TABELA ========================================================

-- CRIAR UMA TABELA PARA OS SENSORES, ONDE CONTEM O NÚMERO CEREAL DO SENSOR (NUMERO ÚNICO DE IDENTIFICAÇÃO,
-- ESCOLHI DEIXAR UM LIMITE DE CARÁCTER DE 5 PARA DIVIDIR OS NUMEROS CEREAIS EM ST000 (SENSOR TEMPERATURA) OU SU000 (SENSOR UMIDADE)
-- COLOCAMOS A CHAVE ESTRANGEIRA DA 2ª TABELA PARA LIGAR O NÚMERO DO SILO COM OS SENSORES APROPRIADOS,
-- TAMBÉM COLOCAMOS NOVAMENTE AS INFORMAÇÕES DE USUÁRIO PARA LIGAÇÃO DE CLAREZA NA ORGANIZAÇÃO DOS DADOS
create table sensores (
serialSensor varchar(5) primary key,
numSensor int,
dtInstalacao date,
tipoSensor varchar(1) not null,
fkSilo int,
fkInformacoesUsuario varchar(6),
constraint check (tipoSensor in('T', 'U')),
-- É DADO UM CHECK PARA GARANTIR QUE OS TIPOS DE SENSORES SEJAM SOMENTE TEMPERATURA (T) E/OU UMIDADE (U)
constraint fk_silo foreign key (fkSilo) references silos(idSilo)
);

-- FOI ADICIONADO CINCO SENSORES DE UMIDADE E CINCO SENSORES DE TEMPERATURA POR SILO
-- OU SEJA, QUEM TEM DOIS SILOS, OBTÉM VINTE VALORES DE SENSOR NO TOTAL
insert into sensores (serialSensor, numSensor, dtInstalacao, tipoSensor, fkSilo, fkInformacoesUsuario) values
-- A ORGANIZAÇÃO DOS DADOS FOI FEITA DA SEGUINTE FORMA:
-- PRIMEIRO COLOCAMOS OS NÚMEROS CEREAIS DOS SENSORES DE UMIDADE, COLOCANDO A QUANTIDADE, 
-- DATA DE INSTALAÇÃO, TIPO DE SENSOR, A QUAL ID DE SILO ELE PERTENCE E A QUAL ID DE ATIVAÇÃO PERTENCE
('SU001', 1, '2024-02-13', 'U', 1, '#7S001'),
('SU002', 2, '2024-02-13', 'U', 1, '#7S001'),
('SU003', 3, '2024-02-13', 'U', 1, '#7S001'),
('SU004', 4, '2024-02-13', 'U', 1, '#7S001'),
('SU005', 5, '2024-02-13', 'U', 1, '#7S001'),
('SU006', 1, '2024-02-14', 'U', 2, '#7S001'),
('SU007', 2, '2024-02-14', 'U', 2, '#7S001'),
('SU008', 3, '2024-02-14', 'U', 2, '#7S001'),
('SU009', 4, '2024-02-14', 'U', 2, '#7S001'),
('SU010', 5, '2024-02-14', 'U', 2, '#7S001'),
('SU011', 1, '2023-12-31', 'U', 3, '#7S002'),
('SU012', 2, '2023-12-31', 'U', 3, '#7S002'),
('SU013', 3, '2023-12-31', 'U', 3, '#7S002'),
('SU014', 4, '2023-12-31', 'U', 3, '#7S002'),
('SU015', 5, '2023-12-31', 'U', 3, '#7S002'),
('SU016', 1, '2024-01-30', 'U', 4, '#7S003'),
('SU017', 2, '2024-01-30', 'U', 4, '#7S003'),
('SU018', 3, '2024-01-30', 'U', 4, '#7S003'),
('SU019', 4, '2024-01-30', 'U', 4, '#7S003'),
('SU020', 5, '2024-01-30', 'U', 4, '#7S003'),
-- LOGO APÓS É INSERIDO OS VALORES DE SENSOR DE TEMPERATURA, SEGUINDO O MESMO ESQUEMA DO ANTERIOR,
-- COMEÇANDO A PARTIR DO 001 POR SER UM NÚMERO CEREAL DIFERENTE
('ST001', 1, '2024-02-13', 'T', 1, '#7S001'),
('ST002', 2, '2024-02-13', 'T', 1, '#7S001'),
('ST003', 3, '2024-02-13', 'T', 1, '#7S001'),
('ST004', 4, '2024-02-13', 'T', 1, '#7S001'),
('ST005', 5, '2024-02-13', 'T', 1, '#7S001'),
('ST006', 1, '2024-02-14', 'T', 2, '#7S001'),
('ST007', 2, '2024-02-14', 'T', 2, '#7S001'),
('ST008', 3, '2024-02-14', 'T', 2, '#7S001'),
('ST009', 4, '2024-02-14', 'T', 2, '#7S001'),
('ST010', 5, '2024-02-14', 'T', 2, '#7S001'),
('ST011', 1, '2023-12-31', 'T', 3, '#7S002'),
('ST012', 2, '2023-12-31', 'T', 3, '#7S002'),
('ST013', 3, '2023-12-31', 'T', 3, '#7S002'),
('ST014', 4, '2023-12-31', 'T', 3, '#7S002'),
('ST015', 5, '2023-12-31', 'T', 3, '#7S002'),
('ST016', 1, '2024-01-30', 'T', 4, '#7S003'),
('ST017', 2, '2024-01-30', 'T', 4, '#7S003'),
('ST018', 3, '2024-01-30', 'T', 4, '#7S003'),
('ST019', 4, '2024-01-30', 'T', 4, '#7S003'),
('ST020', 5, '2024-01-30', 'T', 4, '#7S003');

-- EXIBIR INFORMAÇÕES DA TABELA DE SENSORES
select * from sensores;

-- APÓS INSERIR TODOS OS DADOS, UTILIZAMOS O INNER JOIN PARA CONCATENAR (JUNTAR) DADOS DAS TABELAS
-- COM O COMANDO "AS", DEFINIMOS APELIDOS PARA AS NOSSAS TABELAS
select * from informacoesUsuario as iu
-- INNER JOIN É USADO COMO UM "PEGUE TAMBÉM DESSA TABELA"
inner join silos as sl
inner join sensores as sn 
-- APÓS O INNER JOIN, É COLOCADO O COMANDO "ON" PARA COMPARAÇÃO, SE OS DADOS SÃO EQUIVALENTES
-- NAS TABELAS SELECIONADAS, OS RESULTADOS SÃO EXIBIDOS DE MANEIRA MAIS ORGANIZADA
-- EX: SE O VALOR DA CHAVE ESTRANGEIRA REFERENTE AO ID DOS SILOS NA TABELA SENSORES
-- FOR IGUAL AO VALOR DA CHAVE PRIMÁRIA REFERENTE AO ID DOS SILOS NA TABELA SILOS, OS RESULTADOS APARECEM
on sn.fkSilo = sl.idSilo
-- "AND" É UTILIZADO PELO FATO DE EXISTIR MAIS DE DUAS TABELAS A SEREM RELACIONADAS,
-- ENTÃO DIZEMOS QUE SE O VALOR ANTERIOR FOR CORRETO E ESSE TAMBÉM, OS RESULTADOS APARECEM
-- EX: SE O VALOR DA CHAVE ESTRANGEIRA REFERENTE AO ID DE ATIVAÇÃO DA CONTA DO USUÁRIO NA TABELA SENSORES
-- FOR IGUAL AO VALOR DA CHAVE PRIMÁRIA REFERENTE AO ID DE ATIVAÇÃO NA TABELA USUÁRIO, OS RESULTADOS APARECEM  
and sl.fkInformacoesUsuario = iu.idAtivacao;

-- OUTRA VARIAÇÃO DE EXIBIÇÃO DE DADOS DE UMA MANEIRA MAIS LIMPA, ONDE É APRESENTADO
-- NOME E EMAIL DO USUARIO ("iu" É O APELIDO DA TABELA DE USUÁRIO, LOGO ADICIONO QUAL COLUNA QUERO DESSA TABELA)
select iu.nomeUsuario, iu.emailUsuario, 
-- NÚMERO DO SILO E TAMANHO DOS SILOS ("sl" É O APELIDO DA TABELA DE SILOS, LOGO ADICIONO QUAL COLUNA QUERO DESSA TABELA)
sl.numSilo, sl.tamanhoSilo,
-- CÓDIGO CERAL, NÚMERO, DATA DE INSTALAÇÃO E TIPO DE SENSOR ("sn" É O APELIDO DA TABELA DE SENSORES, 
-- LOGO ADICIONO QUAL COLUNA QUERO DESSA TABELA)
sn.serialSensor, sn.numSensor, sn.dtInstalacao, sn.tipoSensor 
-- APÓS DEFINIR AS COLUNAS QUE QUERO VER, DEFINO OS APELIDOS DAS TABELAS E JUNTO AS INFORMAÇÕES DAS MESMAS
from informacoesUsuario as iu
inner join silos as sl
inner join sensores as sn 
-- PARA UMA APRESENTAÇÃO CLARA E CORRETA, DEFINO QUE OS VALORES DEVEM SER IGUAIS NAS TABELAS SELECIONADAS
on sn.fkSilo = sl.idSilo 
and sl.fkInformacoesUsuario = iu.idAtivacao;

-- PARA LIMPAR OS DADOS DAS TABELAS, USAMOS:
truncate table informacoesUsuario;
truncate table silos;
truncate table sensores;

-- PARA DELETAR AS TABELAS, USAMOS:
drop table informacoesUsuario;
drop table silos;
drop table sensores;


-- PARA FINALIZAR A OPERAÇÃO E EXCLUIR TODOS OS DADOS, USAMOS:
drop database 7sojas;