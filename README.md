# Trabalho-BD

Script mais atualizado do Schema de Banco de Dados para trabalho da Disciplina de Banco de Dados da Universidade de Brasília
Banco Utilizado: MySQL
Implementação do BackEnd em PHP

DROP TABLE IF EXISTS RA CASCADE;
DROP TABLE IF EXISTS Temperatura CASCADE;
DROP TABLE IF EXISTS Umidade CASCADE;
DROP TABLE IF EXISTS Precipitacao CASCADE;
DROP TABLE IF EXISTS Pressao_Atm CASCADE;
DROP TABLE IF EXISTS Ventos CASCADE;
DROP TABLE IF EXISTS Nebulosidade CASCADE;
DROP TABLE IF EXISTS Est_Nebulosidade CASCADE;
DROP TABLE IF EXISTS Insolacao CASCADE;
DROP TABLE IF EXISTS Evaporacao CASCADE;
DROP TABLE IF EXISTS Bairro CASCADE;
DROP TABLE IF EXISTS Alagamento CASCADE;

CREATE TABLE RA
    (codRA      INTEGER UNSIGNED PRIMARY KEY,
    nome        VARCHAR(30) NOT NULL,
    populacao   INTEGER UNSIGNED,
    data_criacao DATE);

CREATE TABLE Temperatura
    (data_temp    VARCHAR(7),
    codRA       INTEGER REFERENCES RA(codRA),
    temp_Med    INTEGER NOT NULL,
    temp_Max    INTEGER NOT NULL,
    temp_Min    INTEGER NOT NULL,
    id_temp		INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Umidade
    (data_umi    VARCHAR(7),
    codRA       INTEGER REFERENCES RA(codRA),
    umi_Med     INTEGER UNSIGNED NOT NULL,
    umi_Max     INTEGER UNSIGNED NOT NULL,
    umi_Min     INTEGER UNSIGNED NOT NULL,
	id_umi 		INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Precipitacao
    (mes    VARCHAR(9) NOT NULL,
    codRA       INTEGER REFERENCES RA(codRA),
    precipit_Med    FLOAT UNSIGNED NOT NULL,
	id_precipit  INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Pressao_Atm
    (mes    	VARCHAR(9) NOT NULL,
    codRA       INTEGER REFERENCES RA(codRA),
    patm_Med    FLOAT UNSIGNED NOT NULL,
	id_patm INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Ventos
    (mes    VARCHAR(9) NOT NULL,
    codRA       INTEGER REFERENCES RA(codRA),
    vel_Med     FLOAT UNSIGNED NOT NULL,
	id_vel INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Est_Nebulosidade
    (codNeb     INTEGER UNSIGNED PRIMARY KEY,
    descricao        VARCHAR(15) NOT NULL);

CREATE TABLE Nebulosidade
    (mes    VARCHAR(9) NOT NULL,
    codRA       INTEGER REFERENCES RA(codRA),
    ceu_encoberto   FLOAT UNSIGNED NOT NULL,
	codNeb     INTEGER REFERENCES Est_Nebulosidade(codNeb),
	id_neb INTEGER PRIMARY KEY AUTO_INCREMENT);
    
CREATE TABLE Insolacao
	(mes 		VARCHAR(9) NOT NULL,
    codRA		INTEGER REFERENCES RA(codRA),
    ins_med 	FLOAT UNSIGNED NOT NULL,
    id_ins		INTEGER PRIMARY KEY AUTO_INCREMENT);
    
CREATE TABLE Evaporacao
	(mes		VARCHAR(9) NOT NULL,
    codRA		INTEGER REFERENCES RA(codRA),
    evap_med	FLOAT UNSIGNED NOT NULL,
    id_evap		INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Bairro
    (codBairro INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codRA      INTEGER REFERENCES RA(codRA),
    nome_bairro       VARCHAR(30) NOT NULL);

CREATE TABLE Alagamento
    (codAlagamento INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codBairro  INTEGER REFERENCES Bairro(codBairro),
    dia 	   DATE NOT NULL,
    rua        VARCHAR(30) NOT NULL,
    inicio	   VARCHAR(5),
    fim		   VARCHAR(5),
    imagem     BLOB);
    
    
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (1, 'Plano Piloto', 210000, '1960-04-21');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (2, 'Gama', 134000, '1960-10-12');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (3, 'Taguatinga', 207000, '1958-06-05');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (4, 'Brazlandia', 51000, '1933-06-05');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (5, 'Sobradinho', 62000, '1960-05-13');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (20, 'Aguas Claras', 138000, '1992-04-08');
INSERT INTO ra(codRA, nome, populacao, data_criacao) VALUES (30, 'Vicente Pires', 75000, '2008-05-26');

INSERT INTO temperatura(mes_Ano, codRA, temp_Med, temp_Max, temp_Min) VALUES ('06-2019', 1, 19, 28, 11);
INSERT INTO temperatura(mes_Ano, codRA, temp_Med, temp_Max, temp_Min) VALUES ('10-2018', 20, 25, 29, 18);
INSERT INTO temperatura(mes_Ano, codRA, temp_Med, temp_Max, temp_Min) VALUES ('03-2016', 2, 22, 28, 17);
INSERT INTO temperatura(mes_Ano, codRA, temp_Med, temp_Max, temp_Min) VALUES ('06-2006', 1, 18, 27, 12);
INSERT INTO temperatura(mes_Ano, codRA, temp_Med, temp_Max, temp_Min) VALUES ('01-2012', 3, 21, 25, 17);

INSERT INTO umidade(mes_Ano, codRA, umi_Med, umi_Max, umi_Min) VALUES ('01-2012', 1, 78, 92, 58);
INSERT INTO umidade(mes_Ano, codRA, umi_Med, umi_Max, umi_Min) VALUES ('04-2016', 3, 61, 87, 55);
INSERT INTO umidade(mes_Ano, codRA, umi_Med, umi_Max, umi_Min) VALUES ('08-2014', 5, 34, 52, 18);
INSERT INTO umidade(mes_Ano, codRA, umi_Med, umi_Max, umi_Min) VALUES ('12-2018', 2, 73, 90, 48);
INSERT INTO umidade(mes_Ano, codRA, umi_Med, umi_Max, umi_Min) VALUES ('09-2013', 20, 37, 79, 20);

INSERT INTO precipitacao(mes, codRA, precipit_Med) VALUES ('Janeiro', 2, 247.4);
INSERT INTO precipitacao(mes, codRA, precipit_Med) VALUES ('Maio', 3, 38.6);
INSERT INTO precipitacao(mes, codRA, precipit_Med) VALUES ('Junho', 1, 8.7);
INSERT INTO precipitacao(mes, codRA, precipit_Med) VALUES ('Dezembro', 20, 246);
INSERT INTO precipitacao(mes, codRA, precipit_Med) VALUES ('Setembro', 2, 55.2);

INSERT INTO pressao_atm(mes, codRA, patm_Med) VALUES ('Agosto', 3, 888.2);
INSERT INTO pressao_atm(mes, codRA, patm_Med) VALUES ('Setembro', 1, 887.2);
INSERT INTO pressao_atm(mes, codRA, patm_Med) VALUES ('Fevereiro', 20, 885.4);
INSERT INTO pressao_atm(mes, codRA, patm_Med) VALUES ('Junho', 2, 888.7);
INSERT INTO pressao_atm(mes, codRA, patm_Med) VALUES ('Dezembro', 5, 884.8);

INSERT INTO ventos(mes, codRA, vel_Med) VALUES ('Maio', 1, 12.964);
INSERT INTO ventos(mes, codRA, vel_Med) VALUES ('Agosto', 5, 14.816);
INSERT INTO ventos(mes, codRA, vel_Med) VALUES ('Dezembro', 20, 12.964);
INSERT INTO ventos(mes, codRA, vel_Med) VALUES ('Janeiro', 2, 13.465);
INSERT INTO ventos(mes, codRA, vel_Med) VALUES ('Outubro', 3, 14.816);

INSERT INTO est_nebulosidade(codNeb, nome) VALUES (1, 'Limpo');
INSERT INTO est_nebulosidade(codNeb, nome) VALUES (2, 'Quase limpo');
INSERT INTO est_nebulosidade(codNeb, nome) VALUES (3, 'Pouco nublado');
INSERT INTO est_nebulosidade(codNeb, nome) VALUES (4, 'Parcia. nublado');
INSERT INTO est_nebulosidade(codNeb, nome) VALUES (5, 'Quase nublado');
INSERT INTO est_nebulosidade(codNeb, nome) VALUES (6, 'Nublado');

INSERT INTO nebulosidade(mes, codRA, ceu_encoberto, codNeb) VALUES ('Julho', 2, 0.2, 2);
INSERT INTO nebulosidade(mes, codRA, ceu_encoberto, codNeb) VALUES ('Fevereiro', 1, 0.7, 5);
INSERT INTO nebulosidade(mes, codRA, ceu_encoberto, codNeb) VALUES ('Marco', 20, 0.7, 5);
INSERT INTO nebulosidade(mes, codRA, ceu_encoberto, codNeb) VALUES ('Setembro', 3, 0.4, 3);
INSERT INTO nebulosidade(mes, codRA, ceu_encoberto, codNeb) VALUES ('Maio', 5, 0.5, 4);

INSERT INTO insolacao(mes, codRA, ins_Med) VALUES ('Maio', 4, 234.3);
INSERT INTO insolacao(mes, codRA, ins_Med) VALUES ('Julho', 2, 266.5);
INSERT INTO insolacao(mes, codRA, ins_Med) VALUES ('Janeiro', 1, 154.4);
INSERT INTO insolacao(mes, codRA, ins_Med) VALUES ('Outubro', 20, 168.2);
INSERT INTO insolacao(mes, codRA, ins_Med) VALUES ('Agosto', 4, 262.9);

INSERT INTO evaporacao(mes, codRA, evap_Med) VALUES ('Marco', 3, 112.7);
INSERT INTO evaporacao(mes, codRA, evap_Med) VALUES ('Julho', 2, 192.2);
INSERT INTO evaporacao(mes, codRA, evap_Med) VALUES ('Setembro', 3, 242.1);
INSERT INTO evaporacao(mes, codRA, evap_Med) VALUES ('Dezembro', 5, 103.2);
INSERT INTO evaporacao(mes, codRA, evap_Med) VALUES ('Fevereiro', 1, 105);

INSERT INTO bairro(codRA, nome) VALUES (1, 'SQN 204');
INSERT INTO bairro(codRA, nome) VALUES (1, 'SQN 309');
INSERT INTO bairro(codRA, nome) VALUES (30, 'Chacara 53');
INSERT INTO bairro(codRA, nome) VALUES (1, 'SQN 201');
INSERT INTO bairro(codRA, nome) VALUES (1, 'SQN 215');

INSERT INTO alagamento(codBairro, dia, rua, inicio, fim, imagem) VALUES (3, '2019-05-02', 'Israel Pinheiro', '12:20', '18:30', 'C:/Users/pvmiz/Desktop/alagamento1.png');
INSERT INTO alagamento(codBairro, dia, rua, inicio, fim, imagem) VALUES (4, '2014-12-17', 'Comercial 201', '17:00', '21:00', 'C:/Users/pvmiz/Desktop/alagamento2.png');
INSERT INTO alagamento(codBairro, dia, rua, inicio, fim) VALUES (5, '2014-12-17', 'Tesourinha 215', '18:00', '21:00');
