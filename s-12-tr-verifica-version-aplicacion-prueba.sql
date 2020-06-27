--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: script de prueba para tr_verifica_version_aplicacion

-----insercion con formato correcto 
insert into version_aplicacion (version_id,aplicacion_id,descripcion,fecha_liberacion)
	values('1.0.1',14,'Version mejorada',to_date('2014/01/07 12:13:09','yyyy/mm/dd hh24:mi:ss'));

-----insercion con formato incorrecto
insert into version_aplicacion (version_id,aplicacion_id,descripcion,fecha_liberacion)
	values('1.2',4,'Version mejorada',to_date('2015/01/07 12:13:09','yyyy/mm/dd hh24:mi:ss'));



