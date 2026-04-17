# Dockerfile para Scopios Medical - Producción
# Sirve la aplicación React compilada con Nginx

FROM nginx:1.25-alpine

# Metadata
LABEL maintainer="Scopios Medical"
LABEL description="Scopios Medical Platform - Production Build"
LABEL version="1.0.0"

# Instalar herramientas necesarias y crear usuario sin privilegios
RUN apk add --no-cache \
    tini \
    && addgroup -g 1001 -S scopios \
    && adduser -S -D -H -u 1001 -h /var/cache/nginx -s /sbin/nologin -G scopios -g scopios scopios

# Copiar configuración personalizada de Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY nginx-site.conf /etc/nginx/conf.d/default.conf

# Copiar los archivos compilados de la aplicación
COPY dist/ /usr/share/nginx/html/

# Ajustar permisos para usuario no-root
RUN chown -R scopios:scopios /usr/share/nginx/html \
    && chown -R scopios:scopios /var/cache/nginx \
    && chown -R scopios:scopios /var/log/nginx \
    && mkdir -p /tmp/nginx \
    && chown -R scopios:scopios /tmp

# Cambiar a usuario sin privilegios
USER scopios

# Exponer puerto 8080 (no-privilegiado)
EXPOSE 8080

# Healthcheck para verificar que la aplicación está respondiendo
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Usar tini como init system para manejar señales correctamente
ENTRYPOINT ["/sbin/tini", "--"]

# Comando para iniciar Nginx
CMD ["nginx", "-g", "daemon off;"]
