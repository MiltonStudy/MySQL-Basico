delimiter $$
create procedure pc_add_ent(p_fecha_ent varchar(30), p_cantidad int, p_precio_unt int, p_inventario int, p_insumo int)
begin
insert into entradas values (null, p_fecha_ent, p_cantidad, p_precio_unt, (p_cantidad * p_precio_unt), p_inventario, p_insumo);
update insumos set Stock = (Stock + p_cantidad) where IdInsumo = p_insumo;
end $$
delimiter ;

call pc_add_ent('2020-12-09', 100, 2000, 1, 1);
drop procedure if exists pc_add_ent;
select * from entradas;


/* */
delimiter $$
create procedure pc_edit_ent(p_id_entrada int, p_fecha_ent varchar(30), p_cantidad int, p_precio_unt int, p_inventario int, p_insumo int)
begin
declare set_cantidad int;
declare set_insumo int;
select Cantidad into set_cantidad from entradas where IdEntradas = p_id_entrada;
select IdInsumo into set_insumo from entradas where IdEntradas = p_id_entrada;
update insumos set Stock = (Stock - set_cantidad) where IdInsumo = set_insumo;
update entradas set FechaEntrada = p_fecha_ent, Cantidad = p_cantidad, PrecioUnitario = p_precio_unt, 
PrecioTotal = (p_cantidad * p_precio_unt), IdInventario = p_inventario, IdInsumo = p_insumo 
where IdEntradas = p_id_entrada;
update insumos set Stock = (Stock + p_cantidad) where IdInsumo = p_insumo;
end $$
delimiter ;

call pc_edit_ent(59, '2020-12-09', 5, 200, 1, 2);
drop procedure if exists pc_edit_ent;
select * from entradas;


/* */
delimiter $$
create procedure pc_add_sld(p_fecha_sld varchar(30), p_cantidad int, p_inventario int, p_insumo int)
begin
insert into salidas values (null, p_fecha_sld, p_cantidad, p_inventario, p_insumo);
update insumos set Stock = (Stock - p_cantidad) where IdInsumo = p_insumo;
end $$
delimiter ;

call pc_add_sld("2020-12-03", 5, 1, 4);
drop procedure if exists pc_add_sld;


/* */
delimiter $$
create procedure pc_edit_sld(p_salida int, p_fecha_sal varchar(30), p_cantidad int, p_inventario int, p_insumo int)
begin
declare set_cantidad, set_insumo int;
select Cantidad into set_cantidad from salidas where IdSalidas = p_salida;
select IdInsumo into set_insumo  from salidas where IdSalidas = p_salida;
update insumos set Stock = (Stock + set_cantidad) where idInsumo = set_insumo;
update salidas set FechaSalida = p_fecha_sal, Cantidad = p_cantidad, IdInventario = p_inventario,
IdInsumo = p_insumo where IdSalidas = p_salida;
update insumos set Stock = (Stock - p_cantidad) where IdInsumo = p_insumo;
end $$
delimiter ;

call pc_edit_sld(12, "2020-08-03", 10, 1, 4);
drop procedure if exists pc_edit_sld;


/* */
delimiter $$
create procedure pc_eliminar_pd(p_pedido int)
begin
delete from detalles_pedido where IdPedido = p_pedido;
delete from pedido where IdPedido = p_pedido;
end $$
delimiter ;

call pc_eliminar_pd(9);


/* */
delimiter $$
create procedure pc_dp_precio(p_prenda varchar(20), p_talla varchar(5), p_texto_estampar varchar(50), p_tecnica_est varchar(30), p_pedido int)
begin

declare set_cantidad int;
declare precio_prenda, precio_talla, precio_te, precio_total int;
select CantidadPrenda into set_cantidad from pedido where IdPedido = p_pedido;
insert into detalles_pedido values (null, p_prenda, p_talla, p_texto_estampar, p_tecnica_est, p_pedido);

if p_prenda = 'Camiseta' then
	set @precio_prenda = 5000;
elseif p_prenda = 'Jean' then
	set @precio_prenda = 6000;
elseif p_prenda = 'Buzo' then
	set @precio_prenda = 10000;
end if;

if p_talla = 'XS' then
	set @precio_talla = 2000;
elseif p_talla = 'S' then
	set @precio_talla = 2000;
elseif p_talla = 'M' then
	set @precio_talla = 2000;
elseif p_talla = 'L' then
	set @precio_talla = 200;
elseif p_talla = 'XL' then
	set @precio_talla = 3000;
elseif p_talla = 'XXL' then
	set @precio_talla = 3000;
end if;

if p_tecnica_est = 'Plastisol' then
	set @precio_te = 5000;
elseif p_tecnica_est = 'Flo' then
	set @precio_te = 4000;
elseif p_tecnica_est = 'Estender' then
	set @precio_te = 4500;
elseif p_tecnica_est = 'Bodil' then
	set @precio_te = 4000;
end if;

set @precio_total = set_cantidad * (@precio_prenda + @precio_talla + @precio_te);

update pedido set PrecioTotal = @precio_total where IdPedido = p_pedido;

end $$
delimiter ;

call pc_add_dp_precio('Camiseta', 'XL', 'San Juan', 'Plastisol', 18);
drop procedure if exists pc_add_dp_precio;
