# LBD2023G01

- Año: 2023
- Grupo Nro: 01
- Tema: TecManager
- Nombre del Esquema LBD2023G01TecManager
- Plataforma (SO + Versión): Ubuntu 22.04.02 LTS
- Motor y Versión: MySQL Workbench 8.0.32 (Community Edition)

## TRABAJO PRÁCTICO N° 1
1. Presentar una descripción general sobre el dominio en el que esté trabajando, indicando también los objetivos del mismo. Como dominio puede usarse el desarrollado en la asignatura “Ingeniería de Software I” u otro.
2. Para el dominio del punto anterior, presentar los diagramas de los modelos lógico y físico relacional. Detallar cual es cada uno. Identificar otras posibles claves (simples o compuestas) que no fueron consideradas como PK y crear
índices por las mismas. 
3. Realizar una presentación en clases de 5 minutos como máximo explicando de manera clara el punto 1. Subir al repositorio e incluir en el archivo comprimido final del TP toda la documentación utilizada para hacer la
presentación. 
4. Presentar un script con el modelo físico relacional de datos, para el Sistema Gestor de Base de Datos Relacional MySQL, que contenga únicamente:
-- Creación de la base de datos
-- Creación de tablas
-- Creación de restricciones PK, FK, DEFAULT, CHECK y UNIQUE que correspondan.
-- En todo el script debe haber al menos una de cada una de las restricciones anteriores.
-- Para verificar el funcionamiento de las restricciones creadas, poblar las tablas con datos suficientes (20 filas por tabla aproximadamente). Esto permitirá también obtener salidas con datos al momento de realizar las consultas.
-- Creación de índices que se consideren necesarios.
5. En el script, no incluir sentencias que ejecuten procedimientos almacenados que no cumplan con lo solicitado en el apartado anterior.

## TRABAJO PRÁCTICO N° 2
De acuerdo a lo presentado en el práctico anterior, realizar las siguientes consultas:
1. Dado un cliente, listar todos sus equipos. Mostrar apellido, nombre razon social y cuit, marca y modelo del equipo.
2. Realizar un listado de mensajes agrupados por Operador.
3. Realizar un listado de servicios: id, fechas de inicio y fin, apellido, nombre y dni del cliente, marca, modelo y categoría de equipo. Ordenar por la fecha de inicio del servicio en forma descendente.
4. Dado un rango de fechas, mostrar día a día el total de servicios realizados. El formato deberá ser: Fecha, Total de servicios
5. Hacer un ranking con los 10 servicios que más realizaron. Mostrar el tipo y el total de servicios en forma descendente.
6. Hacer un ranking con los TODOS servicios que realizaron. Mostrar el tipo y el total de servicios en forma descendente. Debe contemplar el caso donde existan TipoServicio que no se hicieron (mostrando el valor en 0).
7. Hacer un ranking con los 10 tipos de servicio más costosos. Mostrar fecha, el nombre del tipo de servicio, la cantidad de líneas realizadas, y el precio total.
8. Crear una vista con la funcionalidad del apartado 3.
9. Crear una copia de la tabla operador, llamada OperadorJSON, que tenga una columna del tipo JSON para guardar los mensajes. Llenar esta tabla con los mismos datos del TP1 y resolver la consulta del apartado 2 (ambas consultas deben presentar la misma salida).
10. Realizar una vista que considere importante para su modelo. También dejar escrito el enunciado de la misma.

## TRABAJO PRÁCTICO N° 3
**Triggers:** implementar la lógica para llevar una auditoría para todos los apartados siguientes de las operaciones de
1. Creación
2. Modificación
3. Borrado
Se deberá auditar el tipo de operación que se realizó (creación, borrado, modificación), el usuario que la hizo, la fecha y hora de la operación, la máquina desde donde se la hizo y todas las información necesaria para la auditoría (en el caso de las modificaciones, se deberán auditar tanto los valores viejos como los nuevos). Procedimientos almacenados: Realizar (lo más eficientemente posible) los siguientes procedimientos almacenados, incluyendo el control de errores lógicos y mensajes de error:
4. Creación de un **Servicio**.
5. Modificación de un **Servicio**.
6. Borrado de un **Servicio**.
7. Búsqueda de un **Servicio**.
8. Dado un cliente, listar todos sus servicios entre 2 fechas.
9. Dado un rango de fechas, mostrar todos los tickets de los clientes que no estén finalizados. mostrar el operador que solicitó el ticket, la fecha de alta, de recepción y su descripción. ordenados cronológicamente.
10. Realizar un procedimiento almacenado con alguna funcionalidad que considere de interés.
11. Incluir las sentencias de llamada a los procedimientos. Para cada uno hacer 4 llamadas (una con salida correcta y las otras 3 con diferentes errores explicando su intención en un comentario).

