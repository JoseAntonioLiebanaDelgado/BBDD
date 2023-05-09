-- Se desea disponer de una base de datos de los inmuebles que tiene a la venta una promotora.
-- Un inmueble se caracteriza por su superficie, precio y ciudad donde se ubica. La promotora
-- tiene a la venta los siguientes tipos de inmuebles:

create or replace type inmueble_t as object (
  superficie number,
  precio number,
  ciudad varchar2(30),
  member function to_string return varchar2
) not final;


-- • Oficina: que se caracteriza por número de plantas y si dispone o no de ascensor.
-- • Vivienda: que se caracteriza por número de habitaciones, número de baños, si tiene
-- terraza o no, si tiene piscina o no, si tiene garaje o no y si tiene ascensor o no.
-- En el caso de viviendas, dispondrá de un método (to_string2) que devuelva su clasificación en
-- función del número de habitaciones:
-- • 1hab-> Clasificación: estudio
-- • 2hab-> Clasificación: apartamento
-- • 2hab-> Clasificación: piso

create or replace type oficina_t under inmueble_t (
  num_plantas number,
  tiene_ascensor boolean,
  overriding member function to_string return varchar2
);

create or replace type vivienda_t under inmueble_t (
  num_habitaciones number,
  num_banos number,
  tiene_terraza boolean,
  tiene_piscina boolean,
  tiene_garaje boolean,
  tiene_ascensor boolean,
  overriding member function to_string1 return varchar2,
  member function to_string2 return varchar2
); 


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


