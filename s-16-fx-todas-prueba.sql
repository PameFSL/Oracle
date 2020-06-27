--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

set serveroutput on

connect sfms_proy_admin/sfms
prompt conectado usuario sfms_proy_admin



prompt ****************************************************
prompt *             fx_secinfo_gphone                    *
prompt ****************************************************

select fx_secinfo_gphone(6) as SecInfo from dual;

prompt ****************************************************
prompt *             fx_vencimiento_poliza                *
prompt ****************************************************

select fx_vencimiento_poliza(3,'S') as Vencimiento_Segundos from dual;
select fx_vencimiento_poliza(3,'M') as Vencimiento_Segundos from dual;
select fx_vencimiento_poliza(3,'H') as Vencimiento_Segundos from dual;
select fx_vencimiento_poliza(3,'D') as Vencimiento_Segundos from dual;

prompt ****************************************************
prompt *          fx_datos_cliente_tarjeta_csv            *
prompt ****************************************************

select fx_datos_cliente_tarjeta_csv(1) as Datos_CSV from dual;

