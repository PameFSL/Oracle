--@Autorer: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sys/system as sysdba
prompt borrando 
drop user sfms_proy_admin cascade;
drop user sfms_proy_invitado cascade;
drop role rol_admon;
drop role rol_inv;
start e_sin.sql

connect sys/system as sysdba
start s-01-usuarios.sql;
start s-02-entidades.sql;
start s-03-tablas_temporales.sql;
start s-05-secuencias.sql;
start s-08-vistas.sql;
start s-09-carga-inicial.sql;
start s-07-sinonimos.sql;




