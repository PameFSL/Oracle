--@Autorer: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de secuencias

--se crea una secuencia por cada llave primaria
prompt creando secuencias
connect sfms_proy_admin/sfms
prompt creando secuencias

--para poliza_id
create sequence poliza_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;

-- para historico_status_dispositivo_id
create sequence hist_stat_disp_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;

-- dispositivo_id 
create sequence dispositivo_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;	
	
-- aplicacion_id 
create sequence aplicacion_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;	
	
		
-- cliente_id 
create sequence cliente_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;	
		
-- tarjeta_id 
create sequence tarjeta_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20
    noorder;	

--Para la empresa	
create sequence empresa_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;		

--Para la color	
create sequence color_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;	

--Para el material de la correa	
create sequence material_seq
start with 1
increment by 1
	nominvalue
    nomaxvalue
    cache 20;	

--Para propiedad_pantalla
create sequence pantalla_seq
start with 1
increment by 1
    nominvalue
    nomaxvalue
    cache 20;   

--sequencia status_dispositivo
create sequence status_dis_seq
start with 1
increment by 1
    nominvalue
    nomaxvalue
    cache 20;   

--sequencia GPad_Propiedad_pantalla
create sequence GPad_Propiedad_pantalla_seq
start with 1
increment by 1
    nominvalue
    nomaxvalue
    cache 20;   

--sequencia Aplicacion_Dispositivo_id
create sequence Aplicacion_Dispositivo_id_seq
start with 1
increment by 1
    nominvalue
    nomaxvalue
    cache 20; 
-- para la version no se crea ya que tiene un formato más especifico
--create sequence version_seq
--start with 1.0
--increment by 0.1
	--maxvalue 9.9
	--minvalue 1.0
    --cache 20
    --order;	
	
-------------------------------------------------------------------------
-------------------------------------------------------------------------



