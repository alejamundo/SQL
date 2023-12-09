CREATE PROCEDURE Migracion_ETL
@fechaIni date, @fechaFin date
AS
INSERT INTO estrellaVentasBD.dbo.DimensionProducto(codProd,nombProd)
SELECT tblProducto.codProd, tblProducto.nombProd FROM tblProducto 
left OUTER JOIN estrellaVentasBD.dbo.DimensionProducto
ON estrellaVentasBD.dbo.DimensionProducto.codProd=tblProducto.codProd
WHERE estrellaVentasBD.dbo.DimensionProducto.codProd IS NULL

INSERT INTO estrellaVentasBD.dbo.DimensionSucursal(codSuc,nombSuc,dirSuc,idZona)
SELECT tblSucursal.codSuc, tblSucursal.nombSuc, tblSucursal.dirSuc,
tblSucursal.idZona
FROM tblSucursal 
left OUTER JOIN estrellaVentasBD.dbo.DimensionSucursal
ON estrellaVentasBD.dbo.DimensionSucursal.codSuc=tblSucursal.codSuc
WHERE estrellaVentasBD.dbo.DimensionSucursal.codSuc IS NULL

INSERT INTO estrellaVentasBD.dbo.DimensionZona(idZona,nomZona)
SELECT tblZona.idZona, tblZona.nomZona
FROM tblZona
left OUTER JOIN estrellaVentasBD.dbo.DimensionZona
ON estrellaVentasBD.dbo.DimensionZona.idZona=tblZona.idZona
WHERE estrellaVentasBD.dbo.DimensionZona.idZona IS NULL

INSERT INTO estrellaVentasBD.dbo.HechoVenta
(codProd,codSuc,idZona,fecha,totalVentasC,totalItemsV)

SELECT   tblDetalleVenta.codProd, tblVenta.codSuc,
		 tblZona.idZona,
		  tblVenta.fechaVenta,
		 COUNT(tblVenta.nroVenta) AS totalGeneralVentas, 
		 SUM(tblDetalleVenta.cantItemProd) AS totalGeneralItemsProd
FROM         tblSucursal INNER JOIN
		 tblZona ON tblSucursal.idZona = tblZona.idZona INNER JOIN
		 tblVenta ON tblSucursal.codSuc = tblVenta.codSuc INNER JOIN
		 tblDetalleVenta ON tblVenta.nroVenta = tblDetalleVenta.nroVenta INNER JOIN
         tblProducto ON tblDetalleVenta.codProd = tblProducto.codProd
WHERE tblVenta.fechaVenta>=@fechaIni and tblVenta.fechaVenta<=@fechaFin
GROUP BY tblDetalleVenta.codProd, tblVenta.codSuc, tblZona.idZona, tblVenta.fechaVenta

EXECUTE Migracion_ETL '2022-10-01','2022-10-31'
