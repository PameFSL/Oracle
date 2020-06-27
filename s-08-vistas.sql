prompt Contectando con usuario sfms_proy_admin/sfms para crear las vistas
connect sfms_proy_admin/sfms


---------------VISTA 1 -------------------------------------------------------
-- Vista que muestra las aplicaciones que han descargado los clientes
create or replace view v_cliente_aplicaciones(
	nombre,apellido_paterno,apellido_materno, app_id, app_descargada
	) as select c.nombre, c.ap_paterno, c.ap_materno, a.aplicacion_id, a.nombre
	from cliente c, dispositivo d, aplicacion_dispositivo a_d, aplicacion a
	where c.cliente_id = d.cliente_id
		and d.dispositivo_id = a_d.dispositivo_id
		and a_d.aplicacion_id = a.aplicacion_id;
		
		
--******************************************************************************
---------------VISTA 2 -------------------------------------------------------
-- Vista que muestra todas aquellas tarjetas de credito de los clientes 
-- que poseen un seguro contra danios y robo mayor a 1 anio 
create or replace view v_tarjeta_poliza(
	numero, tipo, mes_expira, anio_exp, duracion_poliza
	) as select t.numero, t.tipo, anio_expira ,t.mes_expira, p.duracion_anios
	from tarjeta_credito t, cliente c, dispositivo d, poliza p
	where t.cliente_id = c.cliente_id
		and c.cliente_id = d.cliente_id
		and d.dispositivo_id = p.dispositivo_id
		and p.duracion_anios > 1;

		
--******************************************************************************
---------------VISTA 3 -------------------------------------------------------
-- Vista que muestra cual o cuales son los colores de gwatch más comprados,
-- asi como los clientes que lo solicitaron    
create or replace view v_cliente_color(
	nombre,apellido_paterno,apellido_materno, color_id, color, color_en_codigo_RGB, total_disp_vendidos
	) as select c.nombre, c.ap_paterno, c.ap_materno, co.color_id, co.nombre, co.codigo_RGB, q1.total
	from cliente c, dispositivo d, gwatch gw, color co, 
			(select count(di.dispositivo_id) as total, co.color_id
				from cliente c, dispositivo di, gwatch gw, color co
				where c.cliente_id = di.cliente_id
					and di.dispositivo_id = gw.dispositivo_id
					and gw.color_id = co.color_id
					group by co.color_id
			) q1
	where c.cliente_id = d.cliente_id
		and d.dispositivo_id = gw.dispositivo_id
		and gw.color_id = co.color_id
		and co.color_id = q1.color_id
	group by c.nombre, c.ap_paterno, c.ap_materno, co.color_id, co.nombre, co.codigo_RGB, q1.total
	having q1.total =  max(q1.total);




