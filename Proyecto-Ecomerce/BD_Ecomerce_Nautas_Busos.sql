/*utilizacion del lenguaje DDL- create
CREATE:	Utilizado para crear nuevas tablas, campos e índices
DROP:	Empleado para eliminar tablas e índices
ALTER:	Utilizado para modificar las tablas agregando campos o cambiando la definición de los campos.*/
create database Proyectocto_Nautas_Busos
use Proyectocto_Nautas_Busos

create table Cliente(
CodigoCl int primary key,
NombreCl varchar (50),
ApellidoCl varchar (50),
TelefonoCl varchar (15),
CorreoCl varchar(50),
Genero varchar (15),
Edad int)

create table Domicilio(
CodigoD int primary key,
Calle varchar (10),
Carrera varchar(10),
Interior varchar (10),
Barrio varchar (20),
PuntodeReferencia varchar (100),
CodigoCl int,
foreign key (CodigoCl) references Cliente (CodigoCl))

create table PedidoCarrito(
CodigoPe int primary key, 
CodigoCl int,
CantidadArticulos int,
foreign key (CodigoCl) references Cliente (CodigoCl))

create table Categoria(
CodigoKt int primary key,
NombreKt varchar (50))

create table Producto(
CodigoPr int primary key,
NombreP varchar(30),
Precio numeric(20,2),
Existencia bit,
CodigoKt int,
foreign key (CodigoKt) references Categoria (CodigoKt))

create table DetallePedido(
IDdetalle int primary key,
CodigoPr int,
CodigoPe int,
foreign key (CodigoPe) references PedidoCarrito(CodigoPe),
foreign key (CodigoPr) references Producto (CodigoPr))

create table MediodePago(
Idpago int primary key,
TipoP varchar (30))

create table Factura(
CodigoF int primary key,
CodigoPe int,
CodigoCl int,
Descripcion varchar(100),
fecha date,
TotalF numeric(20,2),
Idpago int,
foreign key (Idpago) references MediodePago(Idpago),
foreign key (CodigoPe) references PedidoCarrito(CodigoPe),
foreign key (CodigoCl) references Cliente (CodigoCl))


/* Utilización del lenguaje DML
Update: Utilizado para eliminar registros de una tabla de una base de datos
delete:Utilizado para modificar los valores de los campos y registros especificados
insert:Utilizado para cargar lotes de datos en la base de datos en una única operación
select:Utilizado para consultar registros de la base de datos que satisfagan un criterio determinado 
merge:Cuando se quiere actualizar/insertar datos de una tabla, actualiza cuando se cumple la condición e inserta cuando no se cumple
call:Para ejecutar un procedimiento en PL/SQL o Java
explain: Nos permite analizar el plan de ejecución para poder optimizar la ejecución de las consultas
lock table:concurrencia de control, para controlar el flujo actual*/

INSERT INTO Cliente values(1,'Carolina','Ramirez','3206504589','carolina@gmail.com','Mujer',27)
INSERT INTO Cliente values(2,'Martin','Martinez','3228443842','martin@gmail.com','Hombre',27)
INSERT INTO Cliente values(3,'Diego','Perez','3206505678','diego@gmail.com','Hombre',25)
INSERT INTO Cliente values(4,'Maria','Jaramillo','3206573935','maria@gmail.com','Mujer',30)
INSERT INTO Cliente values(5,'Isabel','Pulgarin','3245245245','isabel@gmail.com','Mujer',18)
INSERT INTO Cliente values(6,'Jorge','Torres','3235693648','jorge@gmail.com','Hombre',20)
INSERT INTO Cliente values(7,'Juliana','Henao','3184568932','juliana@gmail.com','Mujer',19)
INSERT INTO Cliente values(8,'Pedro','Jimenez','3177450234','pedro@gmail.com','Hombre',40)
INSERT INTO Cliente values(9,'Lucas','Maldonado','3214859864','lucas@gmail.com','Hombre',21)
INSERT INTO Cliente values(10,'Carolina','Aguirre','3206502378','caro@gmail.com','Mujer',35)


INSERT INTO Domicilio values(3256,'Calle 56','#13','INT 104','Manrique','al lado de la cancha',1)
INSERT INTO Domicilio values(3257,'Calle 57','#14','INT 105','Aranjuez','frente a la iglesia',2)
INSERT INTO Domicilio values(3258,'Calle 58','#15','INT 106','Santa ana','diagonal a la tienda',3)
INSERT INTO Domicilio values(3259,'Calle 59','#11','INT 107','Buenos aires','frente al parque',4)
INSERT INTO Domicilio values(3260,'Calle 51','#12','INT 108','Poblado','por el colegio salvador',5)
INSERT INTO Domicilio (CodigoD,calle,carrera,Barrio,CodigoCl) values (3261,'calle 60','#10','Provenza',6)
INSERT INTO Domicilio (CodigoD,calle,carrera,Barrio,CodigoCl) values (3262,'calle 61','#16','enciso',7)
INSERT INTO Domicilio (CodigoD,calle,carrera,Barrio,CodigoCl) values (3263,'calle 62','#17','niquia',8)
INSERT INTO Domicilio (CodigoD,calle,carrera,Barrio,CodigoCl) values (3264,'calle 63','#18','Pachelly',9)
INSERT INTO Domicilio (CodigoD,calle,carrera,Barrio,CodigoCl) values (3265,'calle 64','#19','billatina',10)


