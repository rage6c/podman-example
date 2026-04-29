FROM nginx:1.27-alpine

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "mkdir -p /logs/ngix-proxy && exec nginx -g 'daemon off;'"]
