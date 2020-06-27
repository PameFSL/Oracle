--@Autores: Luis Enrique Miramontes Sarabia
--	    Salgado Fernández Pamela
--@Fecha creación: 11/06/2018
--@Descripción: Triger que validara que un dispositivo gpad no posea mas de 4 
		--propiedades de pantalla

set serveroutput on 
create or replace trigger tr_gpad_propiedad_pantalla
	for insert or update of dispositivo_id
	on GPAD_PROPIEDAD_PANTALLA
	compound trigger
	v_num_prop number;
	v_nueva_prop_d GPAD_PROPIEDAD_PANTALLA.dispositivo_id%type;
	v_gpad	GPAD_PROPIEDAD_PANTALLA.propiedad_pantalla_id%type;

	after each row is 
		begin 
		v_gpad:= :new.propiedad_pantalla_id;
		v_nueva_prop_d := :new.dispositivo_id;
	end after each row;
	
	after statement is
	begin 
		select count(gp.propiedad_pantalla_id) num_p
		into v_num_prop
		from GPAD_PROPIEDAD_PANTALLA gp
		where gp.dispositivo_id = v_nueva_prop_d
		group by dispositivo_id;
		if v_num_prop <=4 then 
			dbms_output.put_line (' agregando propiedad: '||v_gpad);
			dbms_output.put_line ('al dispositivo '||v_nueva_prop_d);

			else 
			raise_application_error (-20001, 'error: no es posible que un dispositivo 
				gpad tenga más de 4 propiedades de pantalla');
		end if;
	end after statement;
end tr_gpad_propiedad_pantalla;

/
show errors		
