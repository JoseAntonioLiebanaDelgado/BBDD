-- Creamos el objeto Bici con los atributos y metodos que queremosç
create or replace type bici as OBJECT(
    -- Atributos:
    id number(4),
    marca varchar2(30),
    model varchar2(30),
    tipus varchar2(20),
    es_professional number(1),
    pes float,
    preu float,
    -- Método constructor con los parametros p_marca, p_model, p_pes y p_preu
    constructor function bici (p_marca varchar2, p_model varchar2, p_pes float, p_preu float) return self as result,
    -- Método MAP MEMBER FUNCTION, que la utilizamos para ordenar por precio 
    MAP member function funcionOrderar return float,
    -- Método getModel que lo utilizaremos para mostrar el modelo de la bici
    member function getModel return varchar2,
    -- Método getPreu que lo utilizaremos para mostrar el precio de la bici
    member function getPreu return float,
    -- Método toString que lo utilizaremos para mostrar todos los atributos de la bici del objeto. 
    member procedure toString,
    -- Método setPreu que lo utilizaremos para modificar el precio de la bici. Esto es un procedimiento,
    -- y no una funcion ya que no devuelve nada.
    member procedure setPreu(p_preu float),
    -- Método STATIC FUNCTION que utilizaremos para sumar dos valores enteros.
    -- Los metodos staticos no necesitan un objeto para ser llamados, lo llamamos directamente con el nombre del objeto.
    static function sumaValors (a int, b int) return int
    );

/

Create or replace type body bici as 

    -- Definimos el constructor con los parametros concretos. Al final del constructor no se pone return, ya que no devuelve nada,
    -- pero si se pone un return vacio para que no de error.
    constructor function bici (p_marca varchar2, p_model varchar2, p_pes float, p_preu float) return self as result is
        begin 
            self.marca := p_marca;
            self.model := p_model;
            self.pes := p_pes
            self.preu := p_preu;
            return;
        end;

    -- Definimos el metodo MAP MEMBER FUNCTION que utilizaremos para ordenar por precio.
    -- Este metodo devuelve un float, que es el precio entre el peso.
    map member function funcionOrderar return float is
        begin
            if self.preu is null or self.pes is null THEN
                return 0;
            ELSE
                return self.preu / self.pes;
            end if;
        end;
    
    -- Definimos el metodo getModel que utilizaremos para mostrar el modelo de la bici.
    member function getModel return varchar2 is
        begin 
            return self.model;
        end;

    -- Definimos el metodo getPreu que utilizaremos para mostrar el precio de la bici.
    member function getPreu return float is
        begin
            return self.preu;
        end;

    -- Definimos el metodo toString que utilizaremos para mostrar los atributos de la bici del objeto.
    member procedure toString is 
        begin 
            DBMS_OUTPUT.PUT_LINE('La bicicleta es de la marca: ' || self.marca || ' y el model es: ' || self.model);
        end;
    
    -- Definimos el metodo setPreu que utilizaremos para modificar el precio de la bici.
    member procedure setPreu(p_preu float) is
        begin
            self.preu := p_preu;
        end;

    -- Definimos el metodo STATIC FUNCTION que utilizaremos para sumar dos valores enteros.
    static function sumaValors (a int, b int) return int is 
        begin
            return a + b;
        end;
end;

/

-- Creamos la tabla bicicletes con el objeto bici y el atributo nom_client
-- Aqui el objeto bici se llama bicicleta, y el atributo nom_client se llama nom_client
-- Osea bici es el tipo de objeto, y bicicleta es el nombre del objeto.
create table bicicletes(
    bicicleta bici,
    nom_client varchar2(50)
)

-- Seleccionamos todos los atributos de la tabla bicicletes
select * from bicicletes;

-- Insertamos un objeto bici en la tabla bicicletes, con los atributos que queremos, que son 
-- los que hemos definido en el objeto bici en el constructor y el nombre del cliente.
insert into bicicletes VALUES(
    new bici(1, 'Canyon', 'Ultimate SL CF', 'Road', 1, 7.5, 2400), 'Raimon');

-- Declaramos una variable de tipo bici, y seleccionamos el objeto bici de la tabla bicicletes
-- Esta variable se llama bici_tmp, y el objeto bici se llama bici
-- La variable bici la utilizamos para llamar a los metodos del objeto bici, porque no podemos
-- llamar a los metodos directamente del objeto bici de la tabla bicicletes.
Declare
    bici_tmp bici;
begin
-- Seleccionamos el objeto bici de la tabla bicicletes, y lo guardamos en la variable bici_tmp
-- Llamamos al metodo toString del objeto bici, que nos muestra todos los atributos del objeto bici.
    select bicicleta
    into bici_tmp
    from bicicletes;
    bici_tmp.toString();
end;