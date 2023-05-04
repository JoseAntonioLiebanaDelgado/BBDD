# Base de datos
CREATE DATABASE IF NOT EXISTS s3_c1_ej3;

USE s3_c1_ej3;

# Drop Tablas
DROP TABLE IF EXISTS regalo;
DROP TABLE IF EXISTS subscritor_coleccion;
DROP TABLE IF EXISTS cliente_entrega;
DROP TABLE IF EXISTS entrega;
DROP TABLE IF EXISTS coleccion;
DROP TABLE IF EXISTS subscritor;
DROP TABLE IF EXISTS cliente;
DROP TABLE IF EXISTS usuario;


CREATE TABLE usuario(
	id_usuario INT AUTO_INCREMENT NOT NULL,
	DNI VARCHAR(9) NOT NULL,
	mail VARCHAR(50) NOT NULL,
	direccion VARCHAR(200) NOT NULL,
	num_targeta INT NOT NULL,
	PRIMARY KEY (id_usuario)
);


CREATE TABLE subscritor(
	id_subscritor INT,
	es_asociado BOOLEAN,
	PRIMARY KEY (id_subscritor)
);


CREATE TABLE cliente(
	id_cliente INT,
	gusta_electronico BOOLEAN,
	PRIMARY KEY (id_cliente)
);


CREATE TABLE coleccion(
	nombre_coleccion VARCHAR(50),
	ano_inicio INT,
	ano_fin INT,
	PRIMARY KEY (nombre_coleccion)
);


CREATE TABLE entrega(
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	num_paginas INT,
	PRIMARY KEY (fecha_entrega, nombre_coleccion)
);


CREATE TABLE regalo(
	id_regalo INT,
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	peso INT UNSIGNED,
	PRIMARY KEY (id_regalo, fecha_entrega, nombre_coleccion)
);


CREATE TABLE subscritor_coleccion(
	id_subscritor INT,
	nombre_coleccion VARCHAR(50),
	num_inicio INT,
	PRIMARY KEY (id_subscritor, nombre_coleccion)
);


CREATE TABLE cliente_entrega(
	id_cliente INT,
	fecha_entrega DATE,
	nombre_coleccion VARCHAR(50),
	PRIMARY KEY (id_cliente, fecha_entrega, nombre_coleccion)
);


ALTER TABLE subscritor ADD CONSTRAINT fk_subscritor FOREIGN KEY (id_subscritor) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE cliente ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES usuario(id_usuario) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE entrega ADD CONSTRAINT fk_entrega FOREIGN KEY (nombre_coleccion) REFERENCES coleccion(nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE regalo ADD CONSTRAINT fk_regalo	FOREIGN KEY (fecha_entrega, nombre_coleccion) REFERENCES entrega(fecha_entrega, nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE subscritor_coleccion ADD CONSTRAINT fk_subscritor2 FOREIGN KEY (id_subscritor) REFERENCES subscritor(id_subscritor) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE subscritor_coleccion ADD CONSTRAINT fk_coleccion FOREIGN KEY (nombre_coleccion) REFERENCES coleccion(nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE cliente_entrega ADD CONSTRAINT fk_cliente2 FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE cliente_entrega ADD CONSTRAINT fk_entrega2 FOREIGN KEY (fecha_entrega, nombre_coleccion) REFERENCES entrega(fecha_entrega,nombre_coleccion) ON UPDATE CASCADE ON DELETE CASCADE;