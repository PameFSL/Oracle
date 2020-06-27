--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: código DDL empleado para crear las tablas

prompt ingresando como sfms_proy_admin para crear tablas
connect sfms_proy_admin/sfms


-- aplicacion 

create table aplicacion(
    aplicacion_id        number(10, 0)    not null,
    nombre               varchar2(30)     not null,
    precio               number(10, 0)    not null,
    compatible_gphone    number(1, 0)     not null,
    compatible_gpad      number(1, 0)     not null,
    compatible_gwatch    number(1, 0)     not null,
    constraint aplicacion_pk primary key (aplicacion_id)
);

-- version_aplicacion 

create table version_aplicacion(
    version_id          varchar(6)    not null,
    aplicacion_id       not null constraint aplicacion_ap_id_fk 
						references aplicacion(aplicacion_id),
    fecha_liberacion    date             default sysdate,
    descripcion         varchar2(40)     not null,
    constraint version_aplicacion_pk primary key (version_id, aplicacion_id)
);

-- cliente 

create table cliente(
    cliente_id    number(10, 0)    not null,
    nombre        varchar2(30)     not null,
    ap_paterno    varchar2(30)     not null,
    ap_materno    varchar2(30),
    rfc           varchar2(13)	   null 
				  constraint cliente_rfc_uk unique,
    email         varchar2(40)     not null,
    password      varchar2(15)     not null,
    constraint cliente_pk primary key (cliente_id)
);
 
 
-- tarjeta_credito 

create table tarjeta_credito(
    tarjeta_id    number(10, 0)    not null,
    numero        number(16, 0)    not null
				  constraint tc_numero_uk unique,
    tipo          char(2)          not null,
    mes_expira    number(2, 0)     not null,
    anio_expira   number(2, 0)     not null,
    cliente_id    number(10, 0)    not null,
    constraint tarjeta_credito_pk primary key (tarjeta_id),
	constraint tc_tipo_chk check (tipo in ('V', 'AE', 'MC'))
);

-- empresa_telefonica 

create table empresa_telefonica(
    empresa_telefonica_id    number(10, 0)    not null,
    nombre                   varchar2(40)     not null,
    logo                     blob             not null,
    direccion_fiscal         varchar2(40)     not null,
    constraint empresa_telefonica_pk primary key (empresa_telefonica_id)
);

-- color 

create table color(
    color_id      number(2, 0)    not null,
    codigo_rgb    varchar2(11)    not null,
    nombre        varchar(10)     not null,
    constraint color_pk primary key (color_id)
);

-- material_correa 

create table material_correa(
    material_correa_id    number(2, 0)     not null,
    descripcion           varchar2(200)	   not null,
	tipo_c                 char(1) 		   not null,
	-- consideramos 
	-- F = flexible y D = rigida
	constraint gwatch_tipo_chk check(tipo_c in('F','D')),
    constraint material_correa_pk primary key (material_correa_id)
);

-- propiedad_pantalla 

create table propiedad_pantalla(
    propiedad_pantalla_id    number(10, 0)    not null,
    clave                    varchar2(40)     not null,
    descripcion              varchar(200)     default 'ninguna',
    constraint propiedad_pantalla_pk primary key (propiedad_pantalla_id)
);

-- status_dispositivo 

create table status_dispositivo(
    status_dispositivo_id    number(10, 0)    not null,
    clave                    varchar2(10)     not null,
    descripcion              varchar(60)      default 'sin descripcion',
    constraint status_dispositivo_pk primary key (status_dispositivo_id)
);

-- dispositivo 
create table dispositivo(
    dispositivo_id           number(10, 0)    not null,
	---------------------------------------------------
    num_serie                varchar2(18)     null constraint dis_num_serie_uk unique,
	---------------------------------------------------
    cap_almacenamiento       number(6, 2)     not null,
    cap_memoria              number(6, 2)     not null,
	--para validar el tipo de dispositivo consideramos 
	-- gphone = ph
	-- gpad = pa
	-- gwatch = wa
    tipo                     char(2)          not null	
	constraint d_tipo_chk check(tipo in('ph','pa', 'wa')),
	precio                   number(10, 2)    not null,
    fecha_status             date             not null,
    cliente_id               null constraint dispositivo_cliente_id_fk
							 references cliente(cliente_id),
	status_dispositivo_id    not null constraint d_status_dis_id_fk
							 references status_dispositivo (status_dispositivo_id),
    constraint dispositivo_pk primary key (dispositivo_id)
);
-- aplicacion_dispositivo

