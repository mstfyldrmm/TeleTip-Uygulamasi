CREATE DATABASE DB_HASTANE_TELETIP;

use DB_HASTANE_TELETIP;
SET FOREIGN_KEY_CHECKS=OFF;
create table Hastalar
(
hasta_ID int auto_increment primary key,
hasta_ISIM varchar(20) not NULL,
hasta_SOYISIM varchar(20) not NULL,
hasta_SIFRE varchar(20) not NULL,
hasta_MAIL varchar(60) not null,
hasta_FOTO varchar(100)
)ENGINE=InnoDB DEFAULT CHARSET=utf8;

Create table Doktorlar
(
doktor_ID int auto_increment primary key,
doktor_ISIM varchar(20) not NULL,
doktor_SOYISIM varchar(20) not NULL,
doktor_MAIL varchar(60) not NULL,
doktor_FOTO varchar(100),
doktor_SIFRE varchar(20) not NULL,
doktor_AnaBilim varchar(45) not NULL,
doktor_uzmanlik varchar(250) not NULL,
doktor_mezunOkul varchar(45) not NULL,
doktor_calistigiKurum varchar(45) not NULL
)ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE Mesajlar (
    mesaj_ID INT AUTO_INCREMENT PRIMARY KEY,
    doktor_ID INT NOT NULL,
    hasta_ID INT NOT NULL,
    mesaj VARCHAR(50),
    eklenti_path VARCHAR(100),
    tarih DATETIME,
    yon BOOLEAN,
    CONSTRAINT fk_mesaj_doktor FOREIGN KEY (doktor_ID)
        REFERENCES doktorlar (doktor_ID)
        ON DELETE CASCADE,
    CONSTRAINT fk_mesaj_hasta FOREIGN KEY (hasta_ID)
        REFERENCES hastalar (hasta_ID)
        ON DELETE CASCADE
)