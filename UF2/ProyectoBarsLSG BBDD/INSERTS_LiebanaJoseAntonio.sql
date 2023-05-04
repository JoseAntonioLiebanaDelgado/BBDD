-- Jose Antonio Liebana Delgado

INSERT INTO Persona VALUES('47126568W', 'Pepe', 'Gomez', 'Palomares', 'pepegomezpalomares@gmail.com');
INSERT INTO Persona VALUES('65545432D', 'Juan', 'Lopez', 'Rivera', 'juanlopezrivera@gmail.com');
INSERT INTO Persona VALUES('64875123F', 'Alex', 'Blay', 'Estrada', 'alexblayestrada@gmail.com');
INSERT INTO Persona VALUES('48278231H', 'Edu', 'Garcia', 'Perez', 'edugarciaperez@gmail.com');
INSERT INTO Persona VALUES('13193938W', 'Mario', 'Escobar', 'Heredia', 'marioescobarheredia@gmail.com');
INSERT INTO Persona VALUES('17368136A', 'Pol', 'Cubo', 'Ruiz', 'polcuboruiz@gmail.com');
INSERT INTO Persona VALUES('56835799C', 'Alberto', 'Perez', 'Rodriguez', 'albertoperezrodriguez@gmail.com');
INSERT INTO Persona VALUES('27885362J', 'Rafael', 'Nuñez', 'Agudo', 'rafaelnuñezagudo@gmail.com');
INSERT INTO Persona VALUES('90984082K', 'Laura', 'Casas', 'Prieto', 'lauracasasprieto@gmail.com');
INSERT INTO Persona VALUES('54768799L', 'Maria', 'Hernandez', 'Jimenez', 'mariahernandezjimenez@gmail.com');
INSERT INTO Persona VALUES('00104058P', 'Joan', 'Galobart', 'Leon', 'joangalobartleon@gmail.com');
INSERT INTO Persona VALUES('97464743W', 'Marc', 'Romero', 'Orta', 'marcromeroorta@gmail.com');
INSERT INTO Persona VALUES('53681348Z', 'Alejandro', 'Carpio', 'Perez', 'alejandrocarpioperez@gmail.com');
INSERT INTO Persona VALUES('85666883X', 'Marina', 'Perez', 'Pastor', 'marinaperezpastor@gmail.com');
INSERT INTO Persona VALUES('67785512C', 'Mario', 'Robles', 'Caballero', 'marioroblescaballero@gmail.com');
INSERT INTO Persona VALUES('29485756V', 'Jaime', 'Robles', 'Caballero', 'jaimeroblescaballero@gmail.com');
INSERT INTO Persona VALUES('47872456B', 'Joan', 'Bartoli', 'Nicolas', 'joanbartolinicolas@gmail.com');
INSERT INTO Persona VALUES('44550208N', 'Jose', 'Cuevas', 'Espildora', 'josecuevasespildora@gmail.com');
INSERT INTO Persona VALUES('35577491M', 'Marta', 'Villalba', 'Vidal', 'martavillalbavidal@gmail.com');
INSERT INTO Persona VALUES('11784674L', 'Marc', 'Bru', 'Buixo', 'marcbrubuixo@gmail.com');

INSERT INTO Localitat VALUES(1, 'Sabadell', 'Barcelona', 'Catalunya', 'España', 'Europa');
INSERT INTO Localitat VALUES(2, 'Terrassa', 'Barcelona', 'Catalunya', 'España', 'Europa');
INSERT INTO Localitat VALUES(3, 'Rubi', 'Barcelona', 'Catalunya', 'España', 'Europa');
INSERT INTO Localitat VALUES(4, 'Cerdanyola', 'Barcelona', 'Catalunya', 'España', 'Europa');

INSERT INTO Carrec_Empleat VALUES('Cambrer', 'El cambrer mantindrà la sala en ordre, tomarà nota, portarà i retirarà els plats necessaris de la taula', 40, 1100.00);
INSERT INTO Carrec_Empleat VALUES('Cuiner', 'El cuiner mantindrà la cuina en ordre, prepararà i farà el dinar a part de fer la comanda pels proveïdors', 40, 1150.00);
INSERT INTO Carrec_Empleat VALUES('Cap', 'Porta tot el negoci i es el xef de cuina', 40, 1150.00);

