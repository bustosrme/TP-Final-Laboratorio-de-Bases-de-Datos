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
JOIN LineaServicio ls ON s.idServicio = ls.idServicio)
JOIN Equipos e ON ls.idEquipo = e.idEquipo)
JOIN Operador op ON e.idOperador = op.idOperador)
JOIN Modelos mo ON e.idModelo = mo.idModelo)
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

-- Punto 6
-- Hacer un ranking con los TODOS servicios que realizaron. Mostrar el tipo y el total de
-- servicios en forma descendente. Debe contemplar el caso donde existan TipoServicio que
-- no se hicieron (mostrando el valor en 0).

SELECT t.descripcion, count(s.idServicio)
FROM TipoServicio t LEFT JOIN Servicios s
ON t.idTipoServicio = s.idTipoServicio
GROUP BY t.descripcion
ORDER BY count(s.idServicio) DESC;

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




