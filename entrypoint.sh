#!/bin/bash
echo "Starting Nginx (Angular frontend)..."
service nginx start

echo "Starting Spring Boot backend..."
exec java -jar /app/app.jar
