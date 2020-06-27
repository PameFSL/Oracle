--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

prompt ingresando como sfms_proy_admin para crear indices
connect sfms_proy_admin/sfms

--indice para mejorar consultas

create index aplicacion_nombre_ix
	on aplicacion(nombre);

create index cliente_nom_ape_ix
	on cliente(nombre, ap_paterno, ap_materno);

--indice para verificar unicidad

create unique index tarjeta_numero_uix 
	on tarjeta_credito(cliente_id);

create unique index cliente_email_password_uix 
	on cliente(email, password);

--indice basado en funcionestar

create unique index cliente_rfc_mayus_ix
	on cliente (upper(RFC));

--indices para optimizar foreign keys

create index dispositivo_cliente_id_ix
	on dispositivo(cliente_id);

create index dispositivo_stat_dis_id_ix
	on dispositivo(status_dispositivo_id);

create index poliza_dispositivo_id_ix
	on poliza(dispositivo_id);

create index poliza_pol_anterior_ix
	on poliza(dispositivo_id);

create index ap_disp_dispositivo_id_ix
	on aplicacion_dispositivo(dispositivo_id);

create index ap_disp_aplicacion_id_ix
	on aplicacion_dispositivo(aplicacion_id);

create index tar_cred_cliente_id_ix
	on tarjeta_credito(cliente_id);

create index gphone_dispo_id_ix
	on gphone(empresa_telefonica_id);

create index gwatch_color_id_ix
	on gwatch(color_id);

create index gwatch_mat_cor_id_ix
	on gwatch(material_correa_id);

create index gpad_prop_propi_pan_id_ix
	on gpad_propiedad_pantalla(propiedad_pantalla_id);

create index gpad_prop_dispo_id_ix
	on gpad_propiedad_pantalla(dispositivo_id);

create index hist_stat_dis_stat_dis_ix
	on historico_status_dispositivo(status_dispositivo_id);

create index hist_stat_dis_dispo_id_ix
	on historico_status_dispositivo(dispositivo_id);
	