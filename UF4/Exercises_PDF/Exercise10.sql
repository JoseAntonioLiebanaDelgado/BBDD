-- a) Crea una tabla de objetos noticia_t que se llame noticias_obj. La clave primaria debe ser el código.
-- Inserta 3 valores y comprueba que los valores se han insertado correctamente. Realiza un SELECT de la
-- tabla noticias_obj para verificar que las noticias se han insertado correctamente.

CREATE OR REPLACE TYPE noticia_t AS OBJECT (
    codigo NUMBER,
    titulo VARCHAR2(50),
    texto VARCHAR2(4000),
    fecha DATE
);

CREATE TABLE noticias_obj OF noticia_t (
    codigo PRIMARY KEY
);

INSERT INTO noticias_obj VALUES (1, 'Noticia 1', 'Texto noticia 1', SYSDATE);
INSERT INTO noticias_obj VALUES (2, 'Noticia 2', 'Texto noticia 2', SYSDATE);
INSERT INTO noticias_obj VALUES (3, 'Noticia 3', 'Texto noticia 3', SYSDATE);

SELECT * FROM noticias_obj;


-- b) Crea una tabla que contenga un objeto noticia_t y un varchar2 que se llame sección.
-- La clave primaria de la tabla debe ser el atributo código del objeto noticia. Inserta 3 valores y
-- comprueba que se han insertado correctamente.

CREATE TABLE noticias_obj_seccion (
    noticia noticia_t,
    seccion VARCHAR2(50),
    CONSTRAINT pk_noticia_obj_seccion PRIMARY KEY (noticia.codigo)
);

INSERT INTO noticias_obj_seccion (noticia, seccion) VALUES (noticia_t(1, 'Noticia 1', 'Texto de la noticia 1', SYSDATE), 'Sección 1');
INSERT INTO noticias_obj_seccion (noticia, seccion) VALUES (noticia_t(2, 'Noticia 2', 'Texto de la noticia 2', SYSDATE), 'Sección 2');
INSERT INTO noticias_obj_seccion (noticia, seccion) VALUES (noticia_t(3, 'Noticia 3', 'Texto de la noticia 3', SYSDATE), 'Sección 3');

SELECT * FROM noticias_obj_seccion;

