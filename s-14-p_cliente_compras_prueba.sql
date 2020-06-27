--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: script de prueba 

set serveroutput on
declare 
v_num number (3,0);
begin
	p_clientes_compra(v_num);
	commit;
	exception
	when others then
		rollback;
end;	
/
show errors

	prompt ****************************************************
	prompt *            tabla cliente/compra                  *
	prompt ****************************************************
-----------------------------------------------------------
--------exportando el contenido a un archivo .csv----------
	set echo off
	set feedback off
	set pagesize 0
	set colsep ";"
	Spool /home/pame/Escritorio/pfin/pb/cliente_compra.csv;
	    select * from compras_cliente;
	Spool off;
------------------------------------------------------------
--regresando al fromato normal
	set heading on;
	set colsep " "
	set pagesize 100
