
CREATE PROCEDURE Migracion_ETL
@fechaIni date, @fechaFin date
AS
INSERT INTO Bodega_proyecto_ecomerce.dbo.DimensionSrctor(CodigoD,Barrio)
SELECT Domicilio.CodigoD,Domicilio.Barrio
FROM Domicilio
left OUTER JOIN Bodega_proyecto_ecomerce.dbo.DimensionSrctor
ON Bodega_proyecto_ecomerce.dbo.DimensionSrctor.CodigoD=Domicilio.CodigoD
WHERE Bodega_proyecto_ecomerce.dbo.DimensionSrctor.CodigoD IS NULL


INSERT INTO Bodega_proyecto_ecomerce.dbo.DimensionCliente(CodigoCl,Genero,Edad)
SELECT Cliente.CodigoCl, Cliente.Genero,Cliente.Edad
FROM Cliente 
left OUTER JOIN Bodega_proyecto_ecomerce.dbo.DimensionCliente
ON Bodega_proyecto_ecomerce.dbo.DimensionCliente.CodigoCl=Cliente.CodigoCl
WHERE Bodega_proyecto_ecomerce.dbo.DimensionCliente.CodigoCl IS NULL

INSERT INTO Bodega_proyecto_ecomerce.dbo.DimensionPedidoCarrito(CodigoPe,CantidadArticulos)
SELECT PedidoCarrito.CodigoPe, PedidoCarrito.CantidadArticulos
FROM PedidoCarrito
left OUTER JOIN Bodega_proyecto_ecomerce.dbo.DimensionPedidoCarrito
ON Bodega_proyecto_ecomerce.dbo.DimensionPedidoCarrito.CodigoPe=PedidoCarrito.CodigoPe
WHERE Bodega_proyecto_ecomerce.dbo.DimensionPedidoCarrito.CodigoPe IS NULL


INSERT INTO Bodega_proyecto_ecomerce.dbo.DimensionCategoria(CodigoKt,NombreKt)
SELECT Categoria.CodigoKt,Categoria.NombreKt
FROM Categoria
left OUTER JOIN Bodega_proyecto_ecomerce.dbo.DimensionCategoria
ON Bodega_proyecto_ecomerce.dbo.DimensionCategoria.CodigoKt=Categoria.CodigoKt
WHERE Bodega_proyecto_ecomerce.dbo.DimensionCategoria.CodigoKt IS NULL


INSERT INTO Bodega_proyecto_ecomerce.dbo.HechoVentas
(CodigoD, CodigoCl, CodigoPe,CodigoKt,Fecha,Ventas_Segun_Barrio,
 TotalVentas,Cantidad_productos_vendidos)
SELECT   Domicilio.CodigoD, PedidoCarrito.CodigoCl,
		 PedidoCarrito.CodigoPe,
		 Categoria.CodigoKt,Factura.fecha,
		 /*Cuantas ventas hubieron en barrio*/
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
WHERE Factura.fecha>=@fechaIni and Factura.fecha<=@fechaFin
GROUP BY Domicilio.CodigoD, PedidoCarrito.CodigoCl,
		 PedidoCarrito.CodigoPe,
		 Categoria.CodigoKt,Factura.fecha

EXECUTE Migracion_ETL '2022-01-01', '2022-11-01' 


