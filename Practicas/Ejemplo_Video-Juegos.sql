create database Ejemplo_VideoJuegos
use Ejemplo_VideoJuegos

/*Create*/
CREATE TABLE consola (id_consola bigint IDENTITY(1,1),/*entero que comienza en uno*/
nombre varchar (50),
tipo varchar (15) DEFAULT 'Sobremesa',/*Valor por defecto sobremesa*/
marca varchar (50),
PRIMARY KEY (id_consola)
)

CREATE TABLE juego(id_juego bigint IDENTITY(1,1),
titulo varchar(50),
genero varchar(50),
PRIMARY KEY (id_juego)
)

CREATE TABLE consola_juego(id_consola bigint,
id_juego bigint,
PRIMARY KEY (id_consola, id_juego),/*La clave primaria esta compuesta por las dos foraneas*/
stock int,
FOREIGN KEY (id_consola) REFERENCES consola(id_consola) ON UPDATE CASCADE ON DELETE CASCADE,
FOREIGN KEY (id_juego) REFERENCES juego(id_juego) ON UPDATE CASCADE ON DELETE CASCADE)
/*FOREIGN KEY: Tiene las cláusulas ON DELETE y ON UPDATE indican 
que acción debe ejecutarse en el caso que la clave foránea (a quién hace referencia) 
es eliminada o borrada. Las acciones pueden ser:

o CASCADE: elimina o modifica la registro que tiene el campo referenciado
o SET DEFAULT: asigna valor por defecto a la columna referenciada
o SET NULL: asigna valor NULL a la columna referenciada*/


/*También podemos crear índices, se usan para encontrar un dato más rápidamente mejorando
la eficacia de la consulta*/
CREATE INDEX index_marca
ON consola (marca)

CREATE UNIQUE INDEX index_nombre_marca
ON consola (nombre, marca)

ALTER TABLE consola ADD fecha_lanzamiento date
ALTER TABLE consola DROP COLUMN fecha_lanzamiento

/*Cuando ponemos valor por default a un campo no podremos eliminarlo tan facilmente*/
ALTER TABLE consola ADD fecha_lanzamiento DATE NOT NULL DEFAULT '2017-01-01'
ALTER TABLE consola DROP COLUMN fecha_lanzamiento
/*Con este script podemos eliminar el campo */
DECLARE @ConstraintName nvarchar(MAX)
SELECT @ConstraintName = Name FROM SYS.DEFAULT_CONSTRAINTS
WHERE PARENT_OBJECT_ID = OBJECT_ID('consola')
AND PARENT_COLUMN_ID = (SELECT column_id FROM sys.columns
WHERE NAME = N'fecha_lanzamiento'
AND object_id = OBJECT_ID(N'consola'))
IF @ConstraintName IS NOT NULL
EXEC('ALTER TABLE consola DROP CONSTRAINT ' + @ConstraintName)

ALTER TABLE consola DROP COLUMN fecha_lanzamiento

insert into consola(nombre,marca) values('PS4','Sony')
insert into consola(nombre,marca) values('XBOX ONE','Microsoft')
insert into consola values('3DS','Portátil','Nintendo')
	

INSERT INTO juego(titulo, genero) VALUES('Dark Souls III', 'ROL');
INSERT INTO juego (titulo, genero) VALUES('Project Cars', 'Conduccion');
INSERT INTO juego(titulo, genero) VALUES('Metal Gear Solid V', 'Accion');
INSERT INTO juego (titulo, genero) VALUES('Killer Instinct', 'Lucha');
INSERT INTO juego(titulo, genero) VALUES('Metroid Prime', 'Accion');
INSERT INTO juego(titulo, genero) VALUES('Dragon Quest VII', 'ROL');

INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(1,1, 45);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(1,2, 30);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(1,3, 15);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(2,3, 15);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(2,4, 19);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(4,5, 34);
INSERT INTO consola_juego (id_consola, id_juego, stock) VALUES(4,6, 23);


/*Consultas*/
/*Mostrar los tipos de consolas que hay registrados*/
SELECT DISTINCT tipo
FROM consola

SELECT titulo
FROM juego
WHERE juego.id_juego IN(
SELECT id_juego
FROM consola_juego
WHERE consola_juego.id_consola IN(
SELECT id_consola
FROM consola
WHERE consola.nombre='3DS')
)

SELECT SUM(consola_juego.stock)
FROM consola_juego
WHERE consola_juego.id_juego IN(
SELECT id_juego
FROM juego
WHERE juego.genero='accion')

SELECT juego.titulo
FROM juego
WHERE juego.id_juego IN(
SELECT id_juego
FROM consola_juego
GROUP BY id_juego
HAVING SUM(consola_juego.stock) > 20)

/*Procedimientos sin parametros*/
go
create procedure sp_mostrar_juegos
as
select * from juego
/*se jecuta el procedimiento*/
execute sp_mostrar_juegos

/*procedimiento almacenado con parametros*/
go 
create procedure sp_insertar_juego
@titulo varchar(50), @rol varchar(50)
as
	insert into juego values(@titulo,@rol)
	print('Se inserto un nuevo dato')
/*se jecuta el procedimiento con los parametros requeridos*/
execute sp_insertar_juego 'Dragon Boll','pelea'

/*tigger*/
--Creación del Trigger para controlar INSERCIONES en PRODUCTOS
go
CREATE TRIGGER seInserto
ON juego
AFTER INSERT
AS
 print('se inserto un nuevo juego')


 INSERT INTO juego(titulo, genero) VALUES('Guitar Girl', 'Rock');