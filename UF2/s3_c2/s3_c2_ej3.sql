--a)	Actualiza el atributo es_asociado del subscritor añadido a FALSE.
UPDATE FROM Subcriptor
SET es_asociado = FALSE


--b)	Borra los regalos con un peso mayor a 5000g (suponemos que el peso está en gramos).
DELETE FROM Regalo
WHERE peso > 5000;


--c)	Borra el numero de la tarjeta del usuario añadido.
UPDATE FROM Usuario
SET DNI = NULL;


--d)	Borra las compras de entregas de los clientes.
DELETE FROM Entrega
WHERE Cliente.id_cliente = Cliente_Entrega.id_cliente
AND Cliente_Entrega.fecha_entrega = Entrega.fecha_entrega;