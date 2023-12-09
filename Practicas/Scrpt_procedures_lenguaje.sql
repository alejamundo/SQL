create database AdministrarUsuario
use AdministrarUsuario

create table tblUsuario
(claveUsu int primary key,
nomUsu varchar(50),
tipoUsu varchar(20))

insert into tblUsuario values(123,'usuario1','admin')
insert into tblUsuario values(124,'usuario2','publico')

/*Procedure Consultar si existe usuario */
go
create procedure SP_CONSULTAUSUARIOESPECIFICO
@claveUsu int,@nomUsu varchar(50)
as
select claveUsu,nomUsu from tblUsuario
where claveUsu=@claveUsu and nomUsu=@nomUsu

execute SP_CONSULTAUSUARIOESPECIFICO 123,'usuario1'

go
create procedure SP_CREARUSUARIO
@clveUsu int,@nomUsu varchar(50),@tipoUsu varchar(20)
as 
insert into tblUsuario values(@clveUsu,@nomUsu,@tipoUsu)

execute SP_CREARUSUARIO 125,'usuario5','admin'
drop database AdministrarUsuario

select *from tblUsuario