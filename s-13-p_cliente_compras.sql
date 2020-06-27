--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: procedimiento que crea una nueva tabla en la cual se nuestra
		--	la cantidad de productos que ha comprado el cliente por cada tipo 
		-- 	asi como el importe total de sus compras 

set serveroutput on
create or replace procedure p_clientes_compra( 
	v_num out number 
)as
	v_nombre_cliente cliente.nombre%type;
	v_cliente_id cliente.cliente_id%type;
	v_tipo dispositivo.tipo%type;
	v_gasto_total number(10,2);
	v_total_dispo number(4,0);
	v_total_disp_P number(4,0);
	v_total_disp_T number(4,0);
	v_total_disp_W number(4,0);
	cur_cliente_compra sys_refcursor;

	cursor cur_consulta_cliente is
		select * from(
			select c.nombre, q1.total,q1.total_disp,q2.GPhone,q3.GPAD,q4.GWATCH
			from cliente c,(
		--obtiene el total de dispositivos e importe total
				select c.cliente_id , sum(d.precio) as total ,count(*) as total_disp
				from cliente c, dispositivo d
				where c.cliente_id = d.cliente_id
				group by c.cliente_id
			) q1,(
-- obtenemos la cantidad de dispositivos de cada tipo por cada cliente 			
			select c.cliente_id, count(d.tipo) as GPhone
			from cliente c,dispositivo d
			where c.cliente_id = d.cliente_id
			and d.tipo = 'ph'
			group by c.cliente_id
			) q2 ,(
			select c.cliente_id, count(*) as GPAD
			from cliente c,dispositivo d
			where c.cliente_id = d.cliente_id
			and d.tipo = 'pa'
			group by c.cliente_id
			) q3,(
			select  c.cliente_id,d.tipo, count(*) as GWATCH
			from cliente c,dispositivo d
			where c.cliente_id = d.cliente_id
			and d.tipo = 'wa'
			group by c.cliente_id,d.tipo
			) q4
			where c.cliente_id = q1.cliente_id
			and q1.cliente_id = q2.cliente_id(+)
			and q1.cliente_id = q3.cliente_id(+)
			and q1.cliente_id = q4.cliente_id(+)
			order by q1.total desc
		);


begin
		execute immediate 'create table compras_cliente (
			nombre varchar2(10) not null,
			gasto_total number(10,2) not null,
			total_disp number(4,0) not null,
			num_disp_ph number(4,0) not null,
			num_disp_pa number(4,0) not null,
			num_disp_wa number(4,0) not null
			)';
 	
		open cur_consulta_cliente;
		loop
			fetch cur_consulta_cliente into v_nombre_cliente,
				v_gasto_total,v_total_dispo,v_total_disp_P,v_total_disp_T,v_total_disp_W;
			exit when cur_consulta_cliente%notfound;

			if v_total_disp_T is null then
				v_total_disp_T := 0;
			end if;
			if v_total_disp_W is null then
				v_total_disp_W := 0;
			end if;
			if v_total_disp_P is null then
				v_total_disp_P := 0;
			end if;
			execute immediate 'insert into compras_cliente(
				nombre, gasto_total, total_disp, num_disp_ph, num_disp_pa, num_disp_wa)
				values(:ph_nombre, :ph_gasto_total, :ph_total_disp, :ph_num_disp_ph,
				:ph_num_disp_pa, :ph_num_disp_wa)' 
				using v_nombre_cliente, v_gasto_total,v_total_dispo,
				      v_total_disp_P,v_total_disp_T,v_total_disp_W;
		end loop;
		close cur_consulta_cliente;
		dbms_output.put_line ('mostrando resultados');
		open cur_cliente_compra for 'select * from compras_cliente';
		dbms_sql.return_result(cur_cliente_compra);
end;
/
show errors
