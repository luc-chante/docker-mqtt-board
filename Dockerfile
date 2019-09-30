FROM node:lts-alpine AS build-env
WORKDIR /app
RUN wget https://github.com/flespi-software/MQTT-Board/archive/v.1.7.3.tar.gz
RUN tar -xvf v.1.7.3.tar.gz
WORKDIR /app/MQTT-Board-v.1.7.3
RUN npm install \
    && ./node_modules/.bin/quasar build

FROM nginx:stable-alpine
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /app
COPY --from=build-env /app/MQTT-Board-v.1.7.3/dist/spa-mat .
EXPOSE 80

