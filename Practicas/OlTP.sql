/*Creación de la Base de Datos-gestionVentasBD*/  
CREATE DATABASE gestionVentasBD

/*Cambiarse a la Base de Datos*/
USE gestionVentasBD

/*Creación de las tablas*/
CREATE TABLE tblProducto
(codProd int primary key, nombProd varchar(50))

INSERT INTO tblProducto VALUES(10, 'Producto10')
INSERT INTO tblProducto VALUES(20, 'Producto20')
INSERT INTO tblProducto VALUES(30, 'Producto30')

CREATE TABLE tblZona
(idZona int primary key, nomZona varchar(50))

INSERT INTO tblZona VALUES(100,'Zona100')
INSERT INTO tblZona VALUES(200,'Zona200')
INSERT INTO tblZona VALUES(300,'Zona300')

CREATE TABLE tblSucursal
(codSuc int primary key, nombSuc varchar(50), dirSuc varchar(50), idZona int,
 foreign key(idZona) references tblZona(idZona))

INSERT INTO tblSucursal VALUES(1000,'Sucursal1000','Calle 1000',100)
INSERT INTO tblSucursal VALUES(2000,'Sucursal2000','Calle 2000',100)
INSERT INTO tblSucursal VALUES(3000,'Sucursal3000','Calle 3000',200)
INSERT INTO tblSucursal VALUES(4000,'Sucursal4000','Calle 4000',300)

CREATE TABLE tblVenta
(nroVenta int primary key, fechaVenta date, codSuc int,
 totalItemVenta int,totalPagoVenta int,
 foreign key(codSuc) references tblSucursal(codSuc))

INSERT INTO tblVenta VALUES(1,'2022-10-24',1000,3,5000)
INSERT INTO tblVenta VALUES(2,'2022-10-24',1000,2,3000)
INSERT INTO tblVenta VALUES(3,'2022-10-24',2000,2,3000)
INSERT INTO tblVenta VALUES(4,'2022-09-22',2000,2,3000)
INSERT INTO tblVenta VALUES(5,'2022-09-22',3000,1,2000)
INSERT INTO tblVenta VALUES(6,'2022-10-24',1000,2,3000)
INSERT INTO tblVenta VALUES(7,'2022-09-22',3000,2,4000)

CREATE TABLE tblDetalleVenta
(nroVenta int, codProd int, primary key(nroVenta,codProd), cantitemProd int,
 foreign key(nroVenta) references tblVenta(nroVenta),
 foreign key(codProd) references tblProducto(codProd))

INSERT INTO tblDetalleVenta VALUES(1,10,1)
INSERT INTO tblDetalleVenta VALUES(1,20,2)
INSERT INTO tblDetalleVenta VALUES(2,10,1)
INSERT INTO tblDetalleVenta VALUES(2,20,1)
INSERT INTO tblDetalleVenta VALUES(3,30,1)
INSERT INTO tblDetalleVenta VALUES(3,20,1)
INSERT INTO tblDetalleVenta VALUES(4,10,1)
INSERT INTO tblDetalleVenta VALUES(4,20,1)
INSERT INTO tblDetalleVenta VALUES(5,30,1)
INSERT INTO tblDetalleVenta VALUES(6,20,1)
INSERT INTO tblDetalleVenta VALUES(6,30,1)
INSERT INTO tblDetalleVenta VALUES(7,30,1)
INSERT INTO tblDetalleVenta VALUES(7,20,1)