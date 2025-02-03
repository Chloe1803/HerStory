#!/bin/bash

# Wait 60 seconds for SQL Server to start up by ensuring that
# calling SQLCMD does not return an error code, which will ensure that sqlcmd is accessible
# and that system and user databases return "0" which means all databases are in an "online" state
# https://docs.microsoft.com/en-us/sql/relational-databases/system-catalog-views/sys-databases-transact-sql?view=sql-server-2017

DBSTATUS=1
ERRCODE=1
i=0

while [[ $DBSTATUS -ne 0 ]] && [[ $i -lt 120 ]] && [[ $ERRCODE -ne 0 ]]; do
	i=$(($i+1))
	echo "Attempt $i to connect to SQL Server..."
	DBSTATUS=$(/opt/mssql-tools18/bin/sqlcmd -h -1 -t 1 -C -U sa -P $MSSQL_SA_PASSWORD -Q "SET NOCOUNT ON; select SUM(state) from sys.databases")
	ERRCODE=$?
	sleep 1
done

if [ $DBSTATUS -ne 0 ] || [ $ERRCODE -ne 0 ]; then
	echo "SQL Server took more than 120 seconds to start up or one or more databases are not in an ONLINE state"
	exit 1
fi

echo "✅ SQL Server est démarré ! Vérification de l'existence de la base de données HerStory..."

# Vérifier si la base existe déjà
DB_EXISTS=$(/opt/mssql-tools18/bin/sqlcmd -C -U sa -P $MSSQL_SA_PASSWORD -d master -h -1 -t 1 -Q "IF EXISTS (SELECT name FROM sys.databases WHERE name = 'HerStory') PRINT 'EXISTS' ELSE PRINT 'NOT_EXISTS'" | tr -d '\r')

if [ "$DB_EXISTS" == "EXISTS" ]; then
    echo "✅ La base de données HerStory existe déjà. Aucun script SQL n'est exécuté."
else
    echo "🚀 Création de la base de données HerStory..."
    /opt/mssql-tools18/bin/sqlcmd -C -U sa -P $MSSQL_SA_PASSWORD -d master -i HerStoryDB.sql
fi
