
FROM microsoft/mssql-server-linux:2017-CU12

RUN mkdir /work 

COPY /backups/AdventureWorks2017.bak /work

COPY /src/RestoreDb.sql /work

COPY /src/Restore.sh /work

WORKDIR /work

RUN chmod 755 Restore.sh

RUN ./Restore.sh RestoreDb.sql 
