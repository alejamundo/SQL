Create database Bodega_proyecto_ecomerce
use Bodega_proyecto_ecomerce 
drop database Bodega_proyecto_ecomerce
/*Creación de dimesiones*/
create table DimensionCliente(
CodigoCl int primary key,
Genero varchar (15),
Edad int)

create table DimensionSrctor
(CodigoD int primary key,
Barrio varchar(50))

create table DimensionPedidoCarrito(
CodigoPe int primary key, 
CantidadArticulos int)


create table DimensionCategoria(
CodigoKt int primary key,
NombreKt varchar (50))

/*Creacion de tabla de hecho*/
create table HechoVentas
(idH int identity(1,1) primary key,
CodigoD int, CodigoCl int, CodigoPe int,CodigoKt int,Fecha date,
 /*Metricas*/ 
 Ventas_Segun_Barrio int,
 TotalVentas numeric(9,2),
 Cantidad_productos_vendidos int
 foreign key(CodigoCl) references DimensionCliente(CodigoCl),
 foreign key(CodigoPe) references DimensionPedidoCarrito(CodigoPe),
 foreign key(CodigoD) references DimensionSrctor(CodigoD),
 foreign key(CodigoKt) references DimensionCategoria(CodigoKt))

 select * from HechoVentas
 select * from DimensionSrctor