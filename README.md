# App Manager - Full Docker Build

This project builds and packages both the **Angular frontend** and the **Spring Boot backend** into a single 
Docker image, using a **multi-stage Dockerfile**.

---

## Requirements

- Docker installed ([Install Docker](https://docs.docker.com/get-docker/))
- Git installed ([Install Git](https://git-scm.com/))

---

## Initial Setup

### 1. Clone the main Docker project folder

```bash
git clone https://github.com/YourUsername/app-manager-full-pack.git
cd app-manager-full-pack
```

### 2. Clone the frontend and backend source code inside this folder

```
# Clone frontend
git clone https://github.com/ludomirc/app-manager-frontend.git app-manager-frontend

# Clone backend
git clone https://github.com/ludomirc/app-manager-backend.git app-manager-backend
```

👉 Your folder structure must look like this:

```
app-manager-full-pack/
├── Dockerfile
├── entrypoint.sh
├── nginx.conf
├── app-manager-frontend/   # frontend source code
├── app-manager-backend/    # backend source code
```

---

## 🚀 Build the Full Docker Image

Inside the `app-manager-full-pack` folder:

```
docker build -t app-manager-full .
```

👉 This command will:
- Build the Angular frontend
- Build the Spring Boot backend
- Create a final lightweight image with Nginx serving the frontend and Java running the backend

---

## 💡 Run the Container

After building:

```bash
docker run -d \
  -p 80:80 -p 443:443 \
  --name app-manager-full-container \
  -v /etc/letsencrypt:/etc/letsencrypt:ro \
  -v /var/lib/letsencrypt:/var/lib/letsencrypt:ro \
  -e DB_PASSWORD="pealse_replace_to_your_db_password" \
  -e CORS_ALLOWED_ORIGINS="https://application-manager.qbitlc.com" \
  -e APP_JWT_SECRET="pealse_replace_to_jour_jwt_secret" \
  -e APP_JWT_ISSUER_URI="https://application-manager.qbitlc.com/app-manager" \
  -e API_URL="https://application-manager.qbitlc.com/app-manager/api" \
  app-manager-full:latest

```

👉
- Your frontend will be available on port **80**
- Your backend will be available on port **8080**

---

## 📅 Build Automation Script (Optional)

You can automate cloning, building, and logging using a script like `build-all.sh`:

```bash
#!/bin/bash

# Clone frontend if not exists
if [ ! -d "app-manager-frontend" ]; then
  git clone https://github.com/ludomirc/app-manager-frontend.git app-manager-frontend
fi

# Clone backend if not exists
if [ ! -d "app-manager-backend" ]; then
  git clone https://github.com/ludomirc/app-manager-backend.git app-manager-backend
fi

# Create logs folder
mkdir -p build-logs

# Build Docker image and save log
docker build -t app-manager-full . | tee build-logs/build.log
```

Make it executable and run it:

```
chmod +x build-all.sh
./build-all.sh
```

👉 It will:
- Clone the missing source code if needed
- Build the Docker image
- Save build logs to `build-logs/build.log`

---

# 📢 Notes

- Ensure ports **80** and **8080** are open in your firewall.
- Verify enough disk space for building Node.js and Maven dependencies.

---

# 🌟 Ready to Deploy!

You are ready to build and deploy the full App Manager system with Docker! 🎉

---