INSERT INTO PedidoCarrito values(100,1,2)
INSERT INTO PedidoCarrito values(101,2,2)
INSERT INTO PedidoCarrito values(102,3,2)
INSERT INTO PedidoCarrito values(103,4,2)
INSERT INTO PedidoCarrito values(104,5,2)
INSERT INTO PedidoCarrito values(105,6,1)
INSERT INTO PedidoCarrito values(106,7,1)
INSERT INTO PedidoCarrito values(107,8,1)
INSERT INTO PedidoCarrito values(108,9,1)
INSERT INTO PedidoCarrito values(109,10,1)
INSERT INTO PedidoCarrito values(110,6,1)
INSERT INTO PedidoCarrito values(111,7,1)
INSERT INTO PedidoCarrito values(112,8,1)
INSERT INTO PedidoCarrito values(113,9,1)
INSERT INTO PedidoCarrito values(114,10,1)
update PedidoCarrito set CantidadArticulos=5 where CodigoCl=7

INSERT INTO Categoria values(30,'Buso')
INSERT INTO Categoria values(31,'Camisa')

INSERT INTO Producto values(300,'Buso rojo',80000,0,30)
INSERT INTO Producto values(301,'Buso amarillo',90000,1,30)
INSERT INTO Producto values(302,'Buso verde',85000,0,30)
INSERT INTO Producto values(303,'Camisa marron',100000,0,31)
INSERT INTO Producto values(304,'Camisa magenta',70000,0,31)
update Producto set Precio=70000 where CodigoPr=304


INSERT INTO DetallePedido values(50,300,100)
INSERT INTO DetallePedido values(51,301,101)
INSERT INTO DetallePedido values(52,302,102)
INSERT INTO DetallePedido values(53,303,103)
INSERT INTO DetallePedido values(54,304,104)
INSERT INTO DetallePedido values(55,300,105)
INSERT INTO DetallePedido values(56,300,106)
INSERT INTO DetallePedido values(57,300,107)
INSERT INTO DetallePedido values(58,300,108)
INSERT INTO DetallePedido values(59,300,109)
INSERT INTO DetallePedido values(60,300,105)
INSERT INTO DetallePedido values(61,300,106)
INSERT INTO DetallePedido values(62,300,107)
INSERT INTO DetallePedido values(63,300,108)
INSERT INTO DetallePedido values(64,300,109)

INSERT INTO MediodePago VALUES(901,'Pago en efectivo')
INSERT INTO MediodePago VALUES(902,'Pago con Tarjeta credito')
INSERT INTO MediodePago VALUES(903,'Pago con Tarjeta debito')

INSERT INTO Factura VALUES(801,100,1,'Factura sin descuento','12-01-1980',160000,901)
INSERT INTO Factura VALUES(802,101,2,'Factura sin descuento','10-01-2022',180000,902)
update Factura set fecha='10-01-2022' where CodigoF=802
INSERT INTO Factura VALUES(803,102,3,'Factura con descuento del 10%','1-15-2022',170000,901)
INSERT INTO Factura VALUES(804,103,4,'Factura con descuento del 10%','2-20-2022',445000,902)
update Factura set TotalF=445000 where CodigoF=804
INSERT INTO Factura VALUES(805,104,5,'Factura con descuento del 10%','2-25-2022',200000,903)
INSERT INTO Factura VALUES(806,105,6,'Factura con descuento del 10%','3-13-2022',140000,902)
INSERT INTO Factura VALUES(807,106,7,'Factura con descuento del 10%','10-04-2022',80000,901)
INSERT INTO Factura VALUES(808,107,8,'Factura con descuento del 10%','6-05-2022',80000,903)
INSERT INTO Factura VALUES(809,108,9,'Factura sin descuento','8-22-2022',80000,901)
INSERT INTO Factura VALUES(810,109,10,'Factura sin descuento','12-01-1980',80000,901)

INSERT INTO Factura VALUES(811,110,6,'Factura con descuento del 10%','10-04-2022',80000,901)
INSERT INTO Factura VALUES(812,111,7,'Factura con descuento del 10%','6-05-2022',80000,903)
INSERT INTO Factura VALUES(813,112,8,'Factura sin descuento','8-22-2022',80000,901)
INSERT INTO Factura VALUES(814,113,9,'Factura sin descuento','12-01-2021',80000,901)
INSERT INTO Factura VALUES(815,114,10,'Factura sin descuento','12-01-2021',80000,901)
update Factura set TotalF=4000000 where CodigoCl=7

/*lejnguaje de consultas SQL*/
/*Consultas con con uniendo varias tablas*/
select CantidadArticulos*Precio as 'Total' from PedidoCarrito inner join DetallePedido 
on PedidoCarrito.CodigoPe = DetallePedido.CodigoPe inner join Producto
on DetallePedido.CodigoPr = Producto.CodigoPr 