INSERT INTO Empleat VALUES('47126568W', '558-50-5434', 'ES1720852066123656789014', 70, 'Cambrer', null, 1);
INSERT INTO Empleat VALUES('65545432D', '523-70-1289', 'ES1420852066823456789017', 25.00, 'Cuiner', null, 2);
INSERT INTO Empleat VALUES('64875123F', '415-06-1784', 'ES2085206692348578745712', 200.00, 'Cambrer', null, 3);
INSERT INTO Empleat VALUES('48278231H', '755-50-1221', 'ES1920852066023456789011', 80.00, 'Cambrer', null, 2);
INSERT INTO Empleat VALUES('13193938W', '995-10-6598', 'ES1092842066124512290160', 130.00, 'Cuiner', null, 1);
INSERT INTO Empleat VALUES('17368136A', '115-90-1444', 'ES1300012066663456699013', 120.00, 'Cuiner', null, 4);
INSERT INTO Empleat VALUES('56835799C', '234-65-1434', 'ES1300043066663487699014', null, 'Cap', null, 4);

INSERT INTO Client VALUES('27885362J', True);
INSERT INTO Client VALUES('90984082K', False);
INSERT INTO Client VALUES('54768799L', True);
INSERT INTO Client VALUES('00104058P', True);
INSERT INTO Client VALUES('97464743W', False);
INSERT INTO Client VALUES('53681348Z', True);
INSERT INTO Client VALUES('85666883X', True);
INSERT INTO Client VALUES('67785512C', True);
INSERT INTO Client VALUES('29485756V', True);
INSERT INTO Client VALUES('47872456B', True);
INSERT INTO Client VALUES('44550208N', False);
INSERT INTO Client VALUES('35577491M', False);
INSERT INTO Client VALUES('11784674L', True);

INSERT INTO Bar VALUES(1, 'Bar Emilio', 50, True, 3);
INSERT INTO Bar VALUES(2, 'Bar Combi-Dos', 45, True, 1);
INSERT INTO Bar VALUES(3, 'La Rovira', 25, False, 4);
INSERT INTO Bar VALUES(4, 'Bar Los Granainos', 60, True, 2);

INSERT INTO Taula VALUES(1, 1, True, True, 50);
INSERT INTO Taula VALUES(2, 1, True, True, 50);
INSERT INTO Taula VALUES(3, 2, True, True, 45);
INSERT INTO Taula VALUES(4, 2, True, True, 45);
INSERT INTO Taula VALUES(5, 3, False, False, 25);
INSERT INTO Taula VALUES(6, 3, False, False, 25);
INSERT INTO Taula VALUES(7, 4, True, True, 60);
INSERT INTO Taula VALUES(8, 4, True, True, 60);

INSERT INTO Client_Taula VALUES(1, '11784674L', 1, 1, True, '2023-02-15 13:43:43', '2023-02-15 14:43:43', True);
INSERT INTO Client_Taula VALUES(2, '35577491M', 2, 1, True, '2023-02-15 13:38:21', '2023-02-15 14:38:21', False);
INSERT INTO Client_Taula VALUES(3, '44550208N', 3, 2, True, '2023-02-15 14:05:33', '2023-02-15 15:05:33', True);
INSERT INTO Client_Taula VALUES(4, '47872456B', 4, 2, True, '2023-02-15 14:51:02', '2023-02-15 15:51:02', False);
INSERT INTO Client_Taula VALUES(5, '29485756V', 5, 3, False, '2023-02-15 13:12:49', '2023-02-15 14:12:49', True);
INSERT INTO Client_Taula VALUES(6, '67785512C', 6, 3, False, '2023-02-15 13:46:22', '2023-02-15 14:46:22', False);
INSERT INTO Client_Taula VALUES(7, '85666883X', 7, 4, True, '2023-02-15 14:15:39', '2023-02-15 15:15:39', True);
INSERT INTO Client_Taula VALUES(8, '53681348Z', 8, 4, True, '2023-02-15 15:01:17', '2023-02-15 16:01:17', False);

INSERT INTO Distribuidor VALUES(1, 'HijosDeNumenor.S.A', 'Miguel', '676-254-698', 'HijosDeNumenor@gmail.com', 'https://www.HijosDeNumenor.es');
INSERT INTO Distribuidor VALUES(2, 'Ilubatar.S.A', 'Marta', '625-739-846', 'S.A.Ilubatar@gmail.com', 'https://www.Ilubatar.es');
INSERT INTO Distribuidor VALUES(3, 'Ainur.S.L', 'Ramón', '677-222-081', 'Ainur.Proveedores@gmail.com', 'https://www.AinurProveedores.es');
INSERT INTO Distribuidor VALUES(4, 'Dúnedain.S.L', 'Mónica', '600-562-810', 'Dúnedain.Comerciales@gmail.com', 'https://www.Dúnedain.es');
INSERT INTO Distribuidor VALUES(5, 'Rohirrim.S.A', 'Rodrigo', '671-653-894', 'Rohirrim.S.A@gmail.com', 'https://www.Rohirrim.es');
INSERT INTO Distribuidor VALUES(6, 'Hijos de la Rivera', 'Francisco', '673-218-534', 'HijosDeLaRivera@gmail.com', 'https://www.HijosDeLaRivera.es');

