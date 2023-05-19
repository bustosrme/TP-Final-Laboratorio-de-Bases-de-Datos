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

-- Agregado de datos a las tablas

-- Borrado y creacion de la base de datos
DROP DATABASE IF EXISTS LBD2023G01;
CREATE DATABASE IF NOT EXISTS LBD2023G01;

USE LBD2023G01;

DROP TABLE IF EXISTS Categorias;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Equipos;
DROP TABLE IF EXISTS LineaServicio;
DROP TABLE IF EXISTS Marcas;
DROP TABLE IF EXISTS Mensajes;
DROP TABLE IF EXISTS Modelos;
DROP TABLE IF EXISTS Operador;
DROP TABLE IF EXISTS Servicios;
DROP TABLE IF EXISTS Tickets;
DROP TABLE IF EXISTS TipoServicio;

-- 
-- TABLE: Marcas 
--

CREATE TABLE Marcas(
    idMarca    	INT            AUTO_INCREMENT,
    nombre      VARCHAR(20)    NOT NULL CHECK (nombre != ''),
    estado     	CHAR(1)        DEFAULT "1" NOT NULL,
    PRIMARY KEY (idMarca)
) ENGINE=INNODB;

CREATE INDEX ind_nombre ON Marcas(nombre);

SHOW INDEX FROM Marcas;

INSERT INTO Marcas (nombre) VALUES ("HP");
INSERT INTO Marcas (nombre) VALUES ("Sony");
INSERT INTO Marcas (nombre) VALUES ("Bangho");
INSERT INTO Marcas (nombre) VALUES ("Epson");
INSERT INTO Marcas (nombre) VALUES ("Samsung");
INSERT INTO Marcas (nombre) VALUES ("Asus");
INSERT INTO Marcas (nombre) VALUES ("Gigabyte");
INSERT INTO Marcas (nombre) VALUES ("Asrock");
INSERT INTO Marcas (nombre) VALUES ("LG");
INSERT INTO Marcas (nombre) VALUES ("Enova");
INSERT INTO Marcas (nombre) VALUES ("iQual");
INSERT INTO Marcas (nombre) VALUES ("Apple");
INSERT INTO Marcas (nombre) VALUES ("Brother");
INSERT INTO Marcas (nombre) VALUES ("Logitech");
INSERT INTO Marcas (nombre) VALUES ("Genius");
INSERT INTO Marcas (nombre) VALUES ("Redragon");
INSERT INTO Marcas (nombre) VALUES ("Kingston");
INSERT INTO Marcas (nombre) VALUES ("Gadnic");
INSERT INTO Marcas (nombre) VALUES ("Noblex");
INSERT INTO Marcas (nombre) VALUES ("SanDisk");

SELECT * FROM Marcas;

-- 
-- TABLE: Modelos 
--

CREATE TABLE Modelos(
    idModelo    INT            AUTO_INCREMENT,
    idMarca     INT            NOT NULL,
    nombre      VARCHAR(30)    NOT NULL CHECK (nombre != ''),
    estado      CHAR(1)        DEFAULT "1" NOT NULL,
    PRIMARY KEY (idModelo, idMarca),
    FOREIGN KEY (idMarca) REFERENCES Marcas(idMarca)
) ENGINE=INNODB;

CREATE INDEX ind_nombre ON Modelos(nombre);

SHOW INDEX FROM Modelos;

