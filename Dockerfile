FROM node:16-alpine as build
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx as run
# EXPOSE is used by ElasticBeanstalk to map port 80, locally it serves no purpose and the -p must be used in docker run
EXPOSE 80
COPY --from=build /app/build /usr/share/nginx/html
# nginx is started automatically, so no start command is needed
