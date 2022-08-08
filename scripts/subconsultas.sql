/* consulta matrimonios */
select matrimonio.id_Matrimonio, matrimonio.fecha_matrimonio,
matrimonio.id_Feligres_1 as id_Novio, feligres1.Nombre_feligres as Nombre_Novio, feligres1.Apellido_feligres as Apellido_Novio, 
matrimonio.id_Feligres_2 as id_Novia, feligres2.Nombre_feligres as Nombre_Novia, feligres2.Apellido_feligres as Apellido_Novia, 
matrimonio.id_Sacerdote, sacerdote.Nombre_sacerdote, sacerdote.Apellido_sacerdote, 
iglesia.Nombre_iglesia, diocesis.Nombre_diocesis
from matrimonio inner join feligres feligres1
on matrimonio.id_Feligres_1 = feligres1.id_Feligres
inner join feligres feligres2 on matrimonio.id_Feligres_2 = feligres2.id_Feligres
inner join sacerdote on matrimonio.id_Sacerdote = sacerdote.id_Sacerdote
inner join iglesia on sacerdote.id_Sacerdote = iglesia.id_Sacerdote
inner join diocesis on iglesia.id_Diocesis = diocesis.id_Diocesis
where matrimonio.fecha_matrimonio between '2016-01-01' and '2019-12-31'
order by matrimonio.fecha_matrimonio desc;


/* lista de ferigreses con los sacramentos que tienen */
select feligres_sacramento.id_Feligres, feligres.Nombre_feligres, feligres.Apellido_feligres,
sacramento.nombre_sacramento as Sacramento, feligres_sacramento.Fecha_sacramento,
sacerdote.Nombre_sacerdote, sacerdote.Apellido_sacerdote,
iglesia.nombre_iglesia as Iglesia, iglesia.Ciudad_iglesia
from feligres_sacramento inner join feligres
on feligres_sacramento.id_feligres = feligres.id_feligres
inner join sacramento
on feligres_sacramento.id_sacramento = sacramento.id_sacramento
inner join iglesia
on feligres_sacramento.id_iglesia = iglesia.id_iglesia
inner join sacerdote
on iglesia.id_Sacerdote = sacerdote.id_Sacerdote
where feligres_sacramento.Fecha_sacramento between '2012-01-01' and '2018-12-31'
order by feligres.Nombre_feligres;


/* feligrese con el numero de sacramentos que tienen */
select feligres.id_Feligres, feligres.Nombre_feligres, feligres.Apellido_feligres,
count(feligres_sacramento.id_sacramento) as N_Sacramentos
from feligres inner join feligres_sacramento
on feligres.id_Feligres = feligres_sacramento.id_Feligres
group by feligres.id_feligres
order by count(feligres_sacramento.id_sacramento) desc;


/* feligreses que no tienen ningun sacramento */
select * from feligres
where id_Feligres not in
(select id_Feligres from feligres_sacramento)
order by Nombre_feligres;


/* feligrese que tiene el sacramento de la confirmacion */
select id_Feligres, Nombre_feligres, Apellido_feligres
from feligres
where id_feligres in
(select id_feligres from feligres_sacramento where id_sacramento = 15);


/* lista de diocesis con las iglesias que tienen */
select diocesis.*, obispo.Nombre_obispo, obispo.Apellido_obispo,
iglesia.Nombre_iglesia, iglesia.ciudad_iglesia,
sacerdote.Nombre_sacerdote, sacerdote.Apellido_sacerdote
from diocesis inner join obispo
on diocesis.id_obispo = obispo.id_obispo
inner join iglesia
on diocesis.id_diocesis = iglesia.id_diocesis
inner join sacerdote
on iglesia.id_sacerdote = sacerdote.id_sacerdote
order by diocesis.Nombre_diocesis;


/* diocesis con el numero de iglesias que tienen */
select diocesis.Nombre_diocesis, diocesis.Ciudad_diocesis, diocesis.Sede_diocesis,
count(id_iglesia) as N_Iglesia
from diocesis inner join iglesia
on diocesis.id_diocesis = iglesia.id_diocesis
group by diocesis.id_diocesis
order by count(id_iglesia) desc;


/* diocesis que no tienen ninguna iglesia */
select diocesis.*,
obispo.Nombre_obispo, obispo.Apellido_obispo
from diocesis inner join obispo
on diocesis.id_obispo = obispo.id_obispo
where id_diocesis not in
(select id_diocesis from iglesia)
order by Nombre_diocesis;


/* lista de sacerdotes con el numero de sacramentos que han dado */
select sacerdote.id_sacerdote, sacerdote.Nombre_sacerdote, sacerdote.Apellido_sacerdote,
count(feligres_sacramento.id_Sacramento)
from feligres_sacramento inner join sacerdote
on feligres_sacramento.id_Sacerdote = sacerdote.id_Sacerdote
inner join iglesia
on sacerdote.id_Sacerdote = iglesia.id_Sacerdote
group by sacerdote.id_Sacerdote
order by count(feligres_sacramento.id_Sacramento) desc;


/* sacerdotes que no han dado ningun sacramento */
select *, iglesia.nombre_iglesia
from sacerdote inner join iglesia
on sacerdote.id_sacerdote = iglesia.id_sacerdote
where sacerdote.id_sacerdote not in
(select id_sacerdote from feligres_sacramento);


/* lista de feligrese que han recibido un sacramento el dia sabado */
select concat (feligres.nombre_feligres, " ", feligres.apellido_feligres) as feligres, sacramento.id_sacramento, sacramento.nombre_sacramento,
iglesia.id_iglesia, iglesia.nombre_iglesia, sacerdote.id_sacerdote, sacerdote.nombre_sacerdote
from feligres inner join feligres_sacramento on feligres.id_feligres = feligres_sacramento.id_feligres
inner join sacerdote on feligres_sacramento.id_sacerdote = sacerdote.id_sacerdote
inner join sacramento on feligres_sacramento.id_sacramento = sacramento.id_sacramento
inner join iglesia on feligres_sacramento.id_iglesia = iglesia.id_iglesia
where feligres.id_feligres in (select id_feligres from feligres_sacramento where dayofweek(fecha_sacramento) = 4);


/* costo total del sacramento de la confirmacion*/
select sacramento.id_Sacramento, sacramento.Nombre_sacramento, sum(feligres_sacramento.costo_sacramento) as Costo_sacramento
from feligres_sacramento inner join sacramento on feligres_sacramento.id_sacramento = sacramento.id_sacramento
where feligres_sacramento.id_sacramento = 15;