--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: procedimiento que crea una nueva tabla en la cual se nuestra
		--	la cantidad de productos defectuosos total y la cantidad de
		-- 	dispositivos defectuosos por cada tipo de dispositivo 

set serveroutput on 
create or replace procedure p_num_defectuosos(
	p_num_sin out number
) as
	v_tipo_dispositivo varchar2(20);
	v_num_defectuosos number(4,0);

	cursor cur_busca_d is
		select d.tipo, count(*)
		from dispositivo d, historico_status_dispositivo hsd, status_dispositivo sd
		where d.status_dispositivo_id = sd.status_dispositivo_id
			and sd.status_dispositivo_id = hsd.status_dispositivo_id
		group by d.tipo
		order by count(*) desc;
begin
	begin
		execute immediate 'create table registro_defectuosos (
			tipo_dispositivo varchar2(20) not null,
			num_defectuosos number(4,0) not null
			)';
	end; 	

	open cur_busca_d;
	loop
	   fetch cur_busca_d into v_tipo_dispositivo, v_num_defectuosos;
	   exit when cur_busca_d%notfound;

		if v_tipo_dispositivo = 'ph' then
			v_tipo_dispositivo := 'gPhone';
			end if;
		if v_tipo_dispositivo = 'pa' then
			v_tipo_dispositivo := 'gPad';
			end if;
		if v_tipo_dispositivo = 'wa' then
			v_tipo_dispositivo := 'gWatch';
			end if;
			execute immediate 'insert into registro_defectuosos(
				tipo_dispositivo, num_defectuosos)
				values(:ph_tabla, :pn_sinonimo)' 
				using v_tipo_dispositivo, v_num_defectuosos;
	end loop;
end;	
/
show errors
