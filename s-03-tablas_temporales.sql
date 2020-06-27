--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: código para crear las tablas temporales


connect sfms_proy_admin/sfms
prompt creando tabla_temporal

create global temporary table tabla_temporal (
    dispositivo_id           number(10, 0)    not null,
    num_serie                varchar2(18)	  null, 
    cap_almacenamiento       number(6, 2)     not null,
    cap_memoria              number(6, 2)     not null,
    tipo                     char(1)          not null
	constraint tipo_dis_chk check(tipo in('ph','pa', 'wa')),
    precio                   number(10, 2)    not null,
    fecha_status             date             not null,
    cliente_id               number(10, 0)    null,
    status_dispositivo_id    number(10, 0)    not null,
	----------datos gphone-------------------------------
	num_telefono             varchar2(10)	  null
							 constraint gp_n_tel_uk unique,
			--datos tambien de gpad
    cap_camara_trasera       number(2, 0)    null,
    cap_camara_delantera     number(2, 0)    null,
	----------datos empresa telefonica--------------------
	nombre_emp               varchar2(40)     null,
    logo_emp                 blob             null,
    direccion_fiscal         varchar2(40)     null,
	----------datos gwatch -------------------------------
	-- consideramos 
	-- c = circular, r = rectangular y t=triangular
	forma                 varchar(10) null
	constraint gw_forma_chk check(forma in('c','r','t')),
	-- consideramos 
	-- F = flexible y D = rigida
	tipo_mc           char(1) null
	constraint gw_tipo_chk check(tipo_mc in('F','D')),
	----------datos color -------------------------------
    codigo_rgb            varchar2(10)     null,
	----------datos material correa -----------------------
    clave_mc        varchar2(200)	   null
) on commit delete rows;
-- borra datos al hacer commit 











