--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sfms_proy_admin/sfms

insert into empresa_telefonica(empresa_telefonica_id,nombre,direccion_fiscal,logo)
	values(3,'T-mobile','Beverly Hills 90210', crear_blob('imagen.png'));

select empresa_telefonica_id, dbms_length(logo) as longitud_logo
from empresa_telefonica
where empleado_id = 3;


