--@Autorer: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: consultas para el caso de estudio 

prompt ////////////////////////////////////////////////////////////////////////////////
prompt //                 CONSULTA 1
prompt ////////////////////////////////////////////////////////////////////////////////
-- Consulta que muestra a los clientes con mayor numero de dispositivos entregados

select c.nombre, c.ap_paterno, c.ap_materno, count(*) n_disp
	from cliente c, dispositivo d, status_dispositivo sd
	where c.cliente_id = d.cliente_id
		and sd.status_dispositivo_id = d.status_dispositivo_id
		and sd.clave = 'EN'
		group by c.nombre, c.ap_paterno, c.ap_materno
		having count(*) = (select max(num_dis)
			from (
				select count(*) as num_dis
				from cliente c, dispositivo d, status_dispositivo sd
				where c.cliente_id = d.cliente_id
					and sd.status_dispositivo_id = d.status_dispositivo_id
		                    group by c.cliente_id
				)
			);

prompt ////////////////////////////////////////////////////////////////////////////////
prompt //                 CONSULTA 2
prompt////////////////////////////////////////////////////////////////////////////////
--consulta que muestra cual es el tipo de material de correa que los usuarios prefieren 
-- elegir para el color con mayor ventas, asi como los datos del cliente 

select v_c.nombre, v_c.APELLIDO_PATERNO, v_c.color, v_c.color_en_codigo_RGB, 
		 mc.descripcion
	from v_cliente_color v_c
	join cliente c 
		on c.nombre = v_c.nombre 
		and c.ap_paterno = v_c.apellido_paterno
		and c.ap_materno = v_c.apellido_materno 
	join dispositivo d
		on d.cliente_id = c.cliente_id
	join gwatch gw
		on gw.dispositivo_id = d.dispositivo_id 
		and gw.color_id = v_c.color_id 
	join material_correa mc
		on gw.material_correa_id = mc.material_correa_id
	--consulta correlacional 
	and gw.material_correa_id = 
	    (select ma.material_correa_id 
		from material_correa ma, gwatch gwa
		where gwa.dispositivo_id = d.dispositivo_id
		and ma.material_correa_id = gwa.material_correa_id );



prompt ////////////////////////////////////////////////////////////////////////////////
prompt //                 CONSULTA 3
prompt ////////////////////////////////////////////////////////////////////////////////
--consulta que muestra a los clientes que han tenido más de una poliza de seguro 
-- y sus dispositivos se encuentran en reparacion 

select c.cliente_id, c.nombre,c.ap_materno,c.ap_paterno, c.rfc, c.email, count(*) as num_disp_en_reparacion
	from cliente c, dispositivo d, poliza p, poliza pa, status_dispositivo sd
	where c.cliente_id = d.cliente_id
		and d.dispositivo_id = p.dispositivo_id
		and p.poliza_anterior = pa.poliza_id
		and d.status_dispositivo_id = sd.status_dispositivo_id
		and sd.clave = 'ER'
	group by c.cliente_id, c.nombre,c.ap_materno,c.ap_paterno, c.rfc, c.email;


















