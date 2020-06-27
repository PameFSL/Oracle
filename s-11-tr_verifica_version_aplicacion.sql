--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: Triger que validara si el formato empleado para la version  
--		de una aplicacion es valido, durante la inserción de los datos

create or replace trigger tr_version_aplicacion
	before insert on version_aplicacion
	for each row
	begin 
		if not regexp_like(:new.version_id,'[0-9]{1}+\.[0-9]{1}+\.{1}') then
			raise_application_error(-20002,'Error, el formato de version "' 
				|| :new.version_id 
				|| '" es incorrecto,por favor revise sintaxis');
		else 
			dbms_output.put_line ('se ha insertado el registro sin problemas');
		end if;
	end;
/
show errors

