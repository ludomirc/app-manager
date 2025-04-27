#!/bin/bash

# Inject API_URL into frontend config.json
echo "Injecting API URL into frontend config.json..."
echo "{
  \"apiUrl\": \"${API_URL}\"
}" > /usr/share/nginx/html/assets/config.json

echo "Starting Nginx (Angular frontend)..."
service nginx start

echo "Starting Spring Boot backend..."
exec java -jar /app/app.jar
