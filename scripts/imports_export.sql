// import data

MySQL [bd_merqueo]> load data local infile 'C:/Users/57301/Escritorio/import_barrios.txt'
    -> into table barrio fields terminated by '.' lines terminated by '\r\n'
    -> ignore 1 lines;

Query OK, 3 rows affected, 0 warnings (0.191 sec)
Records: 3  Deleted: 0  Skipped: 0  Warnings: 60

MySQL [bd_merqueo]> select * from barrio;
+-----------+---------------------+--------------+
| id_barrio | Nombre_barrio       | id_localidad |
+-----------+---------------------+--------------+
|         1 | La libertad         |            6 |
|         2 | Ciudadela el recreo |            6 |
|         3 | Caldas              |            6 |
+-----------+---------------------+--------------+
3 rows in set (0.002 sec)

// export data

MySQL [bd_merqueo]> select * from barrio;
+-----------+---------------------+--------------+
| id_barrio | Nombre_barrio       | id_localidad |
+-----------+---------------------+--------------+
|         1 | La libertad         |            6 |
|         2 | Ciudadela el recreo |            6 |
|         3 | Caldas              |            6 |
|         4 | El Recuerdo         |            6 |
+-----------+---------------------+--------------+
4 rows in set (0.001 sec)

MySQL [bd_merqueo]> select * into outfile 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/export_barrios'
    -> fields terminated by "." lines terminated by "\r\n" from barrio;

Query OK, 4 rows affected, 1 warning (0.109 sec)

MySQL [bd_merqueo]> exit;
