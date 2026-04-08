# ─────────────────────────────────────────────
# ETAPA: desarrollo
# Se usa cuando estamos trabajando en local.
# Permite levantar el server con hot reload.
# ─────────────────────────────────────────────
FROM node:19-alpine3.15 AS development
WORKDIR /usr/src/app

COPY package.json ./
RUN yarn install

CMD ["yarn","start:dev"]


# ─────────────────────────────────────────────
# ETAPA: dependencias completas
# Instala todas las dependencias respetando el lockfile.
# Sirve como base para compilar luego.
# ─────────────────────────────────────────────
FROM node:19-alpine3.15 AS dependencies
WORKDIR /usr/src/app

COPY package.json ./
RUN yarn install --frozen-lockfile


# ─────────────────────────────────────────────
# ETAPA: build
# Aquí se compila el proyecto (TS → JS)
# ─────────────────────────────────────────────
FROM node:19-alpine3.15 AS build
WORKDIR /usr/src/app

COPY --from=dependencies /usr/src/app/node_modules ./node_modules
COPY . .

RUN yarn build


# ─────────────────────────────────────────────
# ETAPA: dependencias prod
# Solo instala lo necesario para producción
# ─────────────────────────────────────────────
FROM node:19-alpine3.15 AS prod-dependencies
WORKDIR /usr/src/app

COPY package.json ./
RUN yarn install --prod --frozen-lockfile


# ─────────────────────────────────────────────
# ETAPA FINAL: producción
# Imagen optimizada con lo mínimo necesario
# ─────────────────────────────────────────────
FROM node:19-alpine3.15 AS production
WORKDIR /usr/src/app
EXPOSE 3000

ENV APP_VERSION=${APP_VERSION}

COPY --from=prod-dependencies /usr/src/app/node_modules ./node_modules
COPY --from=build /usr/src/app/dist ./dist

CMD ["node","dist/main.js"]