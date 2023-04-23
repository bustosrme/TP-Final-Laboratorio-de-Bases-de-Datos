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

CREATE INDEX ind_nombre ON Marcas(nombre);

SHOW INDEX FROM Marcas;

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

INSERT INTO Modelos(idMarca,nombre) VALUES (2,"1asd2r-2");
INSERT INTO Modelos(idMarca,nombre) VALUES (4,"aCbS-123");
INSERT INTO Modelos(idMarca,nombre) VALUES (10,"1982775-23");
INSERT INTO Modelos(idMarca,nombre) VALUES (1,"djhkff-2000");
INSERT INTO Modelos(idMarca,nombre) VALUES (3,"a-12jne");
INSERT INTO Modelos(idMarca,nombre) VALUES (5,"24422-la");
INSERT INTO Modelos(idMarca,nombre) VALUES (20,"AVX-212");
INSERT INTO Modelos(idMarca,nombre) VALUES (15,"pdhg-204");
INSERT INTO Modelos(idMarca,nombre) VALUES (13,"2000-kgg");
INSERT INTO Modelos(idMarca,nombre) VALUES (7,"xnnnvd");
INSERT INTO Modelos(idMarca,nombre) VALUES (2,"45885-123");
INSERT INTO Modelos(idMarca,nombre) VALUES (4,"asdasd-123");
INSERT INTO Modelos(idMarca,nombre) VALUES (10,"LA-1332");
INSERT INTO Modelos(idMarca,nombre) VALUES (1,"477562");
INSERT INTO Modelos(idMarca,nombre) VALUES (3,"DGSKIT-12");
INSERT INTO Modelos(idMarca,nombre) VALUES (11,"aaswqa");
INSERT INTO Modelos(idMarca,nombre) VALUES (8,"djk-2202");
INSERT INTO Modelos(idMarca,nombre) VALUES (5,"32asd233");
INSERT INTO Modelos(idMarca,nombre) VALUES (1,"L1332");
INSERT INTO Modelos(idMarca,nombre) VALUES (17,"T995");

SELECT Marcas.nombre as Marca,Modelos.nombre as Modelo,Marcas.estado FROM Marcas INNER JOIN Modelos ON Modelos.idMarca=Marcas.idMarca;


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
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("La Sevillanita","30-57993900-8","AUTOP. PTE JUAN D. PERON SN 0 ALDERETES, TUCUMAN","2222222222");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Bercovich","30-51662596-8","MENDOZA 1637 SAN MIGUEL DE TUCUMAN, TUCUMAN","333333333");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Carrefour","30-58462038-9","CATAMARCA 1116, SAN MIGUEL DE TUCUMAN","444444444");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Jumbo","30-70877296-4","Fermín Cariola 42, T4107 Yerba Buena, Tucumán","55555555555");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Corralon Aconquija","30-53349356-0","Combate de San Lorenzo 1345, T4000 San Miguel de Tucumán","6666666666");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Entropy","30-71591476-6","Gral. Paz 576 Piso 17 Oficina 1, T4000 San Miguel de Tucumán","7777777777");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Cultura IT","30- -0","Maipú 50, T4000 San Miguel de Tucumán","8888888888");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Globant","30-70821335-3","Av. Juan Domingo Perón 2300, Yerba Buena, Tucumán","9999999999");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Sovos","30-70899329-4","Av. Manuel Belgrano 1915, San Miguel de Tucumán, Tucumán","0000000000");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Censys","30-56057760-1","Complejo Altercity, Av. Juan Domingo Perón 2300, T4107 Yerba Buena, Tucumán","1234123412");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Sistelco","33-60277352-9","Buenos Aires 362, T4000IJH San Miguel de Tucumán, Tucumán","5678567856");
INSERT INTO Clientes (razonSocial,CUIT,direccion,telefono) VALUES ("Scania","30-51742430-3","Tucuman","1928374650");

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

INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (1,"Juan","Doe","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (2,"Jane","Doe","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (3,"Miguel","Cabrera","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (4,"Luis","Nieto","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (5,"Miguel","Estevez","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (6,"Guillermo","Rossi","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Luis Roque","Di Pinto","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (8,"Aida","Olmos","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (9,"Carlos","Sueldo","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (10,"Estevan","Volentini","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (11,"Nicolas","Majorel Padilla","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (12,"Gustavo","Giori","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (13,"Matias","Giori","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (1,"Erica","Becker","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (2,"Fernanda","Guzman","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (3,"Matias","Mendiondo","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (4,"Maxi","Odstrcil","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (5,"Maria de los Angeles","Gomez Lopez","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (6,"Martin","Juarez","user","pass","mail@empresa.com");
INSERT INTO Operador (idCliente,nombre,apellido,usuario,pass,email) VALUES (7,"Juan","Perez","user","pass","mail@empresa.com");

SELECT Operador.nombre, Operador.apellido, Clientes.razonSocial, Operador.usuario, Operador.email FROM Clientes INNER JOIN Operador ON Clientes.idCliente = Operador.idCliente;



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

INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (1,1,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (2,2,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (3,3,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (4,4,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (5,5,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (6,6,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (7,7,4,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (8,8,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (9,9,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (10,10,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (11,11,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (12,12,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (13,13,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (14,1,2,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (15,2,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (16,3,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (17,4,3,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (18,5,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (19,6,null,"Hola");
INSERT INTO Mensajes (idOperador,idCliente, idMensajePadre,mensaje) VALUES (20,7,10,"Hola");

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

INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(1,1,1,2,15);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(2,2,2,4,20);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(3,3,3,10,6);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(4,4,4,1,8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(5,5,5,3,2);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(6,6,6,5,11);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(7,7,7,20,10);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(8,8,8,15,3);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(9,9,9,13,15);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(10,10,10,7,5);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(11,11,11,2,7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(12,12,12,4,13);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(13,13,13,10,8);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(14,1,14,1,7);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(15,2,15,3,4);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(16,3,16,11,20);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(17,4,17,8,1);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(18,5,18,5,19);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(19,6,19,1,14);
INSERT INTO Equipos (idOperador, idCliente, idModelo, idMarca, idCategoria) VALUES(20,7,20,17,6);



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

INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(1,1,1,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(2,2,2,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(3,3,3,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(4,4,4,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(5,5,5,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(6,6,6,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(7,7,7,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(8,8,8,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(9,9,9,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(10,10,10,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(11,11,11,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(12,12,12,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(13,13,13,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(14,14,1,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(15,15,2,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(16,16,3,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(17,17,4,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(18,18,5,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(19,19,6,"No funciona");
INSERT INTO Tickets (idEquipo, idOperador, idCliente, descripcion) VALUES(20,20,7,"No funciona");

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

INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (13,1,"Servicio 1",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (12,2,"Servicio 2",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (11,3,"Servicio 3",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (10,4,"Servicio 4",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (9,5,"Servicio 5",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (8,4,"Servicio 6",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (7,3,"Servicio 7",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (6,2,"Servicio 8",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (5,1,"Servicio 9",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (4,2,"Servicio 10",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (3,3,"Servicio 11",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (2,4,"Servicio 12",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (1,5,"Servicio 13",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (2,4,"Servicio 14",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (3,3,"Servicio 15",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (4,2,"Servicio 16",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (5,1,"Servicio 17",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (6,2,"Servicio 18",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (7,3,"Servicio 19",10.50);
INSERT INTO Servicios (idCliente,idTipoServicio,descripcion,precio) VALUES (8,4,"Servicio 20",10.50);

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

INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (13,1,1,1,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (12,2,2,2,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (11,3,3,3,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (10,4,4,4,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (9,5,5,5,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (8,6,6,6,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (7,7,7,7,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (6,8,8,8,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES (5,9,9,9,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(4,10,10,10,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(3,11,11,11,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(2,12,12,12,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(1,13,13,13,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(14,14,14,1,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(15,15,15,2,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(16,16,16,3,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(17,17,17,4,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(18,18,18,5,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(19,19,19,6,"Linea 1",15.23);
INSERT INTO LineaServicio (idServicio, idEquipo, idOperador, idCliente, descripcion, precio) VALUES(20,20,20,7,"Linea 1",15.23);

SELECT * FROM LineaServicio;