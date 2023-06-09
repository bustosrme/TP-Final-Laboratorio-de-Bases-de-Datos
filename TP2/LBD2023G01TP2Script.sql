-- Año: 2023
-- Grupo Nro: 01
-- Integrantes:
--               Bustos Roldan Mauro Exequiel
--               Fernandez Siles Joaquin
-- Tema: TecManager
-- Nombre del Esquema LBD2023G01TecManager
-- Plataforma (SO + Versión): Ubuntu 22.04.02 LTS
-- Motor y Versión: MySQL Workbench 8.0.32 (Community Edition)
-- GitHub Repositorio: LBD2023G01
-- GitHub Usuario: bustosrme, JoaFS

USE `LBD2023G01`;

-- PUNTO 1: Dado un cliente, listar todos sus equipos. Mostrar apellido, nombre razon social y cuit,
-- 			marca y modelo del equipo.

SELECT Operador.apellido, Operador.nombre, Clientes.razonSocial, Clientes.CUIT, Marcas.nombre, Modelos.nombre
FROM 	((((Clientes JOIN Operador ON Clientes.idCliente = Operador.idCliente)
		JOIN Equipos ON Operador.idCliente = Equipos.idCliente AND Operador.idOperador = Equipos.idOperador)
        JOIN Modelos ON Equipos.idModelo = Modelos.idModelo AND Equipos.idMarca = Modelos.idMarca)
        JOIN Marcas ON Modelos.idMarca = Marcas.idMarca)
        WHERE Clientes.idCliente = 1;

-- Punto 2
-- Realizar un listado de mensajes agrupados por Operador.

SELECT m.idOperador, m.mensaje 
FROM Mensajes m  
GROUP BY m.mensaje, m.idOperador;

-- Punto 3
-- Realizar un listado de servicios: id, fechas de inicio y fin, apellido, nombre y dni del
-- cliente, marca, modelo y categoría de equipo. Ordenar por la fecha de inicio del servicio en
-- forma descendente.

SELECT s.idServicio, s.fechaAlta, s.fechaFin, 
op.apellido, op.nombre, c.razonSocial, c.CUIT, ma.nombre AS Marca,
mo.nombre as Modelo, ca.nombre AS Categoria
FROM (((((((Servicios s JOIN Clientes c ON s.idCliente = c.idCliente)
JOIN LineaServicio ls ON s.idServicio = ls.idServicio AND ls.idCliente = s.idCliente)
JOIN Equipos e ON ls.idEquipo = e.idEquipo AND ls.idOperador = e.idOperador AND ls.idCliente AND e.idCliente)
JOIN Operador op ON e.idOperador = op.idOperador AND e.idCliente = op.idCliente)
JOIN Modelos mo ON e.idModelo = mo.idModelo AND e.idMarca = mo.idMarca)
JOIN Marcas ma ON mo.idMarca = ma.idMarca)
JOIN Categorias ca ON e.idCategoria = ca.idCategoria)
ORDER BY s.fechaAlta DESC;

-- Punto 4
-- Dado un rango de fechas, mostrar día a día el total de servicios realizados. El formato
-- deberá ser: Fecha, Total de servicios

SELECT count(fechaFin) AS 'Total Servicios Realizados', fechaFin 
FROM Servicios
WHERE DATE(fechaFin) <= '2023-05-19' && DATE(fechaFin) >= '2023-05-03'
GROUP BY fechaFin;

-- PUNTO 5: Hacer un ranking con los 10 servicios que más realizaron. Mostrar el tipo y el total de
-- 			servicios en forma descendente.

SELECT COUNT(Servicios.idServicio) AS 'Servicios más realizados', TipoServicio.descripcion
FROM Servicios JOIN TipoServicio ON Servicios.idTipoServicio = TipoServicio.idTipoServicio
GROUP BY TipoServicio.idTipoServicio
ORDER BY COUNT(Servicios.idServicio) DESC
LIMIT 10;

