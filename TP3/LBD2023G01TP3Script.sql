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
	ELSEIF (pDescripcion IS NULL) OR (LENGTH(pDescripcion) < 10) THEN
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
DROP PROCEDURE IF EXISTS ModServicio;

DELIMITER //
CREATE PROCEDURE ModServicio (pIDServicio INT, pIDCliente INT, pIDTipoServicio INT, pDescripcion VARCHAR(255), pPrecio DECIMAL (15,2), pFechaAlta DATETIME, OUT mensaje VARCHAR (100))
SALIR: BEGIN

-- CONTROLO EL ID DEL CLIENTE
	IF pIDCliente IS NULL OR pIDCliente = 0 THEN
		SET mensaje = 'Error - El Cliente es obligatorio';
	LEAVE SALIR;
    END IF;
    
-- CONTROLO EL ID DEL TIPO DE SERVICIO
	IF pIDTIpoServicio IS NULL OR pIDTipoServicio = 0 THEN
		SET mensaje = 'Error - El Tipo de Servicio es obligatorio';
	LEAVE SALIR;
    END IF;

-- CONTROLO LA DESCRIPCIÓN DEL SERVICIO
	IF pDescripcion IS NULL OR (LENGTH(pDescripcion) < 10) THEN
		SET mensaje = 'Error - La descripción debe tener al menos 10 caractéres';
	LEAVE SALIR;
    END IF;
    
-- CONTROLO EL PRECIO DEL SERVICIO
	IF pPrecio IS NULL OR pPrecio < 0 THEN
		SET mensaje = 'Error - Precio inválido';
	LEAVE SALIR;
    END IF;
    
-- CONTROLO LA FECHA DE ALTA DEL SERVICIO
	IF pFechaAlta IS NULL OR pFechaAlta > NOW() THEN
		SET mensaje = 'Error - La fecha es inválida';
	LEAVE SALIR;
    END IF;
    
-- CONTROLO QUE EL SERVICIO EXISTA
	IF NOT EXISTS (SELECT idServicio FROM Servicios WHERE idServicio = pIDServicio)
		THEN SELECT 'El servicio no existe.' AS Mensaje;
	LEAVE SALIR;
    END IF;
    
    UPDATE	Servicios
    SET		idCliente = pIDCliente, idTipoServicio = pIDTipoServicio, Descripcion = pDescripcion, Precio = pPrecio, FechaAlta = pFechaAlta
		WHERE idServicio = pIDServicio;
	SET Mensaje = 'OK';
END //
DELIMITER ;

CALL ModServicio (5, 3, 1, 'Reparacion toner impresora', 900, NOW(),@result); -- OK
SELECT @result;
SELECT * FROM Servicios WHERE idServicio = 5;

CALL ModServicio (99, 3, 1, 'Reparacion toner impresora', 900, NOW(),@result); -- IDServicio inválido
SELECT @result;

CALL ModServicio (5, 3, 1, 'a', 900, NOW(),@result); -- Descripción inválida
SELECT @result;

CALL ModServicio (5, 3, 1, 'Cambio pasta térmica', 900, '2024-06-09 10:15:00',@result); -- Fecha inválida
SELECT @result;



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
DROP PROCEDURE IF EXISTS BuscarServicioPorDescripcion;
DROP PROCEDURE IF EXISTS BuscarServicioPorPrecio;

DELIMITER //
CREATE PROCEDURE BuscarServicioPorDescripcion (pDescripcion VARCHAR (255), OUT mensaje VARCHAR (100))
SALIR: BEGIN
	IF (pDescripcion IS NULL) THEN
		SET mensaje = 'Error - Debe ingresar un valor';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM Servicios WHERE descripcion LIKE CONCAT (CONCAT('%',pDescripcion),'%')) THEN
		SET mensaje = CONCAT('No se encontró un servicio con la descripcion: ',pDescripcion);
        LEAVE SALIR;
	ELSE
		START TRANSACTION;
			SELECT * FROM Servicios WHERE descripcion LIKE CONCAT (CONCAT('%',pDescripcion),'%');
			SET mensaje = 'Servicios encontrados con éxito';
        COMMIT;
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE BuscarServicioPorPrecio (pPrecio INT, OUT mensaje VARCHAR (100))
SALIR: BEGIN
	IF (pPrecio < 0) OR (pPrecio IS NULL) THEN
		SET mensaje = 'Error - Precio incorrecto';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM Servicios WHERE precio = pPrecio) THEN
		SET mensaje = CONCAT('No se encontró un servicio con el precio ',pPrecio);
        LEAVE SALIR;
	ELSE
		START TRANSACTION;
			SELECT * FROM Servicios WHERE precio = pPrecio;
			SET mensaje = 'Servicios encontrados con éxito';
        COMMIT;
	END IF;