INSERT INTO Tapa VALUES(1, 'Patates Braves', 'Patates fetes amb molt amor', '00:20:00', True, False, False);
INSERT INTO Tapa VALUES(2, 'Pebrots del padró', 'Pebrots del padró, alguns hi piquen i altres no','00:15:00', True, True, True);
INSERT INTO Tapa VALUES(3, 'Calamars Andalusa', 'Calamars arrebossats amb la nostra mescla', '00:30:00', True, False, False);
INSERT INTO Tapa VALUES(4, 'Musclos al vapor de la casa', 'Els nostres musclos al vapor de la casa son frescos i a un sabor potent pero lineal', '01:05:00', True, False, True);
INSERT INTO Tapa VALUES(5, 'Xoriços Infern', 'Com bé diu el seu propi nom no són per qualsevol, només pels mes valents', '00:25:00', True, False, True);
INSERT INTO Tapa VALUES(6, 'Croquetes de pernil salat', 'Croquetes de pernil salat de la senyora del bar', '00:40:00', True, False, True);
INSERT INTO Tapa VALUES(7, 'Croquetes de bullit', 'Croquetes de bullit de la senyora del bar', '00:45:00', True, False, True);
INSERT INTO Tapa VALUES(8, 'Sardines', 'Sardines fresques amb un toc especial de la casa, per saber-lo haurás de demanar-les', '00:37:00', True, False, False);

INSERT INTO BEGUDA VALUES(1, 'Vi negre', 'Vi Negre de la nostra collita', False, True, 75);
INSERT INTO BEGUDA VALUES(2, 'Vi Rosat', 'Vi Rosat de la nostra collita', False, True, 75);
INSERT INTO BEGUDA VALUES(3, 'Vino Blanco', 'Vi Blanc de la nostra collita', False, True, 75);
INSERT INTO BEGUDA VALUES(4, 'Agua', 'Aigua de mineralització debil', False, False, 100);
INSERT INTO BEGUDA VALUES(5, 'Cervesa', 'Cervesa amb doble de malta', False, True, 33);
INSERT INTO BEGUDA VALUES(6, 'Coca-Cola', 'La Coca-Cola de tota la vida', False, False, 33);
INSERT INTO BEGUDA VALUES(7, 'Fanta N', 'Fanta N de tota la vida', False, False, 33);
INSERT INTO BEGUDA VALUES(8, 'Fanta L', 'La Fanta L de tota la vida', False, False, 33);
INSERT INTO BEGUDA VALUES(9, 'Café', 'Café de gra de tipus arabica', True, False, 50);

INSERT INTO DISTRO_BEGUDA VALUES(1, 1, 8.50);
INSERT INTO DISTRO_BEGUDA VALUES(2, 2, 9.20);
INSERT INTO DISTRO_BEGUDA VALUES(3, 3, 7.80);
INSERT INTO DISTRO_BEGUDA VALUES(4, 4, 2.50);
INSERT INTO DISTRO_BEGUDA VALUES(5, 5, 4.75);
INSERT INTO DISTRO_BEGUDA VALUES(1, 6, 1.80);

INSERT INTO INGREDIENT VALUES (1, 'Ceba', 'Ceba amb sabor dolç utilitzat per cuinar', false, false, 0.02, 5);
INSERT INTO INGREDIENT VALUES (2, 'Jalapeny', 'Pebrot picant originari de México, tot fire', true, true, 0.05, 2);
INSERT INTO INGREDIENT VALUES (3, 'Tomaquet', 'Fruita comestible amb sabor acid utilitzat per cuinar', false, false, 0.03, 1);
INSERT INTO INGREDIENT VALUES (4, 'Coriandre', 'Herba aromática utilitzada per condimentar plats', false, true, 0.01, 4);
INSERT INTO INGREDIENT VALUES (5, 'Calamars', 'Calamars frescos', false, true, 0.05, 3);
INSERT INTO INGREDIENT VALUES (6, 'Patates', 'Patates fresques', false, false, 0.02, 2);
INSERT INTO INGREDIENT VALUES (7, 'Alvocat', 'Alvocat fresc', false, false, 0.03, 2);

