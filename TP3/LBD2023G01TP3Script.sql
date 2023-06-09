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

-- Triggers
-- Se deberá auditar el tipo de operación que se realizó (creación, borrado,
-- modificación), el usuario que la hizo, la fecha y hora de la operación, la máquina
-- desde donde se la hizo y todas las información necesaria para la auditoría (en el caso
-- de las modificaciones, se deberán auditar tanto los valores viejos como los nuevos).

-- implementar la lógica para llevar una auditoría para todos los apartados siguientes de las operaciones de:

DROP TABLE IF EXISTS `AuditoriaServicios` ;

CREATE TABLE IF NOT EXISTS `AuditoriaServicios` (
  `ID` 					INT NOT NULL AUTO_INCREMENT,
  `IDServicio` 			INT NOT NULL,
  `Descripcion` 		VARCHAR(255) NOT NULL,
  `Precio` 				DECIMAL(15, 2) NOT NULL,
  `FechaAlta` 			DATETIME NOT NULL,
  `FechaFinalizacion` 	DATETIME NULL,
  `Tipo` 				CHAR(1) NOT NULL, -- tipo de operación (I: Inserción, B: Borrado, M: Modificación)
  `Usuario` 			VARCHAR(45) NOT NULL,  
  `Maquina` 			VARCHAR(45) NOT NULL,  
  `Fecha` 				DATETIME NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=INNODB;

-- 1. Creación
DROP TRIGGER IF EXISTS `Trig_Servicios_Insercion`;

DELIMITER //
CREATE TRIGGER `Trig_Servicios_Insercion` 
AFTER INSERT ON `Servicios` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaServicios VALUES (
		DEFAULT, 
		NEW.IDServicio,
		NEW.Descripcion, 
        NEW.Precio,
        NEW.FechaAlta,
        NEW.FechaFin,
		'I', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
	);
END //
DELIMITER ;

INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio, fechaAlta) VALUES (6, 13, 'Servicio 42', 4.75, '2023-05-11 10:15:00');
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio, fechaAlta) VALUES (28, 2, 'Servicio 43', 21.99, '2023-05-10 13:40:00');
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio, fechaAlta) VALUES (14, 4, 'Servicio 44', 40.25, '2023-05-09 17:05:00');
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio, fechaAlta) VALUES (2, 6, 'Servicio 45', 20.50, '2023-05-08 20:30:00');

SELECT * FROM Servicios;
SELECT * FROM AuditoriaServicios;


-- 2. Modificación
DROP TRIGGER IF EXISTS `Trig_Servicios_Modificacion` ;

DELIMITER //
CREATE TRIGGER `Trig_Servicios_Modificacion` 
AFTER UPDATE ON `Servicios` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaServicios VALUES (
		DEFAULT, 
		OLD.IDServicio,
		OLD.Descripcion, 
        OLD.Precio,
        OLD.FechaAlta,
        OLD.FechaFin,
		'M', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
	);
    INSERT INTO AuditoriaServicios VALUES (
		DEFAULT, 
		NEW.IDServicio,
		NEW.Descripcion, 
        NEW.Precio,
        NEW.FechaAlta,
        NEW.FechaFin,
		'M', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
	);
END //
DELIMITER ;

UPDATE Servicios SET fechaFin = '2023-06-01' WHERE idServicio = 42;
UPDATE Servicios SET fechaFin = '2023-06-01' WHERE idServicio = 44;
UPDATE Servicios SET fechaFin = '2023-06-01' WHERE idServicio = 45;

SELECT * FROM AuditoriaServicios;


-- 3. Borrado
DROP TRIGGER IF EXISTS `Trig_Servicios_Borrado` ;
DROP TRIGGER IF EXISTS `Trig_AuditoriaServicios_Borrado`;
DELIMITER //
CREATE TRIGGER `Trig_Servicios_Borrado` 
AFTER DELETE ON `Servicios` FOR EACH ROW
BEGIN
	INSERT INTO AuditoriaServicios VALUES (
		DEFAULT, 
		OLD.IDServicio,
		OLD.Descripcion, 
        OLD.Precio,
        OLD.FechaAlta,
        OLD.FechaFin,
		'B', 
		SUBSTRING_INDEX(USER(), '@', 1), 
		SUBSTRING_INDEX(USER(), '@', -1), 
		NOW()
  );
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER `Trig_AuditoriaServicios_Borrado` 
BEFORE DELETE ON `AuditoriaServicios` FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: no se puede borrar de la tabla AuditoriaServicios';
END //
DELIMITER ;

DELETE FROM Servicios WHERE idServicio=42;
DELETE FROM Servicios WHERE idServicio=45;

SELECT * FROM AuditoriaServicios;

