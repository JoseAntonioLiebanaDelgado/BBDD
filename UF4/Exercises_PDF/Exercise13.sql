-- Se desea disponer de una base de datos de los inmuebles que tiene a la venta una promotora.
-- Un inmueble se caracteriza por su superficie, precio y ciudad donde se ubica. La promotora
-- tiene a la venta los siguientes tipos de inmuebles:
-- • Oficina: que se caracteriza por número de plantas y si dispone o no de ascensor.
-- • Vivienda: que se caracteriza por número de habitaciones, número de baños, si tiene
-- terraza o no, si tiene piscina o no, si tiene garaje o no y si tiene ascensor o no.
-- En el caso de viviendas, dispondrá de un método (to_string2) que devuelva su clasificación en
-- función del número de habitaciones:
-- • 1hab-> Clasificación: estudio
-- • 2hab-> Clasificación: apartamento
-- • 2hab-> Clasificación: piso

-- Crea los tipos y subtipos necesarios, permitiendo almacenar la información citada. Los
-- inmuebles se ordenarán por su precio (de menor a mayor) y dispondrán de una función
-- (show) que permita devolver la descripción del inmueble (la descripción del inmueble será
-- una cadena de caracteres que indicará si es una Oficina o una Vivienda y contendrá las
-- características citadas según el tipo de inmueble).
-- Crea una tabla que disponga de 2 campos, un campo para contener inmuebles, y un campo
-- que sirva para almacenar la fecha de alta del inmueble en la base de datos. Introduce en la
-- tabla varios registros de tipo vivienda y oficina.
-- Realiza las siguientes consultas:
-- • Muestra las descripciones de cada uno de los inmuebles insertados en la tabla
-- ordenados por precio (de menor a mayor).
-- • Muestra las descripciones de los inmuebles que fueron dados de alta hace más
-- de un mes.
-- • Muestra las descripciones de los inmuebles cuyo precio se encuentre entre
-- dos determinadas cantidades.
-- • Muestra las descripciones de los inmuebles que sean viviendas.



CREATE OR REPLACE TYPE immueble_t AS OBJECT (
  id INTEGER,
  superficie NUMBER,
  precio NUMBER,
  ciudad VARCHAR2(20),
  FINAL MAP MEMBER FUNCTION ordernarPrecio RETURN NUMBER,
  MEMBER FUNCTION show RETURN VARCHAR2
) NOT FINAL;

/

CREATE OR REPLACE TYPE BODY immueble_t AS
  FINAL MAP MEMBER FUNCTION ordernarPrecio RETURN NUMBER IS
  BEGIN
      RETURN SELF.precio;
  END;
  MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'id: '||SELF.id||'
      superficie: '||SELF.superficie||'
      precio : '||SELF.precio||'
      ciudad : '||SELF.ciudad;
  END;
END;

/

CREATE OR REPLACE TYPE oficina_t UNDER immueble_t (
  num_plantas NUMBER,
  tiene_ascensor INTEGER,
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2,
  MEMBER FUNCTION hay_ascensor RETURN BOOLEAN
);

/

CREATE OR REPLACE TYPE BODY oficina_t AS
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'Oficina:
      -id: '||SELF.id||'
      -superficie: '||SELF.superficie||'
      -precio: '||SELF.precio||'
      -ciudad: '||SELF.ciudad||'
      -num_plantas: '||SELF.num_plantas||'
      -tiene_ascensor: '||SELF.tiene_ascensor;
  END;
  MEMBER FUNCTION hay_ascensor RETURN BOOLEAN IS
  BEGIN
    IF SELF.tiene_ascensor = 1 THEN RETURN TRUE;
    ELSE RETURN FALSE;
    END IF;
  END;
END;

/

CREATE OR REPLACE TYPE vivienda_t UNDER immueble_t (
  num_habitaciones NUMBER,
  num_baños NUMBER,
  tiene_terraza INTEGER,
  tiene_piscina INTEGER,
  tiene_garage INTEGER,
  tiene_ascensor INTEGER,
  MEMBER FUNCTION getTipo RETURN VARCHAR2,
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2
);

/

CREATE OR REPLACE TYPE BODY vivienda_t AS
  MEMBER FUNCTION getTipo RETURN VARCHAR2 IS
  BEGIN
    IF SELF.num_habitaciones = 1 THEN
      RETURN 'Estudio';
    ELSIF SELF.num_habitaciones = 2 THEN
      RETURN 'Apartamento';
    ELSIF SELF.num_habitaciones > 2 THEN
      RETURN 'Piso';
    END IF;
  END;
  OVERRIDING MEMBER FUNCTION show RETURN VARCHAR2 IS
  BEGIN
      RETURN 'Vivienda:-id: '||SELF.id||'-superficie: '||SELF.superficie||'-precio: '||SELF.precio||'-ciudad: '||SELF.ciudad||'-num_habitaciones: '||SELF.num_habitaciones||'-num_baños: '||SELF.num_baños||',-tiene_terraza: '||SELF.tiene_terraza||',-tiene_piscina: '||SELF.tiene_piscina||',-tiene_garage: '||SELF.tiene_garage||',-tiene_ascensor: '||SELF.tiene_ascensor;
  END;
END;

/

CREATE TABLE immuebles_table (
  -- Creamos un objeto de tipo inmueble que lo utilizaremos en la tabla en vez de los tipos de inmuebles.
  -- inmueble_t es el tipo de objeto que hemos creado.
  -- inmueble es el nombre del objeto que hemos creado.
  immueble immueble_t,
  fecha_alta DATE,
  CONSTRAINT pk_immuebles_table PRIMARY KEY(immueble.id)
);
/
INSERT INTO immuebles_table VALUES (oficina_t(1,50,33.2,'Barcelona',5,1),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (oficina_t(2,50,33.2,'Barcelona',2,0),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(3,50,33.2,'Barcelona',1,1,0,0,0,0),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(4,50,33.2,'Barcelona',2,1,0,1,1,1),'22-FEB-2020');
/
INSERT INTO immuebles_table VALUES (vivienda_t(5,50,33.2,'Barcelona',3,1,1,0,1,1),'22-FEB-2020');

/

SELECT i.immueble.show() FROM immuebles_table i ORDER BY i.immueble.precio;

/

SELECT i.immueble.show() FROM immuebles_table i
WHERE extract(month from i.fecha_alta)-1 = extract(month from SYSDATE)
  AND extract(year from i.fecha_alta) = extract(year from SYSDATE);

/

SELECT i.immueble.show() FROM immuebles_table i WHERE i.immueble.precio BETWEEN 10 AND 50;

/

-- La función VALUE no funciona en ORACLE Live: 
SELECT i.immueble.show() FROM immuebles_table i WHERE VALUE(i.immueble) IS OF TYPE (vivienda_t);
/
-- Podemos hacelo sin ella:
-- Seleccionamos todos los inmuebles que sean de tipo vivienda_t, y mostramos su descripción.
SELECT i.immueble.show() FROM immuebles_table i WHERE (i.immueble) IS OF TYPE (vivienda_t);
