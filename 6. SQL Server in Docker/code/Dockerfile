FROM mcr.microsoft.com/mssql/server:2019-CTP2.3-ubuntu

#create /backup folder 
RUN mkdir -p /var/opt/mssql/backup

WORKDIR /var/opt/mssql/data

COPY AdventureWorks2017.mdf ./
COPY AdventureWorks2017_log.ldf ./

ENV SA_PASSWORD=SQL19-dev
ENV ACCEPT_EULA=Y
#ENV MSSQL_PID=Express

#ENV attach_dbs="[{'dbname':'AdventureWorks2017','dbFiles':['AdventureWorks2017.mdf','AdventureWorks2017_log.ldf']}]"





