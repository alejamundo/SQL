/*Creación de la Base de Datos-Modelo Estrella*/
CREATE DATABASE estrellaVentasBD

/*Cambiarse a la Base de Datos*/
USE estrellaVentasBD

CREATE TABLE DimensionProducto
(codProd int primary key, nombProd varchar(50))

CREATE TABLE DimensionZona
(idZona int primary key, nomZona varchar(50))

CREATE TABLE DimensionSucursal
(codSuc int primary key, nombSuc varchar(50), dirSuc varchar(50), idZona int,
 )

/*Creación de la tabla de Hechos*/
CREATE TABLE HechoVenta
(idH int identity(1,1) primary key, codProd int, codSuc int,
 idZona int,fecha date, totalVentasC int, totalItemsV int,
 foreign key(codProd) references DimensionProducto(codProd),
 foreign key(codSuc) references DimensionSucursal(codSuc),
 foreign key(idZona) references DimensionZona(idZona)
 )

 select * from HechoVenta
