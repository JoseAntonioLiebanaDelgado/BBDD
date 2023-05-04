/*
1. Crea un procediment a la BD world anomenat showCountryCities sense cap paràmetre d'entrada.
Aquest procediment llegirà un fitxer anomenat cityid.csv que contindrà un únic valor numèric enter.

El procediment llegirà el fitxer, guardarà el valor en una variable o una taula temporal. Seguidament
buscarà la ciutat corresponenta aquest id i en guardarà el seu CountryCode en una variable temporal
per després mostrar totes les ciutats corresponent a aquest CountryCode trobat.

La gràcia que l'input de dades serà a través del contingut del fitxer que serà guardat al @@datadir de la base de dades world.
*/

-- CAN'T USE LOAD DATA IN PREPARE: https://stackoverflow.com/questions/44360756
-- LOAD DATA NOT ALLOWED IN STORED PROCEDURES: https://stackoverflow.com/questions/17273030

