--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: Archivo que crea todos los objetos necesarios para  
		--el correcto funcionamiento de la base de datos

set serveroutput on
-------------------------------
connect sys/system as sysdba
prompt borrando usuarios
drop user sfms_proy_admin cascade;
drop user sfms_proy_invitado cascade;
drop role rol_admon;
drop role rol_inv;
start e_sin.sql
start s-01-usuarios.sql
---------------------------------

Prompt Usuarios creados exitoso!
Prompt Creando tablas
Prompt Conectando a usuario admin para crear la tablas
connect sfms_proy_admin/sfms

start s-02-entidades.sql
Prompt Tablas creadas con exito
-------------------------------

start s-03-tablas_temporales.sql
---------------------------------
-- tabla externa
start s-04-tabla_ext.sql

---------------------------------s-03-tablas_temporales.sql
Prompt Creacion de secuencias

start s-05-secuencias.sql

Prompt Creacion de secuencias exitosa
---------------------------------
Prompt creacion de indices

start s-06-indices.sql

Prompt Indices Creados
---------------------------------
Prompt Creando sinonimos

start s-07-sinonimos.sql
------------------------------
--ejecutando programa para crear 
--los sinonimos de todas las tablas
connect sfms_proy_admin/sfms
start s-07-p_sinonimo.sql;
Prompt sinonimos creados
----------------------------------
Prompt Creando Vistas

start s-08-vistas.sql

Prompt Vistas creadas
-----------------------------------
Prompt Cargando Datos

start xs-09-carga-inicial.sql

Prompt datos cargados
-----------------------------------
prompt *-----------------------------------------*
prompt                CONSULTAS
PROMPT *-----------------------------------------*
start s-10-consultas.sql
Prompt creando Triggers
start s-11-tr_verifica_gpad.sql
start s-11-tr_verifica_version_aplicacion.sql
Prompt triggers creados
-----------------------------------
prompt creando procedimientos 
start s-13-p_num_defectuosos.sql
start s-13-p_cliente_compras.sql
Prompt procedimientos creados
----------------------------------
prompt creando funciones 
start s-15-fx-datos_cliente_tarjeta_csv.sql
start s-15-fx-secinfo_gphone.sql
start s-15-fx-vencimiento_poliza.sql
prompt *---------------------------------------*
---------------------------------------
Prompt    BASE DE DATOS LISTA para SU USO!   :D
prompt *
prompt *********************************************
prompt *    Ejecutando archivos de prueba	   *
prompt *********************************************
prompt *
prompt *-------PRUEBA DE TRIGGERS----------*
prompt prueba para verificar la cantidad de propiedades de pantalla de gpad
start s-12-tr-verifica_gpad-prueba.sql
prompt *
prompt ---------------------------------------------*
prompt *
prompt prueba para verificar que el formato de la version de una aplicacion sea correcto 
start s-12-tr-verifica-version-aplicacion-prueba.sql
prompt ---------------------------------------------*
prompt *
prompt *-------PRUEBA DE PROCEDIMIENTOS----------*
prompt procedimiento que muestra el numero de dispositivos defectuosos 
start s-14-p_num_defectuosos-prueba.sql
start s-14-p_cliente_compras_prueba.sql
prompt ------------------------------------------------*
prompt *
prompt *
prompt *-------PRUEBA DE FUNCIONES----------*
prompt ejecutando archivos de prueba para las funciones 
start s-16-fx-todas-prueba.sql

