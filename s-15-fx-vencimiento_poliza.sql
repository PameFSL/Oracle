--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sfms_proy_admin/sfms
set serveroutput on

create or replace function fx_vencimiento_poliza (
	v_poliza_id   poliza.poliza_id%type,
	v_char_tiempo char)
return varchar2
is
	v_tiempo         varchar2(500);
	v_fecha_fin      poliza.fecha_fin%type;

begin 
	v_tiempo:='El tiempo en ';

	select fecha_fin into v_fecha_fin
	from poliza
	where poliza_id = v_poliza_id;

	if v_char_tiempo = 'S' then
	v_tiempo:=v_tiempo||'segundos es: ';
	v_tiempo:= v_tiempo||to_char(round((v_fecha_fin - sysdate)*60*60*24));
	end if;

	if v_char_tiempo = 'M' then
	v_tiempo:=v_tiempo||'minutos es: ';
	v_tiempo:= v_tiempo||to_char(round((v_fecha_fin - sysdate)*24*60));
	end if;

	if v_char_tiempo = 'H' then
	v_tiempo:=v_tiempo||'horas es: ';
	v_tiempo:= v_tiempo||to_char(round((v_fecha_fin - sysdate)*24));
	end if;

	if v_char_tiempo = 'D' then
	v_tiempo:=v_tiempo||'dias es: ';
	v_tiempo:= v_tiempo||to_char(round(v_fecha_fin - sysdate));
	end if;
	return v_tiempo;

end fx_vencimiento_poliza;
/
show errors;