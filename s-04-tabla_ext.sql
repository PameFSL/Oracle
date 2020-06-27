--@Autorer: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de tabla externa
set termout ON
prompt creando tabla externa
connect sfms_proy_admin/sfms

create table entregas_a_domicilio(
	dispositivo_id number(10,0),
	nombre_cliente varchar2(40),
	ap_paterno varchar2(40),
	direccion varchar2(100),
	hora_pedido date,
	hora_entrega date, 
	quejas_sugerencias varchar2(200)
)
organization external (
  type oracle_loader
  default directory tmp_dir
  access parameters (
  records delimited by newline
  badfile tmp_dir:'reporte_ext_bad.log'
  logfile tmp_dir:'reporte_ext.log'
  fields terminated by ','
  missing field values are null
  (
    dispositivo_id, nombre_cliente,ap_paterno,direccion,
    hora_pedido date mask "hh24:mi:ss", hora_entrega date mask "hh24:mi:ss", quejas_sugerencias
  )
)
location ('e_domicilio.csv')
)
reject limit unlimited;