DELETE FROM AuditoriaServicios WHERE id=5; -- No permite el borrado en la tabla AuditoriaServicios


-- Procedimientos almacenados: Realizar (lo más eficientemente posible) los siguientes
-- procedimientos almacenados, incluyendo el control de errores lógicos y mensajes de error:
-- 4. Creación de un Servicio.

DROP PROCEDURE IF EXISTS AltaServicio;

DELIMITER //
CREATE PROCEDURE AltaServicio (pIDCliente INT, pIDTipoServicio INT, pDescripcion VARCHAR(255), pPrecio DECIMAL (15,2), pFechaAlta DATETIME, OUT mensaje VARCHAR (100))
SALIR: BEGIN
	IF NOT EXISTS (SELECT * FROM Clientes WHERE idCliente = pIDCliente) THEN
		SET mensaje = 'Error - No existe el cliente';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM TipoServicio WHERE idTipoServicio = pIDTipoServicio) THEN
		SET mensaje = 'Error - No existe el Tipo de Servicio';
		LEAVE SALIR;
	ELSEIF (pDescripcion IS NULL) OR (LENGTH(pDescripcion) > 10) THEN
		SET mensaje = 'Error - Complete la descripcion';
		LEAVE SALIR;
	ELSEIF (pPrecio IS NULL) OR (pPrecio < 0) THEN
		SET mensaje = 'Error - Precio incorrecto';
		LEAVE SALIR;
	ELSE
		START TRANSACTION;
			INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio, fechaAlta) 
				VALUES (pIDCliente, pIDTipoServicio, pDescripcion, pPrecio, pFechaAlta);
			SET mensaje = 'Servicio creado con éxito';
        COMMIT;
	END IF;
END //
DELIMITER ;

CALL AltaServicio (2, 6, 'Servicio 46', 20.50, '2023-05-08 20:30:00', @resultado);	-- funciona
SELECT @resultado; -- Reviso el valor del parámetro de salida
SELECT * FROM Servicios;
CALL AltaServicio (2, 6, 'Servicio 46', -100, '2023-05-08 20:30:00', @resultado);	-- no funciona, precio negativo
SELECT @resultado; -- Reviso el valor del parámetro de salida
CALL AltaServicio (2, 6, '', 20.50, '2023-05-08 20:30:00', @resultado);				-- no funciona, descripcion vacia o nula
SELECT @resultado; -- Reviso el valor del parámetro de salida
CALL AltaServicio (200, 6, 'Servicio 46', 20.50, '2023-05-08 20:30:00', @resultado); -- no funciona, cliente inexistente
SELECT @resultado; -- Reviso el valor del parámetro de salida


-- 5. Modificación de un Servicio.




-- 6. Borrado de un Servicio.


DROP PROCEDURE IF EXISTS BorrarServicio;

DELIMITER //
CREATE PROCEDURE BorrarServicio (pIDServicio INT, pIDCliente INT, OUT mensaje VARCHAR (100))
SALIR: BEGIN
	IF NOT EXISTS (SELECT * FROM Clientes WHERE idCliente = pIDCliente) THEN
		SET mensaje = 'Error - No existe el cliente';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM Servicios WHERE idServicio = pIDServicio AND idCliente = pIDCliente) THEN
		SET mensaje = 'Error - No existe el servicio';
        LEAVE SALIR;
	ELSE
		START TRANSACTION;
			DELETE FROM Servicios WHERE idServicio = pIDServicio AND idCliente = pIDCliente;
			SET mensaje = 'Servicio borrado con éxito';
        COMMIT;
	END IF;
END //
DELIMITER ;

SELECT * FROM Servicios;

CALL BorrarServicio (41,2,@result);			-- funciona
SELECT * FROM Servicios;
SELECT @result;
CALL BorrarServicio (30,200,@result);		-- no funciona, no existe el cliente
SELECT @result;
CALL BorrarServicio (30,20,@result);		-- no funciona, no existe el servicio al cliente
SELECT @result;
CALL BorrarServicio (410,20,@result);		-- no funciona, no existe el servicio
SELECT @result;


-- 7. Búsqueda de un Servicio.
-- 8. Dado un cliente, listar todos sus servicios entre 2 fechas.


-- 9. Dado un rango de fechas, mostrar todos los tickets de los clientes que no estén
-- finalizados. mostrar el operador que solicitó el ticket, la fecha de alta, de recepción y
-- su descripción. ordenados cronológicamente.
-- 10. Realizar un procedimiento almacenado con alguna funcionalidad que considere
-- de interés.


-- 11. Incluir las sentencias de llamada a los procedimientos. Para cada uno hacer 4
-- llamadas (una con salida correcta y las otras 3 con diferentes errores explicando su
-- intención en un comentario).