--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sfms_proy_admin/sfms
set serveroutput on

create or replace function fx_secinfo_gphone (
	v_dispositivo_id gphone.dispositivo_id%type)
return varchar2
is
	v_strout varchar2(100);
	v_num_serie  dispositivo.num_serie%type;
	v_cliente_id cliente.cliente_id%type;
	v_empresa_id empresa_telefonica.empresa_telefonica_id%type;
	v_nombre     cliente.nombre%type;
	v_ap_pat     cliente.ap_paterno%type;
	v_empresa    empresa_telefonica.nombre%type;

begin
	v_strout:='';

	select num_serie, cliente_id into v_num_serie, v_cliente_id
	from dispositivo
	where dispositivo_id = v_dispositivo_id;

	select nombre, ap_paterno into v_nombre, v_ap_pat
	from cliente
	where cliente_id = v_cliente_id;

	select empresa_telefonica_id into v_empresa_id
	from gphone
	where dispositivo_id = v_dispositivo_id;

	select nombre into v_empresa
	from empresa_telefonica
	where empresa_telefonica_id = v_empresa_id;

	v_strout:= substr(v_num_serie, -2, 2)||substr(v_empresa, 1, 3)
		     ||substr(v_ap_pat, 2, 2) || v_nombre;

return v_strout;
end fx_secinfo_gphone;
/
show errors;

