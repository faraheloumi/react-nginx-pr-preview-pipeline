# Stage 1 : build avec node
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# Stage 2 : image nginx optimisée pour servir le build
FROM nginx:stable-alpine
# supprimer la conf par défaut (optionnel)
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist /usr/share/nginx/html
# expose 80 pour le container
EXPOSE 80
# start nginx (par défaut CMD already present in nginx image)