-- Punto 6
-- Hacer un ranking con los TODOS servicios que realizaron. Mostrar el tipo y el total de
-- servicios en forma descendente. Debe contemplar el caso donde existan TipoServicio que
-- no se hicieron (mostrando el valor en 0).

SELECT t.descripcion, count(s.idServicio)
FROM TipoServicio t LEFT JOIN Servicios s
ON t.idTipoServicio = s.idTipoServicio
GROUP BY t.descripcion
ORDER BY count(s.idServicio) DESC;

-- PUNTO 7: Hacer un ranking con los 10 tipos de servicio más costosos. Mostrar fecha, el nombre del
-- 			tipo de servicio, la cantidad de líneas realizadas, y el precio total.

SELECT Servicios.idServicio AS 'Servicios más costosos', Servicios.fechaFin, Servicios.descripcion, LineaServicio.precio
FROM Servicios JOIN LineaServicio ON Servicios.idServicio = LineaServicio.idServicio AND Servicios.idCliente = LineaServicio.idCliente
GROUP BY Servicios.idServicio, Servicios.fechaFin, Servicios.descripcion, LineaServicio.precio
ORDER BY LineaServicio.precio DESC
LIMIT 10;


-- Punto 8
-- Crear una vista con la funcionalidad del apartado 3.

DROP VIEW IF EXISTS V_Servicios;

CREATE VIEW V_Servicios
AS 
	SELECT s.idServicio, s.fechaAlta, s.fechaFin, 
		op.apellido, op.nombre, c.razonSocial, c.CUIT, ma.nombre AS Marca,
		mo.nombre as Modelo, ca.nombre AS Categoria
	FROM (((((((Servicios s JOIN Clientes c ON s.idCliente = c.idCliente)
	JOIN LineaServicio ls ON s.idServicio = ls.idServicio)
	JOIN Equipos e ON ls.idEquipo = e.idEquipo)
	JOIN Operador op ON e.idOperador = op.idOperador)
	JOIN Modelos mo ON e.idModelo = mo.idModelo)
	JOIN Marcas ma ON mo.idMarca = ma.idMarca)
	JOIN Categorias ca ON e.idCategoria = ca.idCategoria)
	ORDER BY s.fechaAlta DESC;

SELECT * FROM V_Servicios;

-- Punto 9
-- Crear una copia de la tabla operador, llamada OperadorJSON, que tenga una columna
-- del tipo JSON para guardar los mensajes. Llenar esta tabla con los mismos datos del TP1 y
-- resolver la consulta del apartado 2 (ambas consultas deben presentar la misma salida).

DROP TABLE IF EXISTS `OperadorJSON`;

CREATE TABLE IF NOT EXISTS `OperadorJSON`(
    `idOperador` 	INT 	AUTO_INCREMENT NOT NULL,
    `idCliente` 	INT 	NOT NULL,
    `apellido`		VARCHAR(30) 	NOT NULL CHECK (apellido != ''),
    `nombre`        VARCHAR(30)    	NOT NULL CHECK (nombre != ''),
    `atributos` 	JSON NOT NULL,
	PRIMARY KEY (`idOperador`, `idCliente`),
    CONSTRAINT `FK_IDCliente` FOREIGN KEY (`idCliente`) REFERENCES `Clientes`(`idCliente`) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX `IX_CLIENTE`(`idCliente` ASC)
);

SHOW INDEX FROM OperadorJSON;

INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (1, 'López', 'Juan', JSON_OBJECT(
        "usuario",'juanito', 
        "pass",'contraseña1', 
        "email",'juanito@example.com', 
        "estado",'1', 
        "idConexionRemota",'123456',
        "passConexionRemota",'pass123'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (1, 'García', 'María', JSON_OBJECT(
        "usuario",'mariag', 
        "pass",'contraseña2', 
        "email",'maria@example.com', 
        "estado",'1', 
        "idConexionRemota",'654321',
        "passConexionRemota",'pass321'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (1, 'Rodríguez', 'Carlos', JSON_OBJECT(
        "usuario",'carlitos', 
        "pass",'contraseña3', 
        "email",'carlos@example.com', 
        "estado",'1', 
        "idConexionRemota",'987654',
        "passConexionRemota",'pass987'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (1, 'Martínez', 'Laura', JSON_OBJECT(
        "usuario",'lauram', 
        "pass",'contraseña4', 
        "email",'laura@example.com', 
        "estado",'1', 
        "idConexionRemota",'456789',
        "passConexionRemota",'pass456'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (2, 'González', 'Pedro', JSON_OBJECT(
        "usuario",'pedrog2', 
        "pass",'contraseña5', 
        "email",'pedro2@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (2, 'Fernández', 'Ana', JSON_OBJECT(
        "usuario",'anafernandez2', 
        "pass",'contraseña6', 
        "email",'ana2@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (2, 'Vargas', 'Diego', JSON_OBJECT(
        "usuario",'diegov2', 
        "pass",'contraseña7', 
        "email",'diego2@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (2, 'Torres', 'Sofía', JSON_OBJECT(
        "usuario",'sofiat2', 
        "pass",'contraseña8', 
        "email",'sofia2@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (3, 'Sánchez', 'Luis', JSON_OBJECT(
        "usuario",'luiss3', 
        "pass",'contraseña9', 
        "email",'luis3@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (3, 'López', 'Marta', JSON_OBJECT(
        "usuario",'martal3', 
        "pass",'contraseña10', 
        "email",'marta3@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (3, 'Gómez', 'Andrés', JSON_OBJECT(
        "usuario",'andresg3', 
        "pass",'contraseña11', 
        "email",'andres3@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (3, 'Fernández', 'Carolina', JSON_OBJECT(
        "usuario",'carolinaf3', 
        "pass",'contraseña12', 
        "email",'carolina3@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (4, 'Martínez', 'Pablo', JSON_OBJECT(
        "usuario",'pablom4', 
        "pass",'contraseña13', 
        "email",'pablo4@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (4, 'Vargas', 'Lucía', JSON_OBJECT(
        "usuario",'lucia_v4', 
        "pass",'contraseña14', 
        "email",'lucia4@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (4, 'Torres', 'Roberto', JSON_OBJECT(
        "usuario",'robertot4', 
        "pass",'contraseña15', 
        "email",'roberto4@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (4, 'Sánchez', 'Isabel', JSON_OBJECT(
        "usuario",'isabels4', 
        "pass",'contraseña16', 
        "email",'isabel4@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (5, 'González', 'Luisa', JSON_OBJECT(
        "usuario",'luisag5', 
        "pass",'contraseña17', 
        "email",'luisa5@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (5, 'Hernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlosh5', 
        "pass",'contraseña18', 
        "email",'carlos5@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (5, 'Romero', 'Ana', JSON_OBJECT(
        "usuario",'anar5', 
        "pass",'contraseña19', 
        "email",'ana5@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (5, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedrol5', 
        "pass",'contraseña20', 
        "email",'pedro5@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (6, 'Fernández', 'María', JSON_OBJECT(
        "usuario",'mariaf6', 
        "pass",'contraseña21', 
        "email",'maria6@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (6, 'Gómez', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_g6', 
        "pass",'contraseña22', 
        "email",'carlos6@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (6, 'Sánchez', 'Laura', JSON_OBJECT(
        "usuario",'lauras6', 
        "pass",'contraseña23', 
        "email",'laura6@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (6, 'Martínez', 'Javier', JSON_OBJECT(
        "usuario",'javierm6', 
        "pass",'contraseña24', 
        "email",'javier6@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (7,"Doe", "Juan",JSON_OBJECT(
        "usuario","user1",
        "pass","pass",
        "email","mail1@empresa.com",
        "estado","1",
        "idConexionRemota",'1212341',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (7,"Doe", "Jane",JSON_OBJECT(
        "usuario","user2",
        "pass","pass",
        "email","mail2@empresa.com",
        "estado","1",
        "idConexionRemota",'1212342',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (7,"Cabrera","Miguel",JSON_OBJECT(
        "usuario","user3",
        "pass","pass",
        "email","mail3@empresa.com",
        "estado","1",
        "idConexionRemota",'1212343',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (7,"Nieto","Luis",JSON_OBJECT(
        "usuario","user4",
        "pass","pass",
        "email","mail4@empresa.com",
        "estado","1",
        "idConexionRemota",'1212344',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (8,"Estevez","Miguel",JSON_OBJECT(
        "usuario","user5",
        "pass","pass",
        "email","mail5@empresa.com",
        "estado","1",
        "idConexionRemota",'12123445',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (8,"Rossi","Guillermo",JSON_OBJECT(
        "usuario","user6",
        "pass","pass",
        "email","mail6@empresa.com",
        "estado","1",
        "idConexionRemota",'1212345',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (8, "Di Pinto","Luis Roque",JSON_OBJECT(
        "usuario","user7",
        "pass","pass",
        "email","mail7@empresa.com",
        "estado","1",
        "idConexionRemota",'1212346',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (8,"Olmos","Aida",JSON_OBJECT(
        "usuario","user8",
        "pass","pass8",
        "email","mail8@empresa.com",
        "estado","1",
        "idConexionRemota",'1212347',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (9,"Sueldo","Carlos",JSON_OBJECT(
        "usuario","user9",
        "pass","pass9",
        "email","mail9@empresa.com",
        "estado","1",
        "idConexionRemota",'1212348',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (9,"Volentini","Estevan",JSON_OBJECT(
        "usuario","user10",
        "pass","pass",
        "email","mail10@empresa.com",
        "estado","1",
        "idConexionRemota",'1212349',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (9, "Majorel Padilla","Nicolas",JSON_OBJECT(
        "usuario","user11",
        "pass","pass",
        "email","mail11@empresa.com",
        "estado","1",
        "idConexionRemota",'1212340',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (9,"Giori","Gustavo",JSON_OBJECT(
        "usuario","user12",
        "pass","pass",
        "email","mail12@empresa.com",
        "estado","1",
        "idConexionRemota",'12123490',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (10,"Giori","Matias",JSON_OBJECT(
        "usuario","user13",
        "pass","pass",
        "email","mail13@empresa.com",
        "estado","1",
        "idConexionRemota",'12123489',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (10,"Becker","Erica",JSON_OBJECT(
        "usuario","user14",
        "pass","pass",
        "email","mail14@empresa.com",
        "estado","1",
        "idConexionRemota",'12123487',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (10,"Guzman","Fernanda",JSON_OBJECT(
        "usuario","user15",
        "pass","pass",
        "email","mail15@empresa.com",
        "estado","1",
        "idConexionRemota",'12123465',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (10,"Mendiondo","Matias",JSON_OBJECT(
        "usuario","user16",
        "pass","pass",
        "email","mail16@empresa.com",
        "estado","1",
        "idConexionRemota",'12123454',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (11,"Odstrcil","Maxi",JSON_OBJECT(
        "usuario","user17",
        "pass","pass",
        "email","mail17@empresa.com",
        "estado","1",
        "idConexionRemota",'12123443',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (11, "Gomez Lopez","Maria de los Angeles",JSON_OBJECT(
        "usuario","user18",
        "pass","pass",
        "email","mail18@empresa.com",
        "estado","1",
        "idConexionRemota",'12123432',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (11,"Juarez","Martin",JSON_OBJECT(
        "usuario","user19",
        "pass","pass",
        "email","mail19@empresa.com",
        "estado","1",
        "idConexionRemota",'12123421',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (11,"Perez","Juan",JSON_OBJECT(
        "usuario","user20",
        "pass","pass20",
        "email","mail20@empresa.com",
        "estado","1",
        "idConexionRemota",'12123412',
        "passConexionRemota",'pass000'
    )
);
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (12, 'García', 'Luis', JSON_OBJECT(
        "usuario",'luisg12', 
        "pass",'contraseña25', 
        "email",'luis12@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (12, 'Martínez', 'Ana', JSON_OBJECT(
        "usuario",'anam12', 
        "pass",'contraseña26', 
        "email",'ana12@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (12, 'López', 'Carlos', JSON_OBJECT(
        "usuario",'carlosl12', 
        "pass",'contraseña27', 
        "email",'carlos12@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (12, 'González', 'María', JSON_OBJECT(
        "usuario",'mariag12', 
        "pass",'contraseña28', 
        "email",'maria12@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (13, 'Fernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedrof13', 
        "pass",'contraseña29', 
        "email",'pedro13@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (13, 'Gómez', 'Laura', JSON_OBJECT(
        "usuario",'laurag13', 
        "pass",'contraseña30', 
        "email",'laura13@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (13, 'Sánchez', 'Carlos', JSON_OBJECT(
        "usuario",'carloss13', 
        "pass",'contraseña31', 
        "email",'carlos13@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (13, 'Hernández', 'María', JSON_OBJECT(
        "usuario",'mariah13', 
        "pass",'contraseña32', 
        "email",'maria13@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (14, 'Martínez', 'Carlos', JSON_OBJECT(
        "usuario",'carlosm14', 
        "pass",'contraseña33', 
        "email",'carlos14@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (14, 'López', 'Laura', JSON_OBJECT(
        "usuario",'laural14', 
        "pass",'contraseña34', 
        "email",'laura14@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (14, 'González', 'Pedro', JSON_OBJECT(
        "usuario",'pedrog14', 
        "pass",'contraseña35', 
        "email",'pedro14@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (14, 'Fernández', 'María', JSON_OBJECT(
        "usuario",'mariag14', 
        "pass",'contraseña36', 
        "email",'maria14@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (15, 'Gómez', 'Carlos', JSON_OBJECT(
        "usuario",'carlosg15', 
        "pass",'contraseña37', 
        "email",'carlos15@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (15, 'Hernández', 'Laura', JSON_OBJECT(
        "usuario",'laurah15', 
        "pass",'contraseña38', 
        "email",'laura15@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (15, 'Martínez', 'Pedro', JSON_OBJECT(
        "usuario",'pedrom15', 
        "pass",'contraseña39', 
        "email",'pedro15@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (15, 'López', 'María', JSON_OBJECT(
        "usuario",'marial15', 
        "pass",'contraseña40', 
        "email",'maria15@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (16, 'González', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_g16', 
        "pass",'contraseña41', 
        "email",'carlos16@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (16, 'Hernández', 'Laura', JSON_OBJECT(
        "usuario",'laura_h16', 
        "pass",'contraseña42', 
        "email",'laura16@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (16, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l16', 
        "pass",'contraseña43', 
        "email",'pedro16@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (16, 'García', 'María', JSON_OBJECT(
        "usuario",'maria_g16', 
        "pass",'contraseña44', 
        "email",'maria16@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (17, 'Fernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_f17', 
        "pass",'contraseña45', 
        "email",'carlos17@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (17, 'Gómez', 'Laura', JSON_OBJECT(
        "usuario",'laura_g17', 
        "pass",'contraseña46', 
        "email",'laura17@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (17, 'Hernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_h17', 
        "pass",'contraseña47', 
        "email",'pedro17@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (17, 'Martínez', 'María', JSON_OBJECT(
        "usuario",'maria_m17', 
        "pass",'contraseña48', 
        "email",'maria17@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (18, 'López', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_l18', 
        "pass",'contraseña49', 
        "email",'carlos18@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (18, 'García', 'Laura', JSON_OBJECT(
        "usuario",'laura_g18', 
        "pass",'contraseña50', 
        "email",'laura18@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (18, 'Fernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_f18', 
        "pass",'contraseña51', 
        "email",'pedro18@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (18, 'Gómez', 'María', JSON_OBJECT(
        "usuario",'maria_g18', 
        "pass",'contraseña52', 
        "email",'maria18@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (19, 'Hernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_h19', 
        "pass",'contraseña53', 
        "email",'carlos19@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (19, 'Martínez', 'Laura', JSON_OBJECT(
        "usuario",'laura_m19', 
        "pass",'contraseña54', 
        "email",'laura19@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (19, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l19', 
        "pass",'contraseña55', 
        "email",'pedro19@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (19, 'Fernández', 'María', JSON_OBJECT(
        "usuario",'maria_f19', 
        "pass",'contraseña56', 
        "email",'maria19@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (20, 'Gómez', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_g20', 
        "pass",'contraseña57', 
        "email",'carlos20@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (20, 'Hernández', 'Laura', JSON_OBJECT(
        "usuario",'laura_h20', 
        "pass",'contraseña58', 
        "email",'laura20@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (20, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l20', 
        "pass",'contraseña59', 
        "email",'pedro20@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (20, 'García', 'María', JSON_OBJECT(
        "usuario",'maria_g20', 
        "pass",'contraseña60', 
        "email",'maria20@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (21, 'Fernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_f21', 
        "pass",'contraseña61', 
        "email",'carlos21@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (21, 'Gómez', 'Laura', JSON_OBJECT(
        "usuario",'laura_g21', 
        "pass",'contraseña62', 
        "email",'laura21@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (21, 'Hernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_h21', 
        "pass",'contraseña63', 
        "email",'pedro21@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (21, 'Martínez', 'María', JSON_OBJECT(
        "usuario",'maria_m21', 
        "pass",'contraseña64', 
        "email",'maria21@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (22, 'López', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_l22', 
        "pass",'contraseña65', 
        "email",'carlos22@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (22, 'García', 'Laura', JSON_OBJECT(
        "usuario",'laura_g22', 
        "pass",'contraseña66', 
        "email",'laura22@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (22, 'Fernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_f22', 
        "pass",'contraseña67', 
        "email",'pedro22@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (22, 'Gómez', 'María', JSON_OBJECT(
        "usuario",'maria_g22', 
        "pass",'contraseña68', 
        "email",'maria22@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (23, 'Hernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_h23', 
        "pass",'contraseña69', 
        "email",'carlos23@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (23, 'Martínez', 'Laura', JSON_OBJECT(
        "usuario",'laura_m23', 
        "pass",'contraseña70', 
        "email",'laura23@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (23, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l23', 
        "pass",'contraseña71', 
        "email",'pedro23@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (23, 'Fernández', 'María', JSON_OBJECT(
        "usuario",'maria_f23', 
        "pass",'contraseña72', 
        "email",'maria23@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (24, 'González', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_g24', 
        "pass",'contraseña73', 
        "email",'carlos24@example.com', 
        "estado",'1', 
        "idConexionRemota",'888999',
        "passConexionRemota",'pass888'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (24, 'Hernández', 'Laura', JSON_OBJECT(
        "usuario",'laura_h24', 
        "pass",'contraseña74', 
        "email",'laura24@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (24, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l24', 
        "pass",'contraseña75', 
        "email",'pedro24@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (24, 'García', 'María', JSON_OBJECT(
        "usuario",'maria_g24', 
        "pass",'contraseña76', 
        "email",'maria24@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (25, 'Fernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_f25', 
        "pass",'contraseña77', 
        "email",'carlos25@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (25, 'Gómez', 'Laura', JSON_OBJECT(
        "usuario",'laura_g25', 
        "pass",'contraseña78', 
        "email",'laura25@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (25, 'Hernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_h25', 
        "pass",'contraseña79', 
        "email",'pedro25@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (25, 'Martínez', 'María', JSON_OBJECT(
        "usuario",'maria_m25', 
        "pass",'contraseña80', 
        "email",'maria25@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (26, 'López', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_l26', 
        "pass",'contraseña81', 
        "email",'carlos26@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (26, 'García', 'Laura', JSON_OBJECT(
        "usuario",'laura_g26', 
        "pass",'contraseña82', 
        "email",'laura26@example.com', 
        "estado",'1',
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (26, 'Hernández', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_h26', 
        "pass",'contraseña83', 
        "email",'pedro26@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (26, 'Martínez', 'María', JSON_OBJECT(
        "usuario",'maria_m26', 
        "pass",'contraseña84', 
        "email",'maria26@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (27, 'González', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_g27', 
        "pass",'contraseña85', 
        "email",'carlos27@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (27, 'Fernández', 'Laura', JSON_OBJECT(
        "usuario",'laura_f27', 
        "pass",'contraseña86', 
        "email",'laura27@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (27, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l27', 
        "pass",'contraseña87', 
        "email",'pedro27@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (27, 'García', 'María', JSON_OBJECT(
        "usuario",'maria_g27', 
        "pass",'contraseña88', 
        "email",'maria27@example.com', 
        "estado",'1', 
        "idConexionRemota",'777888',
        "passConexionRemota",'pass777'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (28, 'Hernández', 'Carlos', JSON_OBJECT(
        "usuario",'carlos_h28', 
        "pass",'contraseña89', 
        "email",'carlos28@example.com', 
        "estado",'1', 
        "idConexionRemota",'999000',
        "passConexionRemota",'pass999'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (28, 'Martínez', 'Laura', JSON_OBJECT(
        "usuario",'laura_m28', 
        "pass",'contraseña90', 
        "email",'laura28@example.com', 
        "estado",'1', 
        "idConexionRemota",'111222',
        "passConexionRemota",'pass111'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (28, 'López', 'Pedro', JSON_OBJECT(
        "usuario",'pedro_l28', 
        "pass",'contraseña91', 
        "email",'pedro28@example.com', 
        "estado",'1', 
        "idConexionRemota",'333444',
        "passConexionRemota",'pass333'
    )
 );
INSERT INTO `OperadorJSON` (`idCliente`,`apellido`,`nombre`,`atributos`)VALUES (28, 'González', 'María', JSON_OBJECT(
        "usuario",'maria_g28', 
        "pass",'contraseña92', 
        "email",'maria28@example.com', 
        "estado",'1', 
        "idConexionRemota",'555666',
        "passConexionRemota",'pass555'
    )
 );
 
SELECT m.idOperador, m.mensaje 
FROM Mensajes m JOIN OperadorJSON op
ON m.idOperador = op.idOperador
GROUP BY m.mensaje, m.idOperador;

-- Punto 10:     Realizar una vista que considere importante para su modelo:
--                 MOSTRAR TODOS LOS TICKETS DE LOS CLIENTES QUE NO ESTÉN FINALIZADOS. MOSTRAR
--                 OPERADOR QUE SOLICITÓ EL TICKET, LA FECHA DE ALTA, DE RECEPCIÓN Y SU DESCRIPCIÓN.

DROP VIEW IF EXISTS V_Tickets;

CREATE VIEW V_Tickets
AS
    SELECT Tickets.idTicket, Tickets.fechaRecibe, Tickets.fechaAlta, Tickets.descripcion, Operador.nombre, Operador.apellido
    FROM Tickets JOIN Operador ON Tickets.idOperador = Operador.idOperador AND Tickets.idCliente = Operador.idCliente
    WHERE Tickets.fechaFin IS NULL;

SELECT * FROM V_Tickets;