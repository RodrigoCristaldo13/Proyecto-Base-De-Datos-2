CREATE DATABASE FoodInspections
GO
USE FoodInspections
GO

--Creacion de las tablas:
CREATE TABLE Establecimientos(estNumero int identity not null, 
                              estNombre varchar(40) not null, 
							  estDireccion varchar(60) not null, 
							  estTelefono varchar(50), 
							  estLatitud money, 
							  estLongitud money,
							  constraint pk_Estab primary key(estNumero))
GO
CREATE TABLE Licencias(licNumero int identity not null, 
                       estNumero int not null, 
					   licFchEmision date, 
					   licFchVto date, 
					   licStatus character(3) not null,
					   constraint pk_Licencia primary key(licNumero),
					   constraint fk_EstLic foreign key(estNumero) references Establecimientos(estNumero),
					   constraint ck_StatusLic check(licStatus in ('APR','REV')))
GO
CREATE TABLE TipoViolacion(violCodigo int identity not null, 
                           violDescrip varchar(30) not null,
						   constraint pk_TipoViol primary key(violCodigo))
GO

CREATE TABLE Inspecciones(inspID int identity not null, 
                          inspFecha datetime, 
						  estNumero int not null, 
						  inspRiesgo varchar(15) not null, -- modifico agregando mayor longitud 
						  inspResultado varchar(25) not null, 
						  violCodigo int not null , 
						  inspComents varchar(100),
						  constraint pk_Inspect primary key(inspID),
						  constraint fk_EstabInsp foreign key(estNumero) references Establecimientos(estNumero),
						  constraint fk_ViolInsp foreign key(violCodigo) references TipoViolacion(violCodigo),
						  -- agrego 2 opciones mas de riesgo :
						  constraint ck_Riesgo check(inspRiesgo IN('Bajo','Medio','Alto','No aplica','Desconocido')), 
						  -- agrego 2 opciones mas de resultado de inspeccion:
						  constraint ck_Result check(inspResultado IN('Pasa', 'Falla', 'Pasa con condiciones', 'Oficina no encontrada'))) 
GO


/*
	1) Creación de índices que considere puedan ser útiles para optimizar las consultas (según criterio establecido en el curso).
*/

-- Creo indice para las columnas que son 'FK' dentro de la tabla:

CREATE NONCLUSTERED INDEX IDX_Inspecciones_estNumero ON Inspecciones(estNumero);
CREATE NONCLUSTERED INDEX IDX_Inspecciones_violCodigo ON Inspecciones(violCodigo);
CREATE NONCLUSTERED INDEX IDX_Licencias_estNumero ON Licencias(estNumero);

-- Probar para ver naturaleza de los indices creados en las tablas:
EXEC sp_helpindex 'Inspecciones';
EXEC sp_helpindex 'Licencias';

/*
	2) Ingreso de un juego completo de datos de prueba (será más valorada la calidad de los datos que la cantidad). 
*/

--Ingreso de datos de prueba:
INSERT INTO Establecimientos (estNombre, estDireccion, estTelefono, estLatitud, estLongitud)
VALUES 
    ('Don Andrés', 'Av.Lucas Obes 1054, Montevideo', '2336 6418', 40.7128, -74.0060),
    ('El Fogón', 'S. José 1080, Montevideo', '2900 0900', 34.0522, -118.2437),
    ('Carbonada', 'Francisco Joaquín Muñoz 3100, Montevideo', '099 652 984', 51.5074, -0.1278),
    ('El Gaucho', '18 de Julio y, Dr Javier Barrios Amorín 1393, Montevideo', '2900 3914', 35.6895, 139.6917),
    ('Francis Restaurant Punta Carretas', 'Luis de la Torre 502, Montevideo', '097 043 191', 35.6762, 139.6503),
    ('Pacharán Taberna Vasca', 'San José 1168 primer piso, Montevideo', '2902 3519', 40.7128, -74.0060),
    ('Hard Rock Cafe Montevideo', 'Rbla. Armenia 1624, Montevideo', '2628 4041', 34.0522, -118.2437),
    ('Chivitos Lo de Pepe', 'José L. Terra 2220, Montevideo', '2204 2988', 48.8566, 2.3522),
    ('Viejo Sancho', 'S. José 1229, Montevideo', '2900 4063', 40.7128, -74.0060),
    ('Pizzería Las Brasas', 'José Enrique Rodó 5056, Canelones', '4332 1807', -34.838397, -56.261102),
    ('Carro La Amistad', 'Gral. Fructuoso Rivera 105, Canelones', '096 523 623', -34.837841, -56.261357),
    ('Lo Del Vasco', 'Luis Alberto de Herrera 119, Canelones', '4332 2536', -34.838168, -56.261627),
    ('Aeroparador Canelones SUCN', 'Ruta 11 km 100.500, Canelones', '094 254 916', -34.836789, -56.261873),
    ('Pizzería Ner York', 'Blvr. Aparicio Saravia 164, Canelones', '4332 7846', -34.836272, -56.262105),
    ('El Horno de Soca', 'Calle Dr. Francisco Soca 360, Canelones', '092 333 432', -34.835696, -56.262339),
    ('Carrito "Me vale"', 'Dr. Cristóbal Cendan 509, Canelones', '091 204 237', -34.835128, -56.262562),
    ('Bar y Restaurante El Amarillo', 'Asamblea 437, Canelones', '4342 2744', -34.834612, -56.262780),
    ('Centro Bar', '25 de Mayo 551, San José', '4343 0842', -34.834072, -56.263007),
    ('Restaurante y Parrillada El Ombú', 'Ruta 3-General Jose Artigas km 93500, San José', '4342 7715', -34.833511, -56.263228),
	('Carrito "EZLATI"', 'Gral. Juan A. Lavalleja 837-821, San José', '092 849 133', -34.834072, -56.263007);


INSERT INTO TipoViolacion (violDescrip)
VALUES 
    ('Insectos en alimentos'),
    ('Superficie sucia'),
    ('Falta de lavado de manos'),
    ('Mal olor'),
    ('Almacenamiento incorrecto'),
    ('Falta de desinfección'),
    ('Productos vencidos'),
    ('Falta de seguridad'),
    ('Personal no capacitado'),
    ('Contaminación cruzada'),
	('Sin violación'),
    ('Establecimiento no encontrado');


INSERT INTO Licencias (estNumero, LicFchEmision, LicFchVto, LicStatus) 
VALUES 
/*
Posibilidad de agregar opción expirada 'EXP'.
Duracion de Licencias: (~ 6 meses) si inspección 'Pasa con condiciones'.
					   (~ 12 meses) si inspección 'Pasa'.
Riesgo 'Alto' en inspección implica licencia 'REV' hasta la proxima inspección en (~ 2 meses).		  
*/
    (1, '2024-05-22', '2024-11-22', 'APR'),
	(1, '2024-04-22', NULL, 'REV'),
	(1, '2024-02-21', NULL, 'REV'),
	(1, '2023-12-22', NULL, 'REV'),
	(1, '2023-06-22', '2023-12-22', 'APR'),
	(1, '2023-01-22', '2023-06-22', 'APR'),
	(1, '2022-07-22', '2023-01-22', 'APR'),
	(1, '2022-01-22', '2022-07-22', 'APR'),
	(1, '2021-07-22', '2022-01-22', 'APR'),
	(1, '2021-01-22', '2021-07-22', 'APR'),
	(1, '2020-01-22', '2021-01-22', 'APR'),
    (2, '2024-05-20', NULL, 'REV'),
    (2, '2023-11-20', '2024-05-20', 'APR'),
	(2, '2023-05-20', '2023-11-20', 'APR'),
    (2, '2022-12-19', '2023-05-19', 'APR'),
	(2, '2022-10-18', NULL, 'REV'),
    (2, '2022-08-19', NULL, 'REV'),
	(2, '2022-02-19', '2022-08-19', 'APR'),
    (2, '2021-08-19', '2022-02-19', 'APR'),
	(2, '2021-02-18', '2022-08-18', 'APR'),
    (2, '2020-08-18', '2021-02-18', 'APR'),
	(2, '2019-08-17', '2020-08-17', 'APR'),
    (3, '2024-06-14', NULL, 'REV'),
	(3, '2023-12-14', '2024-06-14', 'APR'),
	(3, '2023-06-14', '2023-12-14', 'APR'),
    (4, '2024-04-10', '2025-04-10', 'APR'),
	(4, '2023-10-10', '2024-04-10', 'APR'),
	(4, '2023-04-10', '2023-10-10', 'APR'),
    (5, '2024-04-05', '2024-07-05', 'APR'),
	(5, '2023-01-08', '2024-01-08', 'APR'),
    (6, '2024-05-10', NULL, 'REV'),
	(6, '2023-05-10', '2024-05-10', 'APR'),
	(6, '2022-05-10', '2023-05-10', 'APR'),
    (7, '2024-02-10', NULL, 'REV'), 
	(7, '2023-11-15', NULL, 'REV'), 
    (8, '2024-02-10', NULL, 'REV'),
	(8, '2023-08-10', '2024-02-10', 'APR'),
	(8, '2023-02-09', '2023-08-09', 'APR'),
    (9, '2024-04-25', '2025-04-25', 'APR'),
	(9, '2023-04-25', '2024-04-25', 'APR'),
    (10, '2024-03-10', NULL, 'REV'),
    (11, '2023-04-15', '2023-10-15', 'APR'), --vencida
    (12, '2023-12-17', '2024-05-17', 'APR'), --vencida
    (13, '2023-02-05', '2023-11-05', 'APR'), --vencida
    (14, '2023-11-25', '2024-05-25', 'APR'), --vencida
	(14, '2023-09-12', NULL, 'REV'),
    (15, '2024-01-19', '2024-06-19', 'APR'),
    (16, '2024-04-05', '2025-04-05', 'APR'),
    (17, '2024-04-20', NULL, 'REV'),
    (18, '2023-06-07', '2024-06-07', 'APR'), --vencida 
    (19, '2024-04-01', '2024-10-01', 'APR'),
    (20, '2024-03-25', '2024-09-25', 'APR'),
    (20, '2020-02-03', NULL, 'REV');



INSERT INTO Inspecciones (inspFecha, estNumero, inspRiesgo, inspResultado, violCodigo, inspComents)
VALUES
	--Insercion de 2 establecimientos con todos los tipos de violaciones:
	('2024-05-22', 1, 'Bajo', 'Pasa con condiciones', 7, 'Detección de 2 latas de salsa vencidas con fecha "2023-05-20".'),
	('2024-04-22', 1, 'Alto', 'Falla', 6, 'Detección de nula desinfección de superficies.'),
	('2024-02-21', 1, 'Alto', 'Falla', 9, 'Personal de cocina denota extrema falta de conocimiento.'),
	('2023-12-22', 1, 'Alto', 'Falla', 10, 'Detección de multiples factores de contaminación cruzada.'),
	('2023-06-22', 1, 'Medio', 'Pasa con condiciones', 1, 'Precencia algunos de insectos debido a plaga mal controlada'),
	('2023-01-22', 1, 'Medio', 'Pasa con condiciones', 2, 'Areas de preparación de alimentos con restos de polvo'),
	('2022-07-22', 1, 'Medio', 'Pasa con condiciones', 3, 'Detección de deficiente lavado de manos de personal de salon'),
	('2022-01-22', 1, 'Bajo', 'Pasa con condiciones', 4, 'Mal olor proveniente de baño de primera planta'),
	('2021-07-22', 1, 'Medio', 'Pasa con condiciones', 5, 'Productos perecederos no almacenados a temperatura adecuada'),
	('2021-01-22', 1, 'Medio', 'Pasa con condiciones', 8, 'Local no posee cantidad sugerida de extintores por m2'),
	('2020-01-22', 1, 'No aplica', 'Pasa', 11, 'Inspección satisfactoria.'),
	('2020-01-15', 1, 'Desconocido', 'Oficina no encontrada', 12, NULL),

	('2024-05-20', 2, 'Alto', 'Falla', 6, 'Residuos orgánicos no desinfectados, compromiso de seguridad alimentaria.'),
	('2023-11-20', 2, 'Medio', 'Pasa con condiciones', 8, 'Deficiencias en iluminación de zonas de evacuación'),
	('2023-05-20', 2, 'Bajo', 'Pasa con condiciones', 4, 'Mal olor proveniente de una bola de residuos'),
	('2022-12-19', 2, 'Bajo', 'Pasa con condiciones', 7, 'Paquete de arroz con fecha de vencimiento "17-04-2024".'),
	('2022-10-18', 2, 'Alto', 'Falla', 9, 'Todo el personal de cocina sin carnet de manipulación de alimentos.'),
	('2022-08-19', 2, 'Alto', 'Falla', 10, 'Fluidos de carnes crudas sobre productos listos para comer.'),
	('2022-02-19', 2, 'Medio', 'Pasa con condiciones', 1, 'Huevos de insectos en un paquete de harina'),
	('2021-08-19', 2, 'Medio', 'Pasa con condiciones', 2, 'Suelo de cocina con pequeños derrames sin limpiar'),
	('2021-02-18', 2, 'Medio', 'Pasa con condiciones', 3, 'Falta de lugares de lavado de manos en algunas áreas.'),
	('2020-08-18', 2, 'Medio', 'Pasa con condiciones', 5, 'Recipientes de alimentos mal etiquetados.'),
	('2019-08-17', 2, 'No aplica', 'Pasa', 11, 'Inspección satisfactoria.'),
	('2019-08-05', 2, 'Desconocido', 'Oficina no encontrada', 12, NULL),
    --Resto de inserciones de establecimientos:
	('2024-06-14', 3, 'Alto', 'Falla', 1, 'Pisos sin limpiar.'),
    ('2023-09-10', 3, 'Bajo', 'Pasa con condiciones', 2, 'Suciedad sobre algunas mesas'),
	('2023-06-15', 3, 'Bajo', 'Pasa con condiciones', 2, 'Detección de algunos restos de polvo sobre el lavamanos'),
	('2024-04-10', 4, 'No aplica', 'Pasa', 8, 'Ningún problema detectado.'),
    ('2023-10-10', 4, 'Medio', 'Pasa con condiciones', 9, 'Uso de cuchilla para cortar carnes crudas y alimentos cocinados'),
	('2023-04-10', 4, 'Bajo', 'Pasa con condiciones', 3, 'Personal de salón no se lava las manos con frecuencia'),
	('2024-04-05', 5, 'Medio', 'Pasa con condiciones', 7, 'Alimentos vencidos aun no utilizados en elaboraciones'),
    ('2024-02-09', 5, 'Desconocido', 'Oficina no encontrada', 12, NULL),
	('2023-01-08', 5, 'No aplica', 'Pasa', 11, 'Todo en orden'),
	('2024-05-10', 6, 'Alto', 'Falla', 2, 'Falta de guantes'),
   	('2023-05-10', 6, 'No aplica', 'Pasa', 11, 'Ningún problema detectado'),
	('2022-05-10', 6, 'No aplica', 'Pasa', 11, 'Ningún problema detectado'),
	('2024-02-10', 7, 'Alto', 'Falla', 2, 'Falta de elementos'),
    ('2023-11-15', 7, 'Alto', 'Falla', 1, 'Cocina sucia'),
	('2024-02-10', 8, 'Alto', 'Falla', 3, 'Congelador averiado'),
    ('2023-08-10', 8, 'Medio', 'Pasa con condiciones', 2, 'Falta de guantes'),
	('2023-02-09', 8, 'Medio', 'Pasa con condiciones', 2, 'Falta de guantes'),
   	('2024-04-25', 9, 'No aplica', 'Pasa', 11, 'Inspección exitosa'),
	('2023-04-25', 9, 'No aplica', 'Pasa', 11, 'Inspección exitosa'),
	('2024-03-10', 10, 'Alto', 'Falla', 4, 'Congelador averiado'),
	('2024-04-15', 11, 'Medio', 'Pasa con condiciones', 8, 'Deficiencias en iluminación de zonas de evacuación'),
	('2023-12-17', 12, 'Bajo', 'Pasa con condiciones', 7, 'Vencimiento de 2 bolsones de arroz blanco'),
    ('2023-02-05', 13, 'Medio', 'Pasa con condiciones', 2, 'Falta de guantes'),
	('2023-11-25', 14, 'Medio', 'Pasa con condiciones', 4, 'Mal olor proveniente de subsuelo'),
	('2023-09-12', 14, 'Alto', 'Falla', 5, 'Almacenamiento incorrecto de alimentos'),
	('2024-04-10', 15, 'Medio', 'Pasa con condiciones', 2, 'Suciedad en mesas de salón y paredes de cocina'),
    ('2024-04-05', 16, 'No aplica', 'Pasa', 11, 'Inspección exitosa'),
	('2024-04-20', 17, 'Alto', 'Falla', 3, 'No aire acondicionado'),
	('2023-06-07', 18, 'No aplica', 'Pasa', 11, 'Inspección exitosa'),
	('2024-04-01', 19, 'Bajo', 'Pasa con condiciones', 9, NULL), --comentario vacio
	('2020-04-05', 20, 'Medio', 'Pasa con condiciones', 8, NULL),--comentario vacio
	('2020-02-03', 20, 'Alto', 'Falla', 3, NULL); --comentario vacio