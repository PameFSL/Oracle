--@Autorer: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de sinonimos para todas las tablas

set serveroutput on 
declare
	v_n_sinonimo user_tables.table_name%type;
	v_n_tabla user_tables.table_name%type;
	v_num number (2,0);
	v_crea_s varchar2(200);

cursor cur_tablas is 
select table_name
from user_tables;
begin
	for a in cur_tablas loop 
		--********************duda 00******************************************************
		--create synonym 00a for aplicacion
		v_crea_s := 'create or replace synonym SM'|| a.table_name ||' for sfms_proy_admin.'||a.table_name;
		execute immediate v_crea_s;
	end loop;
end;
/
show errors

prompt *
prompt *********************************************
prompt *    visualizando sinonimos creados	    *
prompt *********************************************
prompt *
select synonym_name 
from user_synonyms;
