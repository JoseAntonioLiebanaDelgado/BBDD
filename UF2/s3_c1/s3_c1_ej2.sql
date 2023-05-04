# Base de datos
CREATE DATABASE IF NOT EXISTS s3_c1_ej2; 
USE s3_c1_ej2;


# Tablas
CREATE TABLE IF NOT EXISTS persona(
	num_ss VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	apellido1 VARCHAR(50) NOT NULL,
	apellido2 VARCHAR(50) NOT NULL,
	PRIMARY KEY (num_ss)
) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci';


CREATE TABLE IF NOT EXISTS arbitro(
	num_ss_arbitro VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	num_colegiado VARCHAR(50),
	ano_inicio INT,
	profesion VARCHAR(50),
	PRIMARY KEY (num_ss_arbitro),
	FOREIGN KEY (num_ss_arbitro) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS equipo(
	nombre VARCHAR(50),
	ano_fundacion INT,
	presupuesto VARCHAR(50),
	presidente VARCHAR(50),
	entrenador VARCHAR(50),
	direccion VARCHAR(200),
	PRIMARY KEY (nombre)
);


CREATE TABLE IF NOT EXISTS jugador(
	num_ss_jugador VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	dorsal INT,
	ubicacion VARCHAR(50),
	ficha DECIMAL,
	nombre_equipo VARCHAR(50),
	PRIMARY KEY (num_ss_jugador),
	FOREIGN KEY (num_ss_jugador) REFERENCES persona(num_ss) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (nombre_equipo) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS partido(
	num_ss_arbitro VARCHAR(50) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci', # Lo ponemos para coincidor conel de persona para poder hacer la FK
	equipo_local VARCHAR(50),
	equipo_visitante VARCHAR(50),
	resultado VARCHAR(50),
	fecha DATE,
	PRIMARY KEY (num_ss_arbitro,equipo_local,equipo_visitante),
	FOREIGN KEY (num_ss_arbitro) REFERENCES arbitro(num_ss_arbitro) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_local) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE,
	FOREIGN KEY (equipo_visitante) REFERENCES equipo(nombre) ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO persona VALUES('1', 'Pepe', 'Gomez', 'Palomares');
INSERT INTO persona VALUES('2', 'Juan', 'Lopez', 'Rivera');
INSERT INTO persona VALUES('3', 'Alex', 'Blay', 'Estrada');
INSERT INTO persona VALUES('4', 'Edu', 'Garcia', 'Perez');
INSERT INTO persona VALUES('5', 'Mario', 'Escobar', 'Heredia');
INSERT INTO persona VALUES('6', 'Pol', 'Cubo', 'Ruiz');
INSERT INTO persona VALUES('7', 'Alberto', 'Perez', 'Rodriguez');
INSERT INTO persona VALUES('8', 'Rafael', 'Carpio', 'Agudo');
INSERT INTO persona VALUES('9', 'Laura', 'Casas', 'Prieto');
INSERT INTO persona VALUES('10', 'Maria', 'Hernandez', 'Jimenez');


INSERT INTO arbitro VALUES ('1','1', 1990, 'Chofer');
INSERT INTO arbitro VALUES ('2','2', 1992, 'Mozo Almacen');
INSERT INTO arbitro VALUES ('3','3', 1994, 'Barbero');


INSERT INTO equipo VALUES('Barça', '1975-01-01', '1.000.000', 'Laporta', 'Lamesa', 'Barcelona');
INSERT INTO equipo VALUES('Sevilla', '1979-01-01', '2.000.000', 'Rodriguez', 'Lasilla', 'Sevilla');
INSERT INTO equipo VALUES('Betis', '1983-01-01', '1.500.000', 'Latorre', 'Lapuerta', 'Sevilla');


INSERT INTO jugador VALUES('4', 34, 'Central', 100, 'Barça');
INSERT INTO jugador VALUES('5', 54, 'Portero', 150, 'Betis');
INSERT INTO jugador VALUES('6', 3, 'Delantero', 250.000, 'Betis');
INSERT INTO jugador VALUES('7', 5, 'Central', 190.000, 'Barça');
INSERT INTO jugador VALUES('8', 22, 'Defensa', 185.000, 'Betis');
INSERT INTO jugador VALUES('9', 7, 'Delantero', 215.000, 'Barça');
INSERT INTO jugador VALUES('10', 1, 'Central', 205.000, 'Betis');
INSERT INTO jugador VALUES('3', 37, 'Defensa', 218.000, 'Betis');


INSERT INTO partido VALUES('1', 'Barça', 'Betis', '7-1', '2022-10-15');
INSERT INTO partido VALUES('2', 'Betis', 'Sevilla', '4-1', '2022-10-15');
INSERT INTO partido VALUES('3', 'Barça', 'Sevilla', '0-4', '2022-10-15');
INSERT INTO partido VALUES('1', 'Sevilla', 'Sevilla', '4-4', '2022-10-15');
INSERT INTO partido VALUES('2', 'Betis', 'Barça', '1-1', '2022-10-15');