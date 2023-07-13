FROM nginx:alpine

RUN apk update

RUN apk add bash inotify-tools

COPY 50-nginx-setting-updater.sh /docker-entrypoint.d

RUN chmod +x /docker-entrypoint.d/50-nginx-setting-updater.sh

RUN addgroup -S ssl-data

RUN addgroup nginx ssl-data

RUN mkdir /etc/nginx/ssl

COPY nginx.conf /etc/nginx

RUN mkdir /var/www && echo "Healthy" > /var/www/health.html