END //
DELIMITER ;

SELECT * FROM Servicios;

CALL BuscarServicioPorDescripcion('icio 2',@result); 	-- funciona
SELECT @result;
CALL BuscarServicioPorDescripcion(null,@result);		-- no funciona, no puede ser null
SELECT @result;
CALL BuscarServicioPorDescripcion('Esta descripcion no se encuentra en la BD',@result); -- no funciona, no encuentra el campo solicitado
SELECT @result;
CALL BuscarServicioPorDescripcion('Esta tampoco está',@result);			-- no funciona, no encuentra el campo solicitado
SELECT @result;

CALL BuscarServicioPorPrecio(5,@result);			-- funciona
SELECT @result;
CALL BuscarServicioPorPrecio(-100,@result);			-- no funciona, precio incorrecto
SELECT @result;
CALL BuscarServicioPorPrecio(500,@result);			-- no funciona, no encuentra servicios con ese precio
SELECT @result;
CALL BuscarServicioPorPrecio(null,@result);			-- no funciona, campo null
SELECT @result;


-- 8. Dado un cliente, listar todos sus servicios entre 2 fechas.
-- (COMO NO ESPECIFICA ENTRE CUÁL DE LOS TRES TIPOS DE FECHA QUE TIENEN LOS SERVICIOS, ASUMO FECHA ALTA)

DROP PROCEDURE IF EXISTS ListarServicioFecha;

DELIMITER //
CREATE PROCEDURE ListarServicioFecha (pIDCliente INT, pFechaAlta1 DATETIME, pFechaAlta2 DATETIME, OUT mensaje VARCHAR (100))
SALIR: BEGIN 

	-- CONTROLO EL ID DEL CLIENTE
	IF NOT EXISTS (SELECT * FROM Clientes WHERE idCliente = pIDCliente) THEN
		SET mensaje = 'Error - No existe el cliente';
        LEAVE SALIR;
        END IF;
    
    -- CONTROLO LAS FECHAS
	IF pFechaAlta1 IS NULL OR pFechaAlta2 IS NULL OR pFechaAlta1 > pFechaAlta2 THEN
		SET mensaje = 'Error - El rango de fechas no es válido';
	LEAVE SALIR;
    ELSE
		START TRANSACTION;
			SELECT * FROM Clientes INNER JOIN Servicios ON Clientes.idCliente = Servicios.idCliente
				WHERE Servicios.fechaAlta BETWEEN pFechaAlta1 AND pFechaAlta2 AND Clientes.idCliente = pIDCliente;
			SET Mensaje = 'Solicitud exitosa';
			COMMIT;
	END IF;
END //
DELIMITER ;

CALL ListarServicioFecha (2, '2023-03-01 00:00:00','2023-05-08 18:00:00',@result);		-- OK
SELECT @result;

CALL ListarServicioFecha (99, '2023-03-01 00:00:00','2023-05-01 18:00:00',@result);		-- Cliente inexistente
SELECT @result;

CALL ListarServicioFecha (2, '2024-03-01 00:00:00','2023-05-01 18:00:00',@result);		-- Fecha 1 mayor que Fecha 2
SELECT @result;

CALL ListarServicioFecha (2, '2023-03-01 00:00:00','2020-05-01 18:00:00',@result);		-- Fecha 2 mayor que Fecha 1
SELECT @result;

