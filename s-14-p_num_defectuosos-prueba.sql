--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: procedimiento que crea una nueva tabla en la cual se nuestra
		--	la cantidad de productos defectuosos total y la cantidad de
		-- 	dispositivos defectuosos por cada tipo de dispositivo 
set serveroutput on
declare 
v_num number (3,0);
begin
	p_num_defectuosos(v_num);
	commit;
	exception
	when others then
		rollback;
end;
/
show errors
	prompt ****************************************************
	prompt *             tabla defectuosos                    *
	prompt ****************************************************
-----------------------------------------------------------
--------exportando el contenido a un archivo .csv----------
	set echo off
	set feedback off
	set heading on;
	set pagesize 0
	set colsep ";"
	Spool /home/pame/Escritorio/pfin/pb/defectuosos.csv;
	    select * from registro_defectuosos;
	Spool off;
------------------------------------------------------------
--regresando al fromato normal
	set heading on;
	set colsep " "
	set pagesize 100