create table aplicacion_dispositivo(
    aplicacion_dispositivo_id    number(10, 0)    not null,
    fecha_instalacion            date    	  default sysdate,
    actualizada                  number(1, 0)     not null,
    dispositivo_id               not null constraint ap_dispositivo_dis_id_fk 
								 references aplicacion(aplicacion_id),
    aplicacion_id                not null constraint ap_dispositivo_ap_id_fk 
								 references dispositivo(dispositivo_id),
    constraint ap_dispositivo_pk primary key (aplicacion_dispositivo_id)
);

-- historico_status_dispositivo

create table historico_status_dispositivo(
    historico_disp_id        number(10, 0)    not null,
    fecha_status             date             not null,
    status_dispositivo_id    not null constraint hist_status_dis_st_dis_fk 
							 references dispositivo(dispositivo_id),
    dispositivo_id           not null constraint hist_status_dis_disp_id_fk 
							 references status_dispositivo(status_dispositivo_id),
    constraint his_status_disp_pk primary key (historico_disp_id)
);


-- Poliza

create table poliza(
    poliza_id          number(10, 0)    not null,
    folio              number(10, 0)    not null
					   constraint poliza_folio_uk unique,
    fecha_inicio       date             not null,
    fecha_fin          date             not null,
    contrato_pdf       blob             not null,
    dispositivo_id     not null constraint poliza_dispositivo_id_fk 
                       references dispositivo(dispositivo_id),
    poliza_anterior    null constraint poliza_poliza_anterior_fk
                       references poliza(poliza_id),
	duracion_anios as (
	(fecha_fin - fecha_inicio)/365) virtual,
    constraint poliza_pk primary key (poliza_id)
);

-- gphone

create table gphone(
    dispositivo_id           not null constraint gphone_dispositivo_id_fk 
							 references dispositivo(dispositivo_id),
    num_telefono             varchar2(10)	  null
							 constraint gph_n_tel_uk unique,
    cap_camara_trasera       number(2, 0)    not null,
    cap_camara_delantera     number(2, 0)    not null,
    empresa_telefonica_id    null constraint gph_emp_tel_fk
    references empresa_telefonica(empresa_telefonica_id),
    constraint gphone_pk primary key (dispositivo_id)
);


-- gwatch 

create table gwatch(
    dispositivo_id        not null constraint gwatch_dispositivo_id_fk 
						  references dispositivo(dispositivo_id),
    forma                 varchar(1) default 'c',
    color_id              not null constraint gwatch_color_fk
						  references color(color_id),
    material_correa_id    number(2, 0) default 1 
	constraint gwatch_material_correa_id_fk
						  references material_correa(material_correa_id),
    constraint gwatch_pk  primary key (dispositivo_id),
	-- consideramos 
	-- c = circular, r = rectangular y t=triangular
	constraint gwatch_forma_chk check(forma in('c','r','t'))
);

-- gpad 

create table gpad(
    dispositivo_id          not null constraint gpad_dispositivo_id_fk 
						    references dispositivo(dispositivo_id),
    cap_camara_delantera    number(2, 0)     not null,
    cap_camara_trasera      number(2, 0)     not null,
    constraint gpad_pk primary key (dispositivo_id)
);

-- gpad_propiedad_pantalla 

create table gpad_propiedad_pantalla(
    gpad_p_pantalla_id       number(10, 0)    not null ,
    propiedad_pantalla_id    not null constraint gpad_prop_p_p_pantalla_id_fk 
							 references propiedad_pantalla(propiedad_pantalla_id),
    dispositivo_id           not null constraint gpad_prop_p_dis_id_fk 
							 references gpad(dispositivo_id),
    constraint gpad_propiedad_pantalla_pk primary key (gpad_p_pantalla_id)
);
