--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sys/system as sysdba

prompt creando usuario sfms_proy_admin
	create user sfms_proy_admin identified by sfms
	quota unlimited on users;

Prompt creando al usuario sfms_proy_invitado
	create user sfms_proy_invitado identified by invitado
    quota 100k on users;
--************************************************	
Prompt creando directorio tmp_dir
!mkdir /tmp/bases
create or replace directory tmp_dir as '/tmp/bases';
prompt creando dirctorio para blobs	
!mkdir /tmp/blobs/fileuploads
create or replace directory fileuploads as '/tmp/blobs/fileuploads';

Prompt creando roles
	create role rol_inv;
	grant create session to rol_inv; 
	--------------------------------------------------------------
	create role rol_admon;
	grant create session, create table, create view, create synonym,create sequence,
			 create trigger, create procedure, create public synonym , drop public synonym to rol_admon;
	grant read, write on directory tmp_dir to rol_admon ;
	grant read, write on directory fileuploads to sfms_proy_admin ;

	
Prompt Asignando roles a usuarios
	grant rol_admon, create table to sfms_proy_admin;
	grant rol_inv to sfms_proy_invitado; 
Prompt Listo! :D
