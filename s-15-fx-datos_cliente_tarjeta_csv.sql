--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sfms_proy_admin/sfms
set serveroutput on

create or replace function fx_datos_cliente_tarjeta_csv (
	v_cliente_id      cliente.cliente_id%type)
return varchar2
is
	v_csv			varchar2(500);
	v_nombre        cliente.nombre%type;
	v_ap_paterno    cliente.ap_paterno%type;
	v_ap_materno    cliente.ap_materno%type;
	v_RFC           cliente.RFC%type;
	v_email         cliente.email%type;
	v_tarjeta_id    tarjeta_credito.tarjeta_id%type;
	v_numero        tarjeta_credito.numero%type;
	v_tipo          tarjeta_credito.tipo%type;
	v_mes_expira    tarjeta_credito.mes_expira%type;
	v_anio_expira   tarjeta_credito.anio_expira%type;
begin
	v_csv:='';

	select nombre, ap_paterno, ap_materno, RFC, email
		into v_nombre, v_ap_paterno, v_ap_materno, v_RFC, v_email
	from cliente
	where cliente_id = v_cliente_id;

	select tarjeta_id, numero, tipo, mes_expira, anio_expira
		into v_tarjeta_id, v_numero, v_tipo, v_mes_expira, v_anio_expira
	from tarjeta_credito
	where cliente_id = v_cliente_id;

	v_csv:= v_nombre||','||v_ap_paterno||','||v_ap_materno||','||
			v_RFC||','||v_email||','||v_numero||',';

	if v_tipo = 'MC' then
		v_csv:= v_csv||'Master Card'||',';
	end if;

	if v_tipo = 'AE' then
		v_csv:= v_csv||'American Express'||',';
	end if;

	if v_tipo = 'V' then
		v_csv:= v_csv||'Visa'||',';
	end if;

	v_csv:= v_csv||v_mes_expira||','||v_anio_expira;

return v_csv;
end fx_datos_cliente_tarjeta_csv;
/
show errors;