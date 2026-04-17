# Dockerfile para Scopios Medical - Producción
FROM nginx:1.25-alpine

# Copiar configuración de Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Copiar archivos compilados
COPY dist/ /usr/share/nginx/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
