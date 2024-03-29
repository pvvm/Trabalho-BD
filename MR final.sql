CREATE DATABASE SID;

USE SID;

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
DROP VIEW IF EXISTS view_medias_anuais;
DROP PROCEDURE IF EXISTS calc_crit_umidade;

CREATE TABLE RA
    (codRA      INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome        VARCHAR(30) NOT NULL,
    populacao   INTEGER UNSIGNED,
    data_criacao DATE);

CREATE TABLE Temperatura
    (mes    VARCHAR(7),
    codRA       INTEGER REFERENCES RA(codRA),
    temp_Med    INTEGER NOT NULL,
    temp_Max    INTEGER NOT NULL,
    temp_Min    INTEGER NOT NULL,
    id_temp		INTEGER PRIMARY KEY AUTO_INCREMENT);

CREATE TABLE Umidade
    (mes    VARCHAR(7),
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
    nome       VARCHAR(30) NOT NULL);

CREATE TABLE Alagamento
    (codAlagamento INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codBairro  INTEGER REFERENCES Bairro(codBairro),
    dia 	   DATE NOT NULL,
    rua        VARCHAR(30) NOT NULL,
    inicio	   VARCHAR(5),
    fim		   VARCHAR(5),
    imagem     BLOB);
    
CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `view_medias_anuais` AS
    SELECT 
        CONCAT(TRUNCATE(AVG(`temperatura`.`temp_Min`),1),' °C') AS `Temp. minima`,
        CONCAT(TRUNCATE(AVG(`temperatura`.`temp_Med`),1),' °C') AS `Temp. media`,
        CONCAT(TRUNCATE(AVG(`temperatura`.`temp_Max`),1),' °C') AS `Temp. maxima`,
        CONCAT(TRUNCATE(AVG(`umidade`.`umi_Min`), 1),' %') AS `Umidade minima`,
        CONCAT(TRUNCATE(AVG(`umidade`.`umi_Med`), 1),' %') AS `Umidade media`,
        CONCAT(TRUNCATE(AVG(`umidade`.`umi_Max`), 1),' %') AS `Umidade maxima`,
        CONCAT(TRUNCATE(AVG(`pressao_atm`.`patm_Med`),1),' mm/Hg') AS `Press. atm.`,
        CONCAT(TRUNCATE(AVG(`precipitacao`.`precipit_Med`),1),' mm/m2') AS `Precipitacao`,
        CONCAT(TRUNCATE(AVG(`insolacao`.`ins_med`),1),' W/m2') AS `Insolacao atmosf.`,
        CONCAT(TRUNCATE(AVG(`evaporacao`.`evap_med`),1),' mm/m2') AS `Evaporacao`,
        TRUNCATE(AVG(`nebulosidade`.`ceu_encoberto`),1) AS `Indice de nebulosidade`,
        CONCAT(TRUNCATE(AVG(`ventos`.`vel_Med`),1),' km/h') AS `Intens. eolica`
    FROM
        (((((((`temperatura`
        JOIN `umidade`)
        JOIN `pressao_atm`)
        JOIN `insolacao`)
        JOIN `precipitacao`)
        JOIN `evaporacao`)
        JOIN `nebulosidade`)
        JOIN `ventos`);

DELIMITER //
CREATE DEFINER=`root`@`localhost` PROCEDURE `calc_crit_umidade`(OUT umi_normal INT, OUT umi_atencao INT, OUT umi_alerta INT, OUT umi_emergencia INT)
BEGIN
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min > 30
        INTO umi_normal;
        
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min <= 30 AND umi_Min > 20
        INTO umi_atencao;
        
	SELECT COUNT(umi_Min)
		FROM umidade
        WHERE umi_Min <= 20 AND umi_Min >= 12
        INTO umi_alerta;
        
	SELECT COUNT(umi_Min)
		FROM umidade
		WHERE umi_Min < 12
        INTO umi_emergencia;
END; //
DELIMITER ;

INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Plano Piloto', 210000, '1960-04-21');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Gama', 134000, '1960-10-12');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Taguatinga', 207000, '1958-06-05');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Brazlandia', 51000, '1933-06-05');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Sobradinho', 62000, '1960-05-13');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Aguas Claras', 138000, '1992-04-08');
INSERT INTO ra(nome, populacao, data_criacao) VALUES ('Vicente Pires', 75000, '2008-05-26');

INSERT INTO temperatura(mes, codRA, temp_Med, temp_Max, temp_Min) VALUES ('06-2019', 1, 19, 28, 11);
INSERT INTO temperatura(mes, codRA, temp_Med, temp_Max, temp_Min) VALUES ('10-2018', 20, 25, 29, 18);
INSERT INTO temperatura(mes, codRA, temp_Med, temp_Max, temp_Min) VALUES ('03-2016', 2, 22, 28, 17);
INSERT INTO temperatura(mes, codRA, temp_Med, temp_Max, temp_Min) VALUES ('06-2006', 1, 18, 27, 12);
INSERT INTO temperatura(mes, codRA, temp_Med, temp_Max, temp_Min) VALUES ('01-2012', 3, 21, 25, 17);

INSERT INTO umidade(mes, codRA, umi_Med, umi_Max, umi_Min) VALUES ('01-2012', 1, 78, 92, 58);
INSERT INTO umidade(mes, codRA, umi_Med, umi_Max, umi_Min) VALUES ('04-2016', 3, 61, 87, 55);
INSERT INTO umidade(mes, codRA, umi_Med, umi_Max, umi_Min) VALUES ('08-2014', 5, 34, 52, 18);
INSERT INTO umidade(mes, codRA, umi_Med, umi_Max, umi_Min) VALUES ('12-2018', 2, 73, 90, 48);
INSERT INTO umidade(mes, codRA, umi_Med, umi_Max, umi_Min) VALUES ('09-2013', 20, 37, 79, 20);

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

INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (1, 'Limpo');
INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (2, 'Quase limpo');
INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (3, 'Pouco nublado');
INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (4, 'Parcia. nublado');
INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (5, 'Quase nublado');
INSERT INTO est_nebulosidade(codNeb, descricao) VALUES (6, 'Nublado');

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
