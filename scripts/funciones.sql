/* Ejercicio 5*/
delimiter $$
create function FC_cantidad_proveedor(p_nombre_prov varchar(30), p_apellido_prov varchar(30))
returns int
begin
declare p_prov int;
declare p_cantidad int;
select prov_codigo into p_prov from proveedor where prov_nombres = p_nombre_prov and prov_apellidos = p_apellido_prov;
select count(*) into p_cantidad from proveedor_articulo where prov_codigo = p_prov;
return p_cantidad;
end $$
delimiter ;

select FC_cantidad_proveedor("Diego", "Lopez");
drop function FC_cantidad_proveedor;


/* Ejercicio 6*/
delimiter $$
create function FC_localidad_usuarios(p_localidad varchar(40))
returns int
begin
declare num_usuarios int;
select count(usuarios.id_localidad) into num_usuarios from usuarios inner join localidad 
on usuarios.id_localidad = localidad.id_localidad 
where localidad.nombre_localidad = p_localidad;
return num_usuarios;
end $$
delimiter ;

select FC_localidad_usuarios("Kennedy");
drop function FC_localidad_usuarios;


/* Ejercicio 7*/
delimiter $$
create function FC_categoria_articulos(p_categoria varchar(30))
returns int
begin
declare num_articulos int;
select count(articulo.idCategoria) into num_articulos from categorias inner join articulo
on categorias.idCategorias = articulo.idCategoria
where categorias.catNombre = p_categoria;
return num_articulos;
end $$
delimiter ;

select FC_categoria_articulos("Bebidas");
drop function FC_categoria_articulos;