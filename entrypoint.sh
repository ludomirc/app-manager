#!/bin/bash

# Fail fast
set -e

# Inject API_URL into frontend config.json
echo "Injecting API URL into frontend config.json..."
echo "{
  \"apiUrl\": \"${API_URL}\"
}" > /usr/share/nginx/html/assets/config.json

echo "Starting Spring Boot backend..."
java -jar /app/app.jar &

echo "Starting Nginx (Angular frontend)..."
exec nginx -g "daemon off;"
