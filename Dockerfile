FROM node:12.16.2-alpine AS build-step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx:1.16.0-alpine as prod-stage
COPY --from=build-step /app/dist/authentication-app /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]