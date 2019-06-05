DROP TABLE IF EXISTS RA CASCADE;
DROP TABLE IF EXISTS Temperatura CASCADE;
DROP TABLE IF EXISTS Umidade CASCADE;
DROP TABLE IF EXISTS Precipitacao CASCADE;
DROP TABLE IF EXISTS Pressao_Atm CASCADE;
DROP TABLE IF EXISTS Ventos CASCADE;
DROP TABLE IF EXISTS Nebulosidade CASCADE;
DROP TABLE IF EXISTS Est_Nebulosidade CASCADE;
DROP TABLE IF EXISTS Bairro CASCADE;
DROP TABLE IF EXISTS Alagamento CASCADE;

CREATE TABLE RA
    (codRA      INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nome        VARCHAR(30) NOT NULL,
    populacao   INTEGER UNSIGNED,
    data_criacao DATE);

CREATE TABLE Temperatura
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    temp_Med    INTEGER NOT NULL,
    temp_Max    INTEGER NOT NULL,
    temp_Min    INTEGER NOT NULL);

CREATE TABLE Umidade
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    umi_Med     INTEGER UNSIGNED NOT NULL,
    umi_Max     INTEGER UNSIGNED NOT NULL,
    umi_Min     INTEGER UNSIGNED NOT NULL);

CREATE TABLE Precipitacao
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    precipit    VARCHAR(30) NOT NULL);

CREATE TABLE Pressao_Atm
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    patm_Med    INTEGER UNSIGNED NOT NULL,
    patm_Max    INTEGER UNSIGNED NOT NULL,
    patm_Min    INTEGER UNSIGNED NOT NULL);

CREATE TABLE Ventos
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    vel_Med     INTEGER UNSIGNED NOT NULL,
    vel_Max     INTEGER UNSIGNED NOT NULL,
    vel_Min     INTEGER UNSIGNED NOT NULL);

CREATE TABLE Nebulosidade
    (mes_Ano    VARCHAR(7) PRIMARY KEY,
    codRA       INTEGER REFERENCES RA(codRA),
    neb_Manha   VARCHAR(10) NOT NULL,
    neb_Tarde   VARCHAR(10) NOT NULL,
    neb_Noite   VARCHAR(10) NOT NULL);

CREATE TABLE Est_Nebulosidade
    (codNeb     INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    mes_Ano     VARCHAR(7) REFERENCES Nebulosidade(mes_Ano),
    nome        VARCHAR(15) NOT NULL);

CREATE TABLE Bairro
    (codBairro INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codRA      INTEGER REFERENCES RA(codRA),
    nome       VARCHAR(30) NOT NULL,
    populacao  INTEGER UNSIGNED);

CREATE TABLE Alagamento
    (codAlagamento INTEGER UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    codBairro  INTEGER REFERENCES Bairro(codBairro),
    dia 	   DATE NOT NULL,
    rua        VARCHAR(30) NOT NULL,
    duracao    INTEGER UNSIGNED,
    imagem     BLOB);
