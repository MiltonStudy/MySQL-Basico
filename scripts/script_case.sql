/* Ejercicio 2*/
delimiter $$
create procedure pa_case(p_localidad int)
begin

case
when p_localidad = 1 then
	update barrio set bar_obra = "Parques" where id_localidad = p_localidad;
	select "Registro Actualizado";
when p_localidad = 2 then
	update barrio set bar_obra = "Centro Comercial" where id_localidad = p_localidad;
	select "Registro Actualizado";
when p_localidad = 3 then
	update barrio set bar_obra = "Plazoleta de Comida" where id_localidad = p_localidad;
	select  "Registro Actualizado";
else
	update barrio set bar_obra = "Obra Pendiente" where id_localidad = p_localidad;
	select "Registro Actualizado";
end case;
end $$
delimiter ;
call pa_case(1);


/* Ejercicio 3*/
delimiter $$
create procedure pa_cat_case(p_categoria varchar(30))
begin
case 
when p_categoria = p_categoria then
select articulo.*, categorias.catNombre from articulo
inner join categorias on articulo.idCategoria = categorias.idCategorias
where categorias.catNombre = p_categoria;

end case;

end $$
delimiter ;
drop procedure if exists pa_cat_case;
call pa_cat_case("Bebidas");


/* Ejercicio 4*/
delimiter $$
create procedure pa_vantasCat_case(p_categoria varchar(30))
begin
case 
when p_categoria = p_categoria then
select sum(art_precio) as Total_Ventas_Categoria from articulo
inner join categorias on articulo.idCategoria = categorias.idCategorias
where categorias.catNombre = p_categoria;

end case;
end $$
delimiter ;

drop procedure if exists pa_vantasCat_case;
call pa_vantasCat_case("Bebidas");


/* Ejercicio 5*/
delimiter $$
create procedure pa_edad_prov_case(p_edad int)
begin
case 
when p_edad < 20 then
	select "Consultar certificado de existencia CC" as Informacion;
when p_edad > 20 and p_edad < 40 then
	select "Portafolio de productos y servicios" as Informacion;
else 
	select "Solicitar estados financieros" as Informacion;
end case;
end $$
delimiter ;

call pa_edad_prov_case(30);
drop procedure if exists pa_edad_prov_case;


/* Ejercicio 6*/
delimiter $$
create procedure pa_totalPro_case(p_proveedor int)
begin
case
when p_proveedor = p_proveedor then
	select count(art_codigo) as Total_productos from proveedor_articulo 
	where prov_codigo = p_proveedor;
else
	select "Proveedor no registrado";
end case;
end $$
delimiter ;

call pa_totalPro_case(121);
drop procedure if exists pa_totalPro_case;