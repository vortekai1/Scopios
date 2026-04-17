# Scopios Medical - Despliegue en Producción

Aplicación de gestión de servicios médicos.

## Tecnologías

- **Frontend**: React 19 + TypeScript 6 + Vite 8
- **Backend**: Supabase (PostgreSQL + Auth + Storage)
- **Servidor**: Nginx en Docker
- **Deploy**: EasyPanel

## Despliegue en EasyPanel

1. **Crear nuevo proyecto** en EasyPanel
2. **Conectar repositorio** de GitHub
3. **Configurar servicio**:
   - Type: App
   - Source: Dockerfile
   - Dockerfile path: `./Dockerfile`
   - Port: `8080`
4. **Configurar dominio**: `scopios.vortekai.es`
5. **Deploy**: EasyPanel construirá y desplegará automáticamente

## Variables de Entorno

No se requieren variables de entorno. La configuración de Supabase está compilada en el bundle.

## Healthcheck

El contenedor incluye un healthcheck automático que verifica la disponibilidad cada 30 segundos.

## Seguridad

- ✅ Usuario sin privilegios (scopios:1001)
- ✅ Puerto no-privilegiado (8080)
- ✅ Headers de seguridad configurados
- ✅ CSP (Content Security Policy)
- ✅ Nginx actualizado (Alpine Linux)
- ✅ Sin información sensible en el código

## Soporte

Para soporte técnico, contactar al equipo técnico.
