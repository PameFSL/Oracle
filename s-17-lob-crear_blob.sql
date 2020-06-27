--@Autor: Salgado Fernández Pamela/Miramontes Sarabia Luis Enrique
--@Fecha creación: 09/06/2018
--@Descripción: Creación de usuarios y roles

connect sfms_proy_admin/sfms

create or replace function crear_blob (
	p_nombre varchar2)
return blob
is
	dest_loc blob := empty_blob();
	src_loc  bfile:= bfilename('FILEUPLOADS', p_nombre);

begin
	--abrimos archivo binario de fuente
	dbms_lob.open(src_loc, dbms_lob.lob_readonly);
	--creamos un archivo lob temporal
	dbms_lob.createtemporary(
		lob_loc => dest_loc,
		cache   => true,
		dur     => dbms_lob.session
	);
	--abrimos el lob temporal
	dbms_lob.open(dest_loc, dbms_lob.lob_readwrite);
	--cargamos el archivo binario
	dbms_lob.loadfromfile(
		dest_lob  => dest_loc,
		src_lob   => src_loc,
		amount    => dbms_lob.getlength(src_loc)
	);
	--cerramos los lob
	dbms_lob.close(dest_loc);
	dbms_lob.close(src_loc);
	--regresamos lob
	return dest_loc;
end crear_blob;
/
show errors; 