INSERT INTO INGREDIENTS_TAPA VALUES(1, 1, 100);
INSERT INTO INGREDIENTS_TAPA VALUES(2, 1, 50);
INSERT INTO INGREDIENTS_TAPA VALUES(3, 1, 60);
INSERT INTO INGREDIENTS_TAPA VALUES(4, 2, 40);
INSERT INTO INGREDIENTS_TAPA VALUES(5, 2, 74);
INSERT INTO INGREDIENTS_TAPA VALUES(6, 3, 62);
INSERT INTO INGREDIENTS_TAPA VALUES(2, 3, 150);
INSERT INTO INGREDIENTS_TAPA VALUES(1, 4, 87);
INSERT INTO INGREDIENTS_TAPA VALUES(5, 4, 55);
INSERT INTO INGREDIENTS_TAPA VALUES(6, 5, 35);
INSERT INTO INGREDIENTS_TAPA VALUES(4, 5, 220);
INSERT INTO INGREDIENTS_TAPA VALUES(1, 6, 49);
INSERT INTO INGREDIENTS_TAPA VALUES(3, 6, 190);
INSERT INTO INGREDIENTS_TAPA VALUES(6, 7, 77);
INSERT INTO INGREDIENTS_TAPA VALUES(2, 7, 73);
INSERT INTO INGREDIENTS_TAPA VALUES(3, 8, 60);
INSERT INTO INGREDIENTS_TAPA VALUES(4, 8, 144);
INSERT INTO INGREDIENTS_TAPA VALUES(4, 4, 10);
INSERT INTO INGREDIENTS_TAPA VALUES(2, 4, 15);
INSERT INTO INGREDIENTS_TAPA VALUES(6, 4, 36);

INSERT INTO CARTA_TAPES VALUES (1, 1, 1.50, 3.00);
INSERT INTO CARTA_TAPES VALUES (2, 1, 2.50, 5.00);
INSERT INTO CARTA_TAPES VALUES (3, 2, 1.75, 3.50);
INSERT INTO CARTA_TAPES VALUES (4, 2, 3.00, 6.00);
INSERT INTO CARTA_TAPES VALUES (5, 3, 1.50, 3.00);
INSERT INTO CARTA_TAPES VALUES (6, 3, 2.00, 4.00);
INSERT INTO CARTA_TAPES VALUES (7, 4, 2.50, 5.00);
INSERT INTO CARTA_TAPES VALUES (8, 4, 3.50, 7.00);

INSERT INTO CARTA_BEGUDES VALUES (1, 1, 2.5, 3.5);
INSERT INTO CARTA_BEGUDES VALUES (2, 1, 3.0, 4.5);
INSERT INTO CARTA_BEGUDES VALUES (3, 2, 1.75, 3.0);
INSERT INTO CARTA_BEGUDES VALUES (4, 2, 2.0, 3.5);
INSERT INTO CARTA_BEGUDES VALUES (5, 3, 2.25, 4.0);
INSERT INTO CARTA_BEGUDES VALUES (6, 3, 3.5, 5.0);
INSERT INTO CARTA_BEGUDES VALUES (7, 4, 2.0, 3.5);
INSERT INTO CARTA_BEGUDES VALUES (8, 4, 1.5, 2.5);
INSERT INTO CARTA_BEGUDES VALUES (9, 4, 3.75, 5.0);

INSERT INTO COMANDA_TAPES VALUES (1, 1, 1, '2023-02-16 20:33:00', 2);
INSERT INTO COMANDA_TAPES VALUES (2, 1, 2, '2023-02-16 21:54:00', 3);
INSERT INTO COMANDA_TAPES VALUES (3, 2, 3, '2023-02-17 13:38:00', 1);
INSERT INTO COMANDA_TAPES VALUES (4, 2, 4, '2023-02-17 14:02:00', 2);
INSERT INTO COMANDA_TAPES VALUES (5, 3, 5, '2023-02-17 20:47:00', 1);
INSERT INTO COMANDA_TAPES VALUES (6, 3, 6, '2023-02-17 21:04:00', 3);
INSERT INTO COMANDA_TAPES VALUES (7, 4, 7, '2023-02-18 13:24:00', 2);
INSERT INTO COMANDA_TAPES VALUES (8, 4, 8, '2023-02-18 14:17:00', 1);

INSERT INTO COMANDA_BEGUDES VALUES (1, 1, 1, '2023-02-18 13:32:10', 2);
INSERT INTO COMANDA_BEGUDES VALUES (2, 1, 2, '2023-02-18 16:45:22', 1);
INSERT INTO COMANDA_BEGUDES VALUES (3, 2, 3, '2023-02-18 13:12:01', 3);
INSERT INTO COMANDA_BEGUDES VALUES (4, 2, 4, '2023-02-18 14:21:56', 1);
INSERT INTO COMANDA_BEGUDES VALUES (5, 3, 5, '2023-02-18 13:05:30', 2);
INSERT INTO COMANDA_BEGUDES VALUES (6, 3, 6, '2023-02-18 15:18:49', 1);
INSERT INTO COMANDA_BEGUDES VALUES (7, 4, 7, '2023-02-18 14:54:37', 2);
INSERT INTO COMANDA_BEGUDES VALUES (8, 4, 8, '2023-02-18 14:03:27', 1);