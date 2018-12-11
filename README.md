## Contenedor con SQL Server en Docker

Se crea imagen usando como base *microsoft/mssql-server-linux*, sobre esta se restauran las siguientes base de datos:

* AdventureWorks2017

A cada una de estas base de datos se les crea y asocia el usuario *AdventureUser* como db_owner.

> La clave asignada al usuario **SA** debe cumplir con las [politicas de seguridad](https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?view=sql-server-2017) establecidas por SQL SERVER. 

> Copie en /backups los ".bak" que se sea restaurar e incluya el comando SQL de restauración en el archivo *RestoreDb.sql*. Incluya en este archivos la creación de usuarios y permisos adicionales que requiera. 

## Requerimientos tecnicos
- Windows 10 Professional.
- Hyper-V habilitado.
- Docker 2.0 o superior habilitado para contenedores Linux.




# Construir imagen sql-server-linux

La primera vez se debe descagar la imagen base, para ello utilice lo siguiente:

`docker pull microsoft/mssql-server-linux:2017-CU12`

Para construir la imagen ejecute:

`docker build . -t sql-server-linux`

Con el siguiente comando puede visualizar el listaod de imagenes creadas 

`docker images` .



# Ejecutar el contenedor
Con el siguiente comando se creará el contenedor la que llamado **sql-server-container** utilizando la imagen **sql-server-linux**.

`docker run -d -p 1500:1433 --name sql-server-container sql-server-linux`

> La clave asignada al usuario **SA**  es *Sa.@2018Password*. 

> El puerto a través del cual se expone el servicio es el 1500.


# Conexión

Para conectarse desde el host al contenedor utilice los siguientes parámetros.

- Servidor: localhost,1500
- Tipo de autenticación: SQL Authentication
- Usuarios: sa, AdventureUser
- Clave: Sa.@2018Password, Adventure.@2018



# Observaciones


- Esta imagen ha sido configurada para asignarse 2GB de RAM. Para cambiar este parámetro ubique la siguiente línea `/opt/mssql/bin/mssql-conf set memory.memorylimitmb 2048` en el archivo *Restore.sh* y asigne el valor deseado y luego contruya la imagen. 

- Una vez restaurados los backups estos son borrados de la imagen. Si desea convervarlos remueva la línea `rm -rf /work/*.bak` que se encuentra en el archivo *Restore.sh*.


# Comandos adicionales
Detiene la ejecución de todos los contenedores.

`docker kill $(docker ps -q)`

Remueve todos los contenedores.

`docker rm $(docker ps -a -q)`

Para ver los contenedores en ejecución utilice 
`docker ps` o `docker ps -a` para ver todos los contenedores, incluyendo los detenidos.

Para detener el contenedor utilice 

`docker stop sql-server-container`.

# Más información
Consulta el siguiente [post](http://helibertoarias.com/es/docker/docker-sql-server-linux-windows/) para mayor información.

