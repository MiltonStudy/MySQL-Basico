/* consulta_entrada_bar */
select am.id_Amigo as ID_Amigo, am.Nombre_amigo, am.Apellido_amigo, am.Telefono_amigo,
br.id_Bar, br.Nombre_bar, br.Direccion_bar,
eb.Jornada, eb.fecha 
from Amigo am join Entrada_Bar eb on am.id_Amigo = eb.id_Amigo
join Bar br on eb.id_Bar = br.id_Bar
where fecha between '2020-10-01' and '2020-10-15'
order by am.Nombre_Amigo;


/* cerveza que mas gusta */
select count(am.Calificacion) as Ranking, am.id_cerveza,
cv.nombre_cerveza as Cerveza_Preferida, mc.nombre_marca as Marca_Cerveza
from amigo_cerveza am inner join cerveza cv
on am.id_cerveza = cv.id_cerveza
inner join marca_cerveza mc on cv.id_marca_cerveza = mc.id_marca_cerveza
where am.Calificacion = 'Buena' group by cv.id_cerveza
order by count(am.Calificacion) desc
limit 2;


/* cerveza que menos gusta */
select count(am.Calificacion) as Ranking, am.id_cerveza,
cv.nombre_cerveza as Cerveza_Que_Menos_Gusta, mc.nombre_marca as Marca_Cerveza
from amigo_cerveza am inner join cerveza cv
on am.id_cerveza = cv.id_cerveza
inner join marca_cerveza mc on cv.id_marca_cerveza = mc.id_marca_cerveza
where am.Calificacion = 'Mala' group by cv.id_cerveza
order by count(am.Calificacion) desc
limit 2;


/* cerveza que no se vende en ningun bar */
select cerveza.id_cerveza, cerveza.nombre_cerveza,
marca_cerveza.nombre_marca from cerveza
inner join marca_cerveza
on cerveza.id_marca_cerveza = marca_cerveza.id_marca_cerveza
where id_cerveza not in
(select id_cerveza from bar_cerveza);


/* consulta amigo_cerveza */
select ac.id_Cerveza, cv.Nombre_cerveza, count(ac.id_Amigo) as Numero_De_Consumidores 
from amigo_cerveza ac 
join cerveza cv on ac.id_Cerveza = cv.id_Cerveza
group by ac.id_Cerveza
having count(ac.id_Amigo) > 2
order by count(ac.id_Amigo) desc;


/* marca que produce mas cervezas */
select count(cv.id_cerveza) as Produce, mc.nombre_marca from cerveza cv
inner join marca_cerveza mc on cv.id_marca_cerveza = mc.id_marca_cerveza
group by cv.id_Marca_Cerveza
order by count(cv.id_cerveza) desc;


/* consulta bar_cerveza */
select bc.id_Cerveza, cv.Nombre_Cerveza as Cerveza, mc.Nombre_marca as Marca_Cerveza,
br.id_Bar, br.Nombre_bar as Bar, br.Direccion_bar as Direccion
from bar_cerveza bc join cerveza cv on bc.id_Cerveza = cv.id_Cerveza
join bar br on bc.id_Bar = br.id_Bar
join marca_cerveza mc on cv.id_Marca_Cerveza = mc.id_Marca_Cerveza
order by cv.Nombre_Cerveza, br.Nombre_bar;