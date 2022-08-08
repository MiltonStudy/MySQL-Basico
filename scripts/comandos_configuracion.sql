/* muestra como se construyo una tabla */
SHOW CREATE TABLE;

/*especifica si se deben comprobar o no las restricciones de clave externa para las tablas */
SET FOREIGN_KEY_CHECKS=1;

/* desactiva el modo de actualizacion segura */
SET SQL_SAFE_UPDATES = 0;

/* realiza un backup a la bd con procedimientos almacenados */
MYSQLDUMP -U ROOT -P --ROUTINES BD;
