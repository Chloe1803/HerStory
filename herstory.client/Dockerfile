# Étape 1 : Build de l'application Angular
FROM node:18 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
ARG API_URL_PROD
ARG API_SECRET_TOKEN
RUN sed -i "s|API_URL_PLACEHOLDER|${API_URL_PROD}|g" src/environments/environment.prod.ts
RUN sed -i "s|API_SECRET_TOKEN_PLACEHOLDER|${API_SECRET_TOKEN}|g" src/environments/environment.prod.ts
RUN npm run build --configuration=production

# Étape 2 : Serveur Nginx pour le front
FROM nginx:alpine
COPY --from=build /app/dist/herstory-client /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
