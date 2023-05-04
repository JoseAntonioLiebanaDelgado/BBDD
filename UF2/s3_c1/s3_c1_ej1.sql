# Base de datos
CREATE DATABASE s3_c1_ej1 DEFAULT CHARACTER SET 'utf8' DEFAULT COLLATE 'utf8_bin';
USE s3_c1_ej1;


# Tablas
CREATE TABLE temporada(
	id_temporada INT AUTO_INCREMENT,
	fecha_inicio DATETIME,
	fecha_fin DATETIME,
	PRIMARY KEY (id_temporada)
);


CREATE TABLE competicion(
	nombre_competicion VARCHAR(50),
	nombre_TV VARCHAR(50),
	PRIMARY KEY (nombre_competicion)
);


CREATE TABLE federacion(
	nombre_federacion VARCHAR(50),
	fecha_creacion DATETIME,
	responsable VARCHAR(50),
	PRIMARY KEY (nombre_federacion)
);


CREATE TABLE equipo(
	nombre_equipo VARCHAR(50) NOT NULL,
	ciudad VARCHAR(50) NOT NULL,
	presidente VARCHAR(50) NOT NULL,
	nombre_federacion VARCHAR(50) NOT NULL,
	PRIMARY KEY (nombre_equipo),
	FOREIGN KEY (nombre_federacion) REFERENCES federacion(nombre_federacion) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE clasificacion(
	id_temporada INT,
	nombre_competicion VARCHAR(50),
	nombre_equipo VARCHAR(50),
	posicion INT,
	PRIMARY KEY (id_temporada, nombre_competicion, nombre_equipo),
	FOREIGN KEY (id_temporada) REFERENCES temporada(id_temporada) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_competicion) REFERENCES competicion(nombre_competicion) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_equipo) REFERENCES equipo(nombre_equipo) ON UPDATE CASCADE ON DELETE CASCADE
);


--------------------------------------------------------------------------------------------------------------


INSERT INTO federacion (nombre_federacion, fecha_creacion)VALUES('RFEF', '1940-01-01');
INSERT INTO federacion (nombre_federacion, fecha_creacion)VALUES('FIFA', '1945-01-01');
INSERT INTO federacion VALUES('FIFO', '1945-01-01', 'Pedro Pascal');


INSERT INTO equipo VALUES ('Barça', 'Barcelona', 'Laporta', 'RFEF');
INSERT INTO equipo VALUES ('Betis', 'Sevilla', 'Erderbeti', 'FIFA');

INSERT INTO competicion VALUES ('La lliga', 'TV3');
INSERT INTO competicion VALUES ('FIFA', 'TV1');

INSERT INTO temporada VALUES (1, '2022-01-01', '2023-01-01');
INSERT INTO temporada VALUES (2, '2022-01-01', '2023-01-01');

INSERT INTO clasificacion VALUES (1, 'La lliga', 'Barça', 1);
INSERT INTO clasificacion VALUES (2, 'La lliga', 'Betis', 2);