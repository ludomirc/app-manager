# ---------- Stage 1: Build Angular frontend ----------
FROM node:18 AS frontend-builder
WORKDIR /app
COPY app-manager-frontend/ .
RUN npm install && npm run build

# Debug: list built frontend files
RUN ls -l /app/dist/application-manage/browser/

# ---------- Stage 2: Build Spring Boot backend ----------
FROM maven:3.9.6-eclipse-temurin-17 AS backend-builder
WORKDIR /app
COPY app-manager-backend/ .
RUN mvn clean package -DskipTests

# ---------- Stage 3: Final image ----------
FROM eclipse-temurin:17-jdk-jammy
WORKDIR /app

# Copy backend jar
COPY --from=backend-builder /app/target/*.jar app.jar

# Install Nginx first
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*

# Ensure Nginx folders exist (usually created by install, but safe to include)
RUN mkdir -p /usr/share/nginx/html /etc/nginx /var/lib/nginx

# Copy Angular dist
COPY --from=frontend-builder /app/dist/application-manage/browser/ /usr/share/nginx/html/

# Copy Nginx config and entrypoint
COPY nginx.conf /etc/nginx/nginx.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 80 8080
ENTRYPOINT ["/entrypoint.sh"]