INSERT INTO Modelos (idMarca, nombre, estado) VALUES (1, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (1, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (1, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (1, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (2, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (2, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (2, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (2, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (3, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (3, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (3, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (3, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (4, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (4, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (4, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (4, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (5, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (5, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (5, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (5, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (6, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (6, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (6, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (6, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (7, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (7, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (7, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (7, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (8, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (8, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (8, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (8, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (9, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (9, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (9, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (9, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (10, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (10, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (10, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (10, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (11, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (11, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (11, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (11, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (12, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (12, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (12, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (12, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (13, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (13, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (13, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (13, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (14, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (14, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (14, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (14, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (15, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (15, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (15, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (15, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (16, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (16, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (16, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (16, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (17, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (17, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (17, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (17, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (18, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (18, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (18, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (18, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (19, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (19, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (19, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (19, 'Modelo 4', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (20, 'Modelo 1', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (20, 'Modelo 2', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (20, 'Modelo 3', '1');
INSERT INTO Modelos (idMarca, nombre, estado) VALUES (20, 'Modelo 4', '1');

SELECT * FROM Modelos;
SELECT Marcas.nombre as Marca,Modelos.nombre as Modelo,Marcas.estado FROM Marcas INNER JOIN Modelos ON Modelos.idMarca=Marcas.idMarca;
SELECT * FROM Marcas INNER JOIN Modelos ON Modelos.idMarca=Marcas.idMarca;


-- 
-- TABLE: Categorias 
--

CREATE TABLE Categorias(
    idCategoria    INT            AUTO_INCREMENT,
    nombre         VARCHAR(30)	CHECK (nombre != ""),
    estado         CHAR(1)        DEFAULT "1",
    PRIMARY KEY (idCategoria)
) ENGINE=INNODB;

CREATE INDEX ind_nombre ON Categorias(nombre);

SHOW INDEX FROM Categorias;

INSERT INTO Categorias VALUES (1,"Impresoras","1");
INSERT INTO Categorias (nombre) VALUES ("Computadoras");
INSERT INTO Categorias (nombre,estado) VALUES ("Monitores","0");
INSERT INTO Categorias (nombre) VALUES ("Mouses");
INSERT INTO Categorias (nombre) VALUES ("Teclados");
INSERT INTO Categorias (nombre) VALUES ("Parlantes");
INSERT INTO Categorias (nombre) VALUES ("Fax");
INSERT INTO Categorias (nombre) VALUES ("Escaner");
INSERT INTO Categorias (nombre) VALUES ("Tablets");
INSERT INTO Categorias (nombre) VALUES ("Notebooks");
INSERT INTO Categorias (nombre,estado) VALUES ("Netbooks","0");
INSERT INTO Categorias (nombre,estado) VALUES ("Modems", "0");
INSERT INTO Categorias (nombre) VALUES ("Routers");
INSERT INTO Categorias (nombre) VALUES ("Switchs");
INSERT INTO Categorias (nombre) VALUES ("Camaras Web");
INSERT INTO Categorias (nombre) VALUES ("Auriculares");
INSERT INTO Categorias (nombre) VALUES ("Microfonos");
INSERT INTO Categorias (nombre) VALUES ("Pendrive");
INSERT INTO Categorias (nombre) VALUES ("Discos portatiles");
INSERT INTO Categorias (nombre) VALUES ("Otros");

SELECT * FROM Categorias;

-- 
-- TABLE: Clientes 
--

CREATE TABLE Clientes(
    idCliente      INT            AUTO_INCREMENT,
    razonSocial    VARCHAR(30)    NOT NULL CHECK (razonSocial != ""),
    CUIT           CHAR(13)       NOT NULL CHECK (CUIT != ""),
    direccion      VARCHAR(255)    NOT NULL CHECK (direccion != ""),
    telefono       VARCHAR(18)	DEFAULT NULL,
    estado         CHAR(1)        DEFAULT "1" NOT NULL,
    PRIMARY KEY (idCliente)
)ENGINE=INNODB;

CREATE INDEX ind_razonSocial ON Clientes(razonSocial);
CREATE UNIQUE INDEX ind_cuit ON Clientes(CUIT);

SHOW INDEX FROM Clientes;

INSERT INTO Clientes (idCliente,razonSocial,CUIT,direccion,telefono,estado) VALUES (1,"Bordtex","20-34067594-1 ","Maipú 757 Planta Alta, T4000 San Miguel de Tucumán,","111111111","1");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("La Sevillanita","30-57993900-8","AUTOP. PTE JUAN D. PERON SN 0 ALDERETES, TUCUMAN","2222222222");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Bercovich","30-51662596-8","MENDOZA 1637 SAN MIGUEL DE TUCUMAN, TUCUMAN","333333333");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Carrefour","30-58462038-9","CATAMARCA 1116, SAN MIGUEL DE TUCUMAN","444444444");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Jumbo","30-70877296-4","Fermín Cariola 42, T4107 Yerba Buena, Tucumán","55555555555");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Corralon Aconquija","30-53349356-0","Combate de San Lorenzo 1345, T4000 San Miguel de Tucumán","6666666666");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Entropy","30-71591476-6","Gral. Paz 576 Piso 17 Oficina 1, T4000 San Miguel de Tucumán","7777777777");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Cultura IT","30-99999999-0","Maipú 50, T4000 San Miguel de Tucumán","8888888888");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Globant","30-70821335-3","Av. Juan Domingo Perón 2300, Yerba Buena, Tucumán","9999999999");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Sovos","30-70899329-4","Av. Manuel Belgrano 1915, San Miguel de Tucumán, Tucumán","0000000000");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Censys","30-56057760-1","Complejo Altercity, Av. Juan Domingo Perón 2300, T4107 Yerba Buena, Tucumán","1234123412");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Sistelco","33-60277352-9","Buenos Aires 362, T4000IJH San Miguel de Tucumán, Tucumán","5678567856");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono) VALUES ("Scania","30-51742430-3","Tucuman","1928374650");
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 1', '1111111111111', 'Dirección 1', '123456789', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 2', '2222222222222', 'Dirección 2', '234567890', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 3', '3333333333333', 'Dirección 3', '345678901', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 4', '4444444444444', 'Dirección 4', '456789012', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 5', '5555555555555', 'Dirección 5', '567890123', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 6', '6666666666666', 'Dirección 6', '678901234', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 7', '7777777777777', 'Dirección 7', '789012345', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 8', '8888888888888', 'Dirección 8', '890123456', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 9', '9999999999999', 'Dirección 9', '901234567', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 10', '1010101010101', 'Dirección 10', '012345678', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 11', '1111111111110', 'Dirección 11', '123456789', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 12', '1212121212121', 'Dirección 12', '234567890', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 13', '1313131313131', 'Dirección 13', '345678901', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 14', '1414141414141', 'Dirección 14', '456789012', '1');
INSERT INTO Clientes (razonSocial, CUIT, direccion, telefono, estado) VALUES ('Empresa 15', '1515151515151', 'Dirección 15', '567890123', '1');

SELECT * FROM Clientes;

-- 
-- TABLE: Operador 
--

CREATE TABLE Operador(
    idOperador            INT            AUTO_INCREMENT,
    idCliente             INT            NOT NULL,
    apellido              VARCHAR(30)    NOT NULL CHECK (apellido != ''),
    nombre                VARCHAR(30)    NOT NULL CHECK (nombre != ''),
    usuario               VARCHAR(30)    NOT NULL CHECK (usuario != ''),
    pass                  VARCHAR(30)    NOT NULL CHECK (pass != ''),
    email                 VARCHAR(30)    NOT NULL CHECK (email != ''),
    estado                CHAR(1)        DEFAULT "1" NOT NULL,
    idConexionRemota      VARCHAR(30)    NULL,
    passConexionRemota    VARCHAR(30)    NULL,
    PRIMARY KEY (idOperador, idCliente),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
)ENGINE=INNODB;

ALTER TABLE Operador ADD CONSTRAINT U_USUARIO UNIQUE (usuario);
ALTER TABLE Operador ADD CONSTRAINT U_EMAIL UNIQUE (email);

INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (1, 'López', 'Juan', 'juanito', 'contraseña1', 'juanito@example.com', '1', '123456', 'pass123');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (1, 'García', 'María', 'mariag', 'contraseña2', 'maria@example.com', '1', '654321', 'pass321');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (1, 'Rodríguez', 'Carlos', 'carlitos', 'contraseña3', 'carlos@example.com', '1', '987654', 'pass987');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (1, 'Martínez', 'Laura', 'lauram', 'contraseña4', 'laura@example.com', '1', '456789', 'pass456');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (2, 'González', 'Pedro', 'pedrog2', 'contraseña5', 'pedro2@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (2, 'Fernández', 'Ana', 'anafernandez2', 'contraseña6', 'ana2@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (2, 'Vargas', 'Diego', 'diegov2', 'contraseña7', 'diego2@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (2, 'Torres', 'Sofía', 'sofiat2', 'contraseña8', 'sofia2@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (3, 'Sánchez', 'Luis', 'luiss3', 'contraseña9', 'luis3@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (3, 'López', 'Marta', 'martal3', 'contraseña10', 'marta3@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (3, 'Gómez', 'Andrés', 'andresg3', 'contraseña11', 'andres3@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (3, 'Fernández', 'Carolina', 'carolinaf3', 'contraseña12', 'carolina3@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (4, 'Martínez', 'Pablo', 'pablom4', 'contraseña13', 'pablo4@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (4, 'Vargas', 'Lucía', 'lucia_v4', 'contraseña14', 'lucia4@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (4, 'Torres', 'Roberto', 'robertot4', 'contraseña15', 'roberto4@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (4, 'Sánchez', 'Isabel', 'isabels4', 'contraseña16', 'isabel4@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (5, 'González', 'Luisa', 'luisag5', 'contraseña17', 'luisa5@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (5, 'Hernández', 'Carlos', 'carlosh5', 'contraseña18', 'carlos5@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (5, 'Romero', 'Ana', 'anar5', 'contraseña19', 'ana5@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (5, 'López', 'Pedro', 'pedrol5', 'contraseña20', 'pedro5@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (6, 'Fernández', 'María', 'mariaf6', 'contraseña21', 'maria6@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (6, 'Gómez', 'Carlos', 'carlos_g6', 'contraseña22', 'carlos6@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (6, 'Sánchez', 'Laura', 'lauras6', 'contraseña23', 'laura6@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (6, 'Martínez', 'Javier', 'javierm6', 'contraseña24', 'javier6@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Juan","Doe","user1","pass","mail1@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Jane","Doe","user2","pass","mail2@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Miguel","Cabrera","user3","pass","mail3@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Luis","Nieto","user4","pass","mail4@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (8,"Miguel","Estevez","user5","pass","mail5@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (8,"Guillermo","Rossi","user6","pass","mail6@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (8,"Luis Roque","Di Pinto","user7","pass","mail7@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (8,"Aida","Olmos","user8","pass8","mail8@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (9,"Carlos","Sueldo","user9","pass9","mail9@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (9,"Estevan","Volentini","user10","pass","mail10@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (9,"Nicolas","Majorel Padilla","user11","pass","mail11@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (9,"Gustavo","Giori","user12","pass","mail12@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (10,"Matias","Giori","user13","pass","mail13@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (10,"Erica","Becker","user14","pass","mail14@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (10,"Fernanda","Guzman","user15","pass","mail15@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (10,"Matias","Mendiondo","user16","pass","mail16@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (11,"Maxi","Odstrcil","user17","pass","mail17@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (11,"Maria de los Angeles","Gomez Lopez","user18","pass","mail18@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (11,"Martin","Juarez","user19","pass","mail19@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (11,"Juan","Perez","user20","pass20","mail20@empresa.com");
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (12, 'García', 'Luis', 'luisg12', 'contraseña25', 'luis12@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (12, 'Martínez', 'Ana', 'anam12', 'contraseña26', 'ana12@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (12, 'López', 'Carlos', 'carlosl12', 'contraseña27', 'carlos12@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (12, 'González', 'María', 'mariag12', 'contraseña28', 'maria12@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (13, 'Fernández', 'Pedro', 'pedrof13', 'contraseña29', 'pedro13@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (13, 'Gómez', 'Laura', 'laurag13', 'contraseña30', 'laura13@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (13, 'Sánchez', 'Carlos', 'carloss13', 'contraseña31', 'carlos13@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (13, 'Hernández', 'María', 'mariah13', 'contraseña32', 'maria13@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (14, 'Martínez', 'Carlos', 'carlosm14', 'contraseña33', 'carlos14@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (14, 'López', 'Laura', 'laural14', 'contraseña34', 'laura14@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (14, 'González', 'Pedro', 'pedrog14', 'contraseña35', 'pedro14@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (14, 'Fernández', 'María', 'mariag14', 'contraseña36', 'maria14@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (15, 'Gómez', 'Carlos', 'carlosg15', 'contraseña37', 'carlos15@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (15, 'Hernández', 'Laura', 'laurah15', 'contraseña38', 'laura15@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (15, 'Martínez', 'Pedro', 'pedrom15', 'contraseña39', 'pedro15@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (15, 'López', 'María', 'marial15', 'contraseña40', 'maria15@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (16, 'González', 'Carlos', 'carlos_g16', 'contraseña41', 'carlos16@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (16, 'Hernández', 'Laura', 'laura_h16', 'contraseña42', 'laura16@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (16, 'López', 'Pedro', 'pedro_l16', 'contraseña43', 'pedro16@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (16, 'García', 'María', 'maria_g16', 'contraseña44', 'maria16@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (17, 'Fernández', 'Carlos', 'carlos_f17', 'contraseña45', 'carlos17@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (17, 'Gómez', 'Laura', 'laura_g17', 'contraseña46', 'laura17@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (17, 'Hernández', 'Pedro', 'pedro_h17', 'contraseña47', 'pedro17@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (17, 'Martínez', 'María', 'maria_m17', 'contraseña48', 'maria17@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (18, 'López', 'Carlos', 'carlos_l18', 'contraseña49', 'carlos18@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (18, 'García', 'Laura', 'laura_g18', 'contraseña50', 'laura18@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (18, 'Fernández', 'Pedro', 'pedro_f18', 'contraseña51', 'pedro18@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (18, 'Gómez', 'María', 'maria_g18', 'contraseña52', 'maria18@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (19, 'Hernández', 'Carlos', 'carlos_h19', 'contraseña53', 'carlos19@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (19, 'Martínez', 'Laura', 'laura_m19', 'contraseña54', 'laura19@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (19, 'López', 'Pedro', 'pedro_l19', 'contraseña55', 'pedro19@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (19, 'Fernández', 'María', 'maria_f19', 'contraseña56', 'maria19@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (20, 'Gómez', 'Carlos', 'carlos_g20', 'contraseña57', 'carlos20@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (20, 'Hernández', 'Laura', 'laura_h20', 'contraseña58', 'laura20@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (20, 'López', 'Pedro', 'pedro_l20', 'contraseña59', 'pedro20@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (20, 'García', 'María', 'maria_g20', 'contraseña60', 'maria20@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (21, 'Fernández', 'Carlos', 'carlos_f21', 'contraseña61', 'carlos21@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (21, 'Gómez', 'Laura', 'laura_g21', 'contraseña62', 'laura21@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (21, 'Hernández', 'Pedro', 'pedro_h21', 'contraseña63', 'pedro21@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (21, 'Martínez', 'María', 'maria_m21', 'contraseña64', 'maria21@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (22, 'López', 'Carlos', 'carlos_l22', 'contraseña65', 'carlos22@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (22, 'García', 'Laura', 'laura_g22', 'contraseña66', 'laura22@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (22, 'Fernández', 'Pedro', 'pedro_f22', 'contraseña67', 'pedro22@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (22, 'Gómez', 'María', 'maria_g22', 'contraseña68', 'maria22@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (23, 'Hernández', 'Carlos', 'carlos_h23', 'contraseña69', 'carlos23@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (23, 'Martínez', 'Laura', 'laura_m23', 'contraseña70', 'laura23@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (23, 'López', 'Pedro', 'pedro_l23', 'contraseña71', 'pedro23@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (23, 'Fernández', 'María', 'maria_f23', 'contraseña72', 'maria23@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (24, 'González', 'Carlos', 'carlos_g24', 'contraseña73', 'carlos24@example.com', '1', '888999', 'pass888');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (24, 'Hernández', 'Laura', 'laura_h24', 'contraseña74', 'laura24@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (24, 'López', 'Pedro', 'pedro_l24', 'contraseña75', 'pedro24@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (24, 'García', 'María', 'maria_g24', 'contraseña76', 'maria24@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (25, 'Fernández', 'Carlos', 'carlos_f25', 'contraseña77', 'carlos25@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (25, 'Gómez', 'Laura', 'laura_g25', 'contraseña78', 'laura25@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (25, 'Hernández', 'Pedro', 'pedro_h25', 'contraseña79', 'pedro25@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (25, 'Martínez', 'María', 'maria_m25', 'contraseña80', 'maria25@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (26, 'López', 'Carlos', 'carlos_l26', 'contraseña81', 'carlos26@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (26, 'García', 'Laura', 'laura_g26', 'contraseña82', 'laura26@example.com', '1','555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (26, 'Hernández', 'Pedro', 'pedro_h26', 'contraseña83', 'pedro26@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (26, 'Martínez', 'María', 'maria_m26', 'contraseña84', 'maria26@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (27, 'González', 'Carlos', 'carlos_g27', 'contraseña85', 'carlos27@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (27, 'Fernández', 'Laura', 'laura_f27', 'contraseña86', 'laura27@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (27, 'López', 'Pedro', 'pedro_l27', 'contraseña87', 'pedro27@example.com', '1', '555666', 'pass555');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (27, 'García', 'María', 'maria_g27', 'contraseña88', 'maria27@example.com', '1', '777888', 'pass777');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (28, 'Hernández', 'Carlos', 'carlos_h28', 'contraseña89', 'carlos28@example.com', '1', '999000', 'pass999');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (28, 'Martínez', 'Laura', 'laura_m28', 'contraseña90', 'laura28@example.com', '1', '111222', 'pass111');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (28, 'López', 'Pedro', 'pedro_l28', 'contraseña91', 'pedro28@example.com', '1', '333444', 'pass333');
INSERT INTO Operador (idCliente, apellido, nombre, usuario, pass, email, estado, idConexionRemota, passConexionRemota) VALUES (28, 'González', 'María', 'maria_g28', 'contraseña92', 'maria28@example.com', '1', '555666', 'pass555');

SELECT * FROM Operador;

-- 
-- TABLE: Mensajes 
--

CREATE TABLE Mensajes(
    idMensaje         INT             AUTO_INCREMENT,
    idOperador        INT             NOT NULL,
    idCliente         INT             NOT NULL,
    idMensajePadre    INT,
    mensaje           VARCHAR(255)    NOT NULL CHECK (mensaje != ''),
    fechahora         DATETIME        DEFAULT NOW(),
    PRIMARY KEY (idMensaje, idOperador, idCliente),
    FOREIGN KEY (idOperador, idCliente) REFERENCES Operador(idOperador,idCliente),
    FOREIGN KEY (idMensajePadre) REFERENCES Mensajes(idMensaje)
)ENGINE=INNODB;

INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (1, 1, NULL, '¡Hola! ¿Cómo puedo ayudarte?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (1, 1, 1, 'Hola, necesito información sobre nuestros productos.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (1, 1, 2, 'Claro, con gusto te puedo brindar la información que necesitas.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (14, 4, NULL, 'Buen día, ¿en qué puedo ayudarte?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (14, 4, 4, 'Hola, tengo un problema con mi pedido.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (14, 4, 5, 'Lamentamos los inconvenientes. Por favor, proporciona tu número de pedido para que podamos ayudarte.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (21, 6, NULL, '¡Hola! ¿En qué puedo colaborar?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (21, 6, 7, 'Hola, tengo una consulta sobre el servicio de entrega.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (21, 6, 8, 'Por supuesto, adelante con tu consulta. Estoy aquí para ayudarte.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (30, 8, NULL, 'Buenos días, ¿en qué puedo asistirte?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (30, 8, 10, 'Hola, necesito solicitar un cambio en mi reserva.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (30, 8, 11, 'Entendido. Por favor, proporciona los detalles de tu reserva y lo revisaremos.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (37, 10, NULL, 'Hola, ¿en qué puedo ayudarte hoy?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (37, 10, 13, 'Tengo un problema con mi cuenta. No puedo acceder.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (37, 10, 14, 'Lamentamos los inconvenientes. Por favor, proporciona tu nombre de usuario y revisaremos tu cuenta.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (60, 15, NULL, '¡Hola! ¿En qué puedo ayudarte hoy?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (60, 15, 16, 'Necesito solicitar un reembolso por un artículo defectuoso.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (60, 15, 17, 'Lamentamos el inconveniente. Por favor, proporciona el número de orden y el detalle del artículo defectuoso.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (70, 18, NULL, 'Buen día, ¿en qué puedo ayudarte?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (70, 18, 19, 'Hola, necesito realizar una reserva de hotel.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (70, 18, 20, 'Por supuesto, necesitaría saber las fechas y el destino para asistirte mejor.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (80, 20, NULL, '¡Hola! ¿En qué puedo colaborar hoy?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (80, 20, 22, 'Hola, tengo una pregunta sobre el proceso de pago.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (80, 20, 23, 'Claro, adelante con tu pregunta. Estoy aquí para ayudarte.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (90, 23, NULL, '¡Buenos días! ¿En qué puedo asistirte hoy?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (90, 23, 25, 'Hola, necesito información sobre nuestros planes de suscripción.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (90, 23, 26, 'Con mucho gusto te proporcionaré todos los detalles sobre nuestros planes de suscripción.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (100, 25, NULL, 'Hola, ¿en qué puedo ayudarte hoy?');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (100, 25, 28, 'Hola, tengo un problema con la configuración de mi cuenta.');
INSERT INTO Mensajes (idOperador, idCliente, idMensajePadre, mensaje) VALUES (100, 25, 29, 'Entendido. Por favor, proporciona los detalles del problema y lo solucionaremos lo antes posible.');

SELECT * FROM Mensajes;

-- 
-- TABLE: Equipos 
--

CREATE TABLE Equipos(
    idEquipo       INT        AUTO_INCREMENT,
    idOperador     INT        NOT NULL,
    idCliente      INT        NOT NULL,
    idModelo       INT        NOT NULL,
    idMarca        INT        NOT NULL,
    idCategoria    INT        NOT NULL,
    estado         CHAR(1)    DEFAULT "1" NOT NULL,
    PRIMARY KEY (idEquipo, idOperador, idCliente),
    FOREIGN KEY (idOperador, idCliente) REFERENCES Operador(idOperador, idCliente),
    FOREIGN KEY (idModelo, idMarca) REFERENCES Modelos(idModelo, idMarca),
    FOREIGN KEY (idCategoria) REFERENCES Categorias(idCategoria)
) ENGINE=INNODB;

-- Equipos del Cliente 1
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (1, 1, 1, 1, 1);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (1, 1, 2, 1, 2);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (1, 1, 3, 1, 3);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (1, 1, 4, 1, 4);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (2, 1, 5, 2, 5);

-- Equipos del Cliente 2
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (5, 2, 6, 2, 6);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (6, 2, 7, 2, 7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (7, 2, 8, 2, 8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (8, 2, 9, 3, 9);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (8, 2, 10, 3, 10);

-- Equipos del Cliente 3
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (9, 3, 11, 3, 11);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (10, 3, 12, 3, 12);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (11, 3, 13, 4, 13);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (12, 3, 14, 4, 14);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (9, 3, 15, 4, 15);

-- Equipos del Cliente 4
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (13, 4, 16, 4, 16);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (14, 4, 17, 5, 17);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (15, 4, 18, 5, 18);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (16, 4, 19, 5, 19);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (14, 4, 20, 5, 20);

-- Equipos del Cliente 5
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (17, 5, 21, 6, 1);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (18, 5, 22, 6, 2);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (19, 5, 23, 6, 3);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (20, 5, 24, 6, 4);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (19, 5, 25, 7, 5);

-- Equipos del Cliente 6
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (21, 6, 26, 7, 6);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (22, 6, 27, 7, 7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (21, 6, 28, 7, 8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (24, 6, 29, 8, 9);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (21, 6, 30, 8, 10);

-- Equipos del Cliente 7
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (25, 7, 31, 8, 11);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (26, 7, 32, 8, 12);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (27, 7, 33, 9, 13);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (28, 7, 34, 9, 14);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (25, 7, 35, 9, 15);

-- Equipos del Cliente 8
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (29, 8, 36, 9, 16);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (30, 8, 37, 10, 17);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (31, 8, 38, 10, 18);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (32, 8, 39, 10, 19);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (32, 8, 40, 10, 20);

-- Equipos del Cliente 9
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (33, 9, 41, 11, 1);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (34, 9, 42, 11, 2);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (35, 9, 43, 11, 3);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (36, 9, 44, 11, 4);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (34, 9, 45, 12, 5);

-- Equipos del Cliente 10
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (37, 10, 46, 12, 6);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (38, 10, 47, 12, 7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (39, 10, 48, 12, 8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (40, 10, 49, 13, 9);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (40, 10, 50, 13, 10);

-- Equipos del Cliente 11
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (41, 11, 51, 13, 11);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (42, 11, 52, 13, 12);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (43, 11, 53, 14, 13);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (42, 11, 54, 14, 14);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (42, 11, 55, 14, 15);

-- Equipos del Cliente 12
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (45, 12, 56, 14, 16);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (46, 12, 57, 15, 17);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (47, 12, 58, 15, 18);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (48, 12, 59, 15, 19);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (45, 12, 60, 15, 20);

-- Equipos del Cliente 13
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (49, 13, 61, 16, 1);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (50, 13, 62, 16, 2);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (51, 13, 63, 16, 3);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (52, 13, 64, 16, 4);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (50, 13, 65, 17, 5);

-- Equipos del Cliente 14
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (53, 14, 66, 17, 6);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (54, 14, 67, 17, 7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (55, 14, 68, 17, 8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (56, 14, 69, 18, 9);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (54, 14, 70, 18, 10);

-- Equipos del Cliente 15
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (57, 15, 71, 18, 11);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (58, 15, 72, 18, 12);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (59, 15, 73, 19, 13);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (60, 15, 74, 19, 14);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (58, 15, 75, 19, 15);

-- Equipos del Cliente 16
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (61, 16, 76, 19, 16);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (62, 16, 77, 20, 17);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (63, 16, 78, 20, 18);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (64, 16, 79, 20, 19);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES (62, 16, 80, 20, 20);

SELECT * FROM Equipos;

-- 
-- TABLE: Tickets 
--

CREATE TABLE Tickets(
    idTicket       INT             AUTO_INCREMENT,
    idEquipo       INT             NOT NULL,
    idOperador     INT             NOT NULL,
    idCliente      INT             NOT NULL,
    descripcion    VARCHAR(255)    NOT NULL CHECK (descripcion != ""),
    fechaAlta      DATETIME        DEFAULT NOW() NOT NULL,
    fechaRecibe    DATETIME			DEFAULT null,
    fechaFin       DATETIME			DEFAULT null,
    PRIMARY KEY (idTicket, idEquipo, idOperador, idCliente),
    FOREIGN KEY (idEquipo) REFERENCES Equipos(idEquipo),
    FOREIGN KEY (idOperador,idCliente) REFERENCES Operador(idOperador,idCliente)
)ENGINE=INNODB;

INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (1, 1, 1, 'La impresora HP Deskjet no imprime correctamente, los colores están distorsionados.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (2, 1, 1, 'La computadora Dell OptiPlex se reinicia constantemente y muestra un mensaje de error al iniciar.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (3, 1, 1, 'El monitor LG de 24 pulgadas muestra líneas verticales en la pantalla.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (4, 1, 1, 'El mouse Logitech MX Master 3 no responde al movimiento.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (5, 2, 1, 'El teclado Microsoft Ergonomic tiene algunas teclas que no funcionan.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (6, 5, 2, 'Los parlantes Logitech Z623 emiten un sonido distorsionado al reproducir audio.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (7, 6, 2, 'El fax Panasonic KX-FP215 no envía ni recibe mensajes.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (8, 7, 2, 'El escáner Epson Perfection V600 no detecta ningún documento al intentar escanear.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (9, 8, 2, 'La tablet tiene la pantalla táctil rota y no responde al toque.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (10, 8, 2, 'La notebook presenta un fallo en el teclado, algunas teclas se quedan atascadas.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (11, 9, 3, 'La netbook no se enciende, la pantalla permanece en negro.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (12, 10, 3, 'El módem no establece conexión a Internet, los indicadores LED están apagados.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (13, 11, 3, 'El router WiFi no emite señal, los dispositivos no pueden conectarse.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (14, 12, 3, 'El switch Ethernet no permite la comunicación entre los dispositivos conectados.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (15, 9, 3, 'La cámara web no se reconoce, la aplicación no la detecta.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (16, 13, 4, 'Los auriculares no emiten sonido en uno de los lados.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (17, 14, 4, 'El micrófono no capta el sonido, no se escucha ninguna grabación.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (18, 15, 4, 'El pendrive no se puede leer, aparece el mensaje de "unidad no reconocida".');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (19, 16, 4, 'El disco portátil no aparece en Mi PC, no se puede acceder a los archivos.');
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES (20, 14, 4, 'Se requiere soporte técnico para un equipo de otra categoría.');


SELECT * FROM Tickets;



-- 
-- TABLE: TipoServicio 
--

CREATE TABLE TipoServicio(
    idTipoServicio    INT             AUTO_INCREMENT,
    descripcion       VARCHAR(255)    NOT NULL CHECK (descripcion != ''),
    estado            CHAR(1)         DEFAULT "1" NOT NULL,
    PRIMARY KEY (idTipoServicio)
)ENGINE=INNODB;

INSERT INTO TipoServicio (descripcion) VALUES ("Reparacion");
INSERT INTO TipoServicio (descripcion) VALUES ("Limpieza");
INSERT INTO TipoServicio (descripcion) VALUES ("Mantenimiento");
INSERT INTO TipoServicio (descripcion) VALUES ("Cambio de pasta termica");
INSERT INTO TipoServicio (descripcion) VALUES ("Formateo");


-- 
-- TABLE: Servicios 
--

CREATE TABLE Servicios(
    idServicio        INT               AUTO_INCREMENT,
    idCliente         INT               NOT NULL,
    idTipoServicio    INT               NOT NULL,
    descripcion       VARCHAR(255)      NOT NULL CHECK (descripcion != ''),
    precio            DECIMAL(15, 2)    NOT NULL CHECK (precio >= 0),
    fechaAlta         DATETIME          DEFAULT NOW() NOT NULL,
    fechaFin          DATETIME			DEFAULT NULL,
    PRIMARY KEY (idServicio, idCliente),
    FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
    FOREIGN KEY (idTipoServicio) REFERENCES TipoServicio(idTipoServicio)
)ENGINE=INNODB;

INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (13,1,"Servicio 1",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (12,2,"Servicio 2",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (11,3,"Servicio 3",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (10,4,"Servicio 4",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (9,5,"Servicio 5",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (8,4,"Servicio 6",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (7,3,"Servicio 7",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (6,2,"Servicio 8",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (5,1,"Servicio 9",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (4,2,"Servicio 10",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (3,3,"Servicio 11",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (2,4,"Servicio 12",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (1,5,"Servicio 13",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (2,4,"Servicio 14",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (3,3,"Servicio 15",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (4,2,"Servicio 16",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (5,1,"Servicio 17",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (6,2,"Servicio 18",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (7,3,"Servicio 19",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (8,4,"Servicio 20",10.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (9, 5, 'Servicio 21', 11.75);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (13, 1, 'Servicio 22', 12.25);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (16, 3, 'Servicio 23', 9.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (22, 2, 'Servicio 24', 11.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (27, 4, 'Servicio 25', 10.75);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (5, 1, 'Servicio 26', 12.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (10, 5, 'Servicio 27', 11.25);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (8, 4, 'Servicio 28', 10.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (12, 2, 'Servicio 29', 12.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (23, 3, 'Servicio 30', 9.75);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (15, 1, 'Servicio 31', 11.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (18, 5, 'Servicio 32', 12.25);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (7, 4, 'Servicio 33', 9.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (19, 2, 'Servicio 34', 10.75);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (24, 3, 'Servicio 35', 11.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (11, 1, 'Servicio 36', 9.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (21, 5, 'Servicio 37', 12.50);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (6, 4, 'Servicio 38', 9.75);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (28, 2, 'Servicio 39', 11.99);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (14, 3, 'Servicio 40', 10.25);
INSERT INTO Servicios (idCliente, idTipoServicio, descripcion, precio) VALUES (2, 4, 'Servicio 41', 10.50);

SELECT * FROM Servicios;

-- 
-- TABLE: LineaServicio 
--

CREATE TABLE LineaServicio(
    idServicio     INT               NOT NULL,
    idEquipo       INT               NOT NULL,
    idOperador     INT               NOT NULL,
    idCliente      INT               NOT NULL,
    descripcion    VARCHAR(255)      NOT NULL,
    precio         DECIMAL(15, 2)    NOT NULL CHECK (precio >= 0),
    PRIMARY KEY (idServicio, idEquipo, idOperador, idCliente),
    FOREIGN KEY (idServicio) REFERENCES Servicios(idServicio),
    FOREIGN KEY (idEquipo,idOperador,idCliente) REFERENCES Equipos(idEquipo,idOperador,idCliente)
)ENGINE=INNODB;

INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (1,1, 1, 1, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (2,2, 1, 1, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (3,3, 1, 1, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (4,4, 1, 1, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (5,5, 2, 1, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (6,6, 5, 2, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (8,7, 6, 2, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (7,8, 7, 2, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (8,9, 8, 2, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (9,10, 8, 2, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (10,11, 9, 3, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (11,12, 10, 3, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (12,13, 11, 3, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (13,14, 12, 3, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (14,15, 9, 3, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (15,16, 13, 4, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (16,17, 14, 4, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (17,18, 15, 4, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (18,19, 16, 4, 'Linea',10.50);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (19,20, 14, 4, 'Linea',10.50);

SELECT * FROM LineaServicio;