-- SE AGREGAN NUEVAS INSERCIONES NECESARIAS PARA EL PUNTO 9
TRUNCATE TABLE Tickets;

INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe, fechaFin) VALUES (1, 1, 1, 'La impresora HP Deskjet no imprime correctamente, los colores están distorsionados.', '2023-04-11 10:15:00', '2023-04-14 10:15:00', '2023-04-16 15:30:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe) VALUES (2, 1, 1, 'La computadora Dell OptiPlex se reinicia constantemente y muestra un mensaje de error al iniciar.', '2023-04-13 09:30:00', '2023-04-19 09:30:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (3, 1, 1, 'El monitor LG de 24 pulgadas muestra líneas verticales en la pantalla.', '2023-04-13 14:45:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (4, 1, 1, 'El mouse Logitech MX Master 3 no responde al movimiento.', '2023-04-14 11:20:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe, fechaFin) VALUES (5, 2, 1, 'El teclado Microsoft Ergonomic tiene algunas teclas que no funcionan.', '2023-04-15 13:10:00', '2023-04-20 13:10:00', '2023-04-25 09:45:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (6, 5, 2, 'Los parlantes Logitech Z623 emiten un sonido distorsionado al reproducir audio.', '2023-04-16 16:05:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (7, 6, 2, 'El fax Panasonic KX-FP215 no envía ni recibe mensajes.', '2023-04-17 12:40:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe) VALUES (8, 7, 2, 'El escáner Epson Perfection V600 no detecta ningún documento al intentar escanear.', '2023-04-18 14:45:00', '2023-04-21 14:45:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe, fechaFin) VALUES (9, 8, 2, 'La tablet tiene la pantalla táctil rota y no responde al toque.', '2023-04-19 09:25:00', '2023-04-21 09:25:00', '2023-04-25 14:20:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (10, 8, 2, 'La notebook presenta un fallo en el teclado, algunas teclas se quedan atascadas.', '2023-04-20 11:50:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (11, 9, 3, 'La netbook no se enciende, la pantalla permanece en negro.', '2023-04-21 14:15:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe) VALUES (12, 10, 3, 'El módem no establece conexión a Internet, los indicadores LED están apagados.', '2023-04-22 11:20:00', '2023-04-30 11:20:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (13, 11, 3, 'El router WiFi no emite señal, los dispositivos no pueden conectarse.', '2023-04-23 10:05:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe, fechaFin) VALUES (14, 12, 3, 'El switch Ethernet no permite la comunicación entre los dispositivos conectados.', '2023-04-24 13:20:00', '2023-05-01 13:20:00', '2023-05-06 10:05:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (15, 9, 3, 'La cámara web no se reconoce, la aplicación no la detecta.', '2023-04-25 15:45:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (16, 13, 4, 'Los auriculares no emiten sonido en uno de los lados.', '2023-04-26 09:10:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (17, 14, 4, 'El micrófono no capta el sonido, no se escucha ninguna grabación.', '2023-04-27 11:35:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (18, 15, 4, 'El pendrive no se puede leer, aparece el mensaje de "unidad no reconocida".', '2023-04-28 13:50:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta, fechaRecibe, fechaFin) VALUES (19, 16, 4, 'El disco portátil no aparece en Mi PC, no se puede acceder a los archivos.', '2023-04-29 16:15:00', '2023-05-03 16:15:00', '2023-05-08 12:30:00');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion, fechaAlta) VALUES (20, 14, 4, 'Se requiere soporte técnico para un equipo de otra categoría.', '2023-04-30 10:40:00');


-- 9. Dado un rango de fechas, mostrar todos los tickets de los clientes que no estén
-- finalizados. mostrar el operador que solicitó el ticket, la fecha de alta, de recepción y
-- su descripción. ordenados cronológicamente.

DROP PROCEDURE IF EXISTS MostrarTicketsNoFinalizados;

DELIMITER //
CREATE PROCEDURE MostrarTicketsNoFinalizados (pFechaInicio DATETIME, pFechaFin DATETIME,OUT mensaje VARCHAR (100))
SALIR: BEGIN
	IF pFechaInicio IS NULL OR pFechaFin IS NULL OR pFechaInicio > pFechaFin IS NULL THEN
		SET mensaje = 'Error - Las fechas ingresadas son incorrectas';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM Tickets WHERE fechaFin IS NULL) THEN
		SET mensaje = 'No hay tickets sin finalizar';
        LEAVE SALIR;
	ELSEIF NOT EXISTS (SELECT * FROM Tickets WHERE fechaAlta BETWEEN pFechaInicio AND pFechaFin) THEN
		SET mensaje = 'No hay tickets sin finalizar entre las fechas indicadas';
        LEAVE SALIR;
	ELSE
		START TRANSACTION;
			SELECT * 
				FROM Tickets t INNER JOIN Operador op ON t.idOperador = op.idOperador AND t.idCliente = op.idCliente
				WHERE t.fechaFin IS NULL AND (t.fechaAlta BETWEEN pFechaInicio AND pFechaFin);
			SET mensaje = 'Servicios encontrados con éxito';
        COMMIT;
	END IF;
END //
DELIMITER ;

CALL MostrarTicketsNoFinalizados('2023/04/01','2023/05/01',@result);		-- funciona
SELECT @result;
CALL MostrarTicketsNoFinalizados('2022/02/01','2022/04/01',@result);		-- no funciona, no hay tickets en esa fecha
SELECT @result;
CALL MostrarTicketsNoFinalizados(null,'2023/06/04',@result);				-- no funciona, la fecha es null
SELECT @result;
CALL MostrarTicketsNoFinalizados('2022/04/01','2022/02/01',@result);		-- no funciona, las fechas estan fuera de rango
SELECT @result;

SELECT * FROM Tickets WHERE fechaAlta >= '2023/05/01' AND fechaAlta <= '2023/06/01';


-- 10. Realizar un procedimiento almacenado con alguna funcionalidad que considere de interés.
-- LISTAR TODOS LOS TICKETS DE TODOS LOS CLIENTES, QUE NO HAYAN SIDO RECIBIDOS CON NOMBRE OPERADOR
-- NOMBRE CLIENTE, EQUIPO Y FECHA DE ALTA
DROP PROCEDURE IF EXISTS ListarServiciosNoR;

DELIMITER //
CREATE PROCEDURE ListarServiciosNoR (OUT mensaje VARCHAR (100))
SALIR: BEGIN 
	IF NOT EXISTS (SELECT * FROM Tickets WHERE fechaRecibe IS NULL) THEN
			SET mensaje = 'No hay tickets sin recibir! :D';
			LEAVE SALIR;
			ELSE
				START TRANSACTION;
				SELECT Operador.Nombre, Operador.Apellido, Clientes.razonSocial, Equipos.idEquipo, Tickets.fechaAlta FROM Clientes
					INNER JOIN Operador ON Clientes.idCliente = Operador.idCliente
						INNER JOIN 	Equipos ON Operador.idCliente = Equipos.idCliente AND Operador.idOperador = Equipos.idOperador
										INNER JOIN Tickets ON Equipos.idEquipo = Tickets.idEquipo AND Equipos.idOperador = Tickets.idOperador
													AND Equipos.idCliente = Tickets.idCliente
						WHERE Tickets.fechaRecibe IS NULL;
						SET Mensaje = 'Tickets mostrados con éxito';
	END IF;
	COMMIT;
	END//
    
CALL ListarServiciosNoR(@result);		-- OK
SELECT @result;

-- AL NO RECIBIR PARÁMETROS, NO PUEDE HABER LLAMADAS ERRÓNEAS EN ESTE SP
-- EXCEPTO, SI ES QUE NO HUBIERA TICKETS CON FECHA DE RECEPCIPÓN NULA, MOSTRARÍA EL MENSAJE CORRESPONDIENTE



-- 11. Incluir las sentencias de llamada a los procedimientos. Para cada uno hacer 4
-- llamadas (una con salida correcta y las otras 3 con diferentes errores explicando su
-- intención en un comentario).

-- Realizado en cada uno de los puntos anteriores luego de la creacion de los SP 