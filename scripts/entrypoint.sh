#!/bin/bash

# Start SQL Server in the background
/opt/mssql/bin/sqlservr &

# Wait for SQL Server to start
sleep 30

# Start the script to create the DB and user
/usr/config/configure-db.sh

# Keep the container running
wait