/*Sacar el promedio de ventas totales del año 2022*/
SELECT AVG(TotalF) as Promedio_ventas_2022 FROM Factura
WHERE fecha >= '01-01-2022'

/*Analizar cual fue la venta maxima y la minima del año 2022*/
SELECT MAX(TotalF) AS Mejor_venta, MIN(TotalF) AS Peor_Venta FROM Factura
WHERE fecha >= '01-01-2022'


/*Comado like*/
select * from Cliente 
   WHERE NombreCl like 'c%'

 select * from Cliente 
   WHERE NombreCl like '%[A-C]'

select NombreP,Precio,CodigoKt from Producto
where Precio >(select avg(Precio) from Producto)

/*Agrupasr por fecha y codigo las facturas que tengan valor de mas de 200000*/
select fecha, CodigoCl,TotalF from Factura
group by fecha,CodigoCl,TotalF
having avg(Factura.TotalF) > 400.000

/*se Puede utilizar GROUP BY con más de un nombre de columna 
(separe los nombres de columna con comas). 
se debe colocar siempre GROUP BY después de FROM y WHERE en una 
consulta, y antes de HAVING y ORDER BY.*/

SELECT CodigoKt,NombreP
FROM Producto
GROUP BY CodigoKt,NombreP

select NombreP, Precio from Producto
group by NombreP,Precio
having avg(precio) > 100.000

/*FACTURA ORDENADA POR FECHA*/
SELECT * FROM Factura 
ORDER BY fecha

SELECT fecha, TotalF
FROM Factura
ORDER BY fecha ASC, TotalF DESC;


SELECT NombreP, CodigoKt
FROM Producto
WHERE Precio >80.000
GROUP BY NombreP, CodigoKt


SELECT NombreP, Sum(Precio)
FROM Producto
GROUP BY NombreP;

SELECT NombreKt,NombreP
FROM Producto INNER JOIN Categoria ON
Producto.CodigoKt = Categoria.CodigoKt
group by NombreKt,NombreP

/*Calcular el promedio de ventas del año 2022 y 
analizar si se cumplio o no la meta trazada */
declare @promedioTotalVentas numeric (9,2)
select @promedioTotalVentas=AVG(TotalF) from Factura
where fecha >= '2022-01-01'

if(@promedioTotalVentas >= 500.000)
print 'se cumplio meta de ventas'
else
print'No se cumplio la meta de ventas'
print 'El promedio de ventas es de: '
print @promedioTotalVentas


/*Aumentar de precio todos los productos de la categoria con el codigo 31
100 *cada registro de Producto es decir 100*numero total de Productos*/
declare @CodigoKT int
declare @iterator int
declare @numeroRegistroTotal int

set @iterator=1
set @CodigoKT=31
select @numeroRegistroTotal=count( *) from Producto

while  @iterator < @numeroRegistroTotal
begin
	UPDATE Producto SET Precio =Precio+100 WHERE CodigoKT = @CodigoKT
	print ' Numero de cambios realizados: '
	print @iterator
set @iterator=@iterator+1
end

/*A los clientes que hallan comprado 5 o mas articulos de la tienda 
se les hara un descuento especial del 20%*/
go
DECLARE @Descuento int
set @Descuento=5

SELECT  CantidadArticulos,
CASE
WHEN  CantidadArticulos >= @Descuento THEN 'Aplica descuento del 20%'
WHEN CantidadArticulos <= @Descuento THEN 'No aplica descuento'
END As Descuento
FROM PedidoCarrito


/*testing ETL*/
SELECT   Domicilio.Barrio, PedidoCarrito.CodigoCl,
		 PedidoCarrito.CodigoPe,
		 Categoria.CodigoKt,Factura.fecha,
		 /*Cuantas ventas hubieron en Buenos aires*/
		 COUNT(Domicilio.Barrio) AS Ventas_Segun_Barrio, 
		 /*Total de ventas del Ultimo_Año*/
		 SUM(Factura.TotalF) AS TotalVentas,
		 /*Cantidad Producto vendidos*/
		 sum(PedidoCarrito.CantidadArticulos) as Cantidad_productos_vendidos

FROM     Domicilio INNER JOIN
		 PedidoCarrito ON PedidoCarrito.CodigoCl = Domicilio.CodigoCl INNER JOIN
		 Cliente on Domicilio.CodigoCl=Cliente.CodigoCl inner join
		 DetallePedido ON DetallePedido.CodigoPe= PedidoCarrito.CodigoPe INNER JOIN
		 Producto ON Producto.CodigoPr= DetallePedido.CodigoPr INNER JOIN
         Categoria ON Categoria.CodigoKt = Producto.CodigoKt INNER JOIN
		 Factura ON Factura.CodigoPe = PedidoCarrito.CodigoPe
		 where Factura.fecha>'2022-01-01' 
GROUP BY Domicilio.Barrio, Factura.fecha, DetallePedido.CodigoPe,
PedidoCarrito.CodigoCl,PedidoCarrito.CodigoPe,DetallePedido.CodigoPr,
Categoria.CodigoKt,Cliente.CodigoCl

select * from Factura