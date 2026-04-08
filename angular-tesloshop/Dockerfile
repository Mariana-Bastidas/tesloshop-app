# ─────────────────────────────────────────────
# ETAPA 1: compilación
# Se encarga de construir la app Angular
# ─────────────────────────────────────────────
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

# Copiamos dependencias primero para aprovechar cache
COPY package*.json ./

# Instalación limpia basada en package-lock
RUN npm ci

# Ahora sí copiamos todo el código
COPY . .

# Build para producción
RUN npm run build


# ─────────────────────────────────────────────
# ETAPA 2: servidor
# Usa Nginx para servir los archivos estáticos
# ─────────────────────────────────────────────
FROM nginx:alpine

# Copiamos el resultado del build
COPY --from=builder /usr/src/app/dist/teslo-shop/browser /usr/share/nginx/html

# Config personalizada de nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx","-g","daemon off;"]