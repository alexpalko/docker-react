FROM node:16-alpine as build
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx as run
COPY --from=build /app/build /usr/share/nginx/html
# nginx is started automatically, so no start command is needed
