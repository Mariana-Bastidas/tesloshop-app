# tesloshop-app

## Descripción del proyecto

TesloShop es una aplicación web completa (full-stack) que integra frontend, backend y base de datos. Todo el sistema está contenerizado con Docker y gestionado mediante Docker Compose, lo que permite ejecutar toda la aplicación con un solo comando, facilitando su despliegue, portabilidad y escalabilidad.

La solución está conformada por:

- Frontend (Angular + Nginx)
- Backend (NestJS)
- Base de datos (PostgreSQL)
- Orquestación con Docker Compose
- Red interna de Docker
- Volúmenes para persistencia de datos

---

## 1. Arquitectura

### Estructura general del sistema

El sistema se compone de tres capas principales:

1. **Frontend:** Aplicación desarrollada en Angular y servida mediante Nginx.
2. **Backend:** API REST implementada con NestJS.
3. **Base de datos:** PostgreSQL para almacenamiento persistente.
4. **Docker Compose:** Encargado de coordinar contenedores, red y volúmenes.

### Flujo de funcionamiento

El comportamiento del sistema es el siguiente:

1. El usuario accede a la aplicación desde el navegador.
2. El frontend es servido por Nginx.
3. Nginx redirige las solicitudes `/api` hacia el backend.
4. El backend procesa la lógica de negocio.
5. El backend se comunica con PostgreSQL para consultar o guardar datos.
6. PostgreSQL responde con la información solicitada.
7. El backend envía la respuesta al frontend.
8. El frontend muestra los datos al usuario.

### Comunicación entre contenedores

Los servicios se comunican mediante una red interna de Docker llamada:

**teslo-network**

Dentro del entorno Docker:

- El backend se conecta a la base de datos usando el host `db`.
- El frontend se comunica con el backend usando el host `backend`.

**Nota:** Dentro de Docker no se utiliza `localhost` para conectar servicios.

---

## 2. Pasos de ejecución

A continuación, se describen los pasos necesarios para ejecutar el proyecto:

### 2.1 Clonar el repositorio

```bash
git clone https://github.com/DEV-SENA-TRAINING/tesloshop-app.git
cd tesloshop-app
```

### 2.2 Crear archivo de variables de entorno

```bash
cp .env.example .env
```

Luego, editar el archivo .env y definir:

- POSTGRES_PASSWORD
- DB_PASSWORD
- JWT_SECRET

Estas credenciales deben coincidir entre el backend y la base de datos.

### 2.3 Dar permisos a los scripts

```bash
chmod +x start.sh stop.sh
```

### 2.4 Iniciar la aplicación

```bash
./start.sh
```

O manualmente:

```bash
docker compose up --build -d
```

Este comando realiza:

- Construcción de imágenes Docker
- Creación de red interna
- Creación de volúmenes
- Inicio de contenedores

Arranque de base de datos, backend y frontend

### 2.5 Verificar contenedores

```bash
docker compose ps
```

### 2.6 Acceso a la aplicación

Una vez ejecutado el sistema:

* Frontend: http://localhost:8080
* Backend: http://localhost:3000
* Base de datos: localhost:5432

### 2.7 Ejecutar el seed de la base de datos

Desde navegador:

```bash
http://localhost:3000/api/seed
```

O desde terminal:

 ```bash
curl http://localhost:3000/api/seed
```

### 2.8 Detener la aplicación

```bash
./stop.sh
```

O manualmente:

```bash
docker compose down
```

---

## 3. Explicación de servicios

La configuración principal se encuentra en docker-compose.yml.

### 3.1 Servicio db (PostgreSQL)

Este servicio corresponde a la base de datos.

#### Funciones:

Almacenamiento de usuarios, productos y pedidos
Persistencia de datos del sistema

#### Características:

Imagen oficial postgres:14.3
Uso de volumen postgres-data
Healthcheck para validar disponibilidad
Puerto expuesto: 5432

El volumen permite mantener los datos aunque los contenedores se reinicien.

### 3.2 Servicio backend

Implementado con NestJS.

#### Funciones:

API REST
Autenticación con JWT
Gestión de usuarios y productos
Conexión con PostgreSQL
Documentación con Swagger
Seed de base de datos

#### Características:

Construcción mediante Dockerfile (multi-stage)
Conexión a DB usando DB_HOST=db
Puerto expuesto: 3000
Dependencia del servicio db
Uso de volúmenes para desarrollo (hot reload)

### 3.3 Servicio frontend

Interfaz de usuario desarrollada en Angular.

#### Funciones:

Interfaz gráfica
Visualización de productos
Autenticación de usuarios
Comunicación con la API
Servir archivos estáticos con Nginx
Proxy de /api hacia backend

#### Flujo del Dockerfile:

Compila la aplicación Angular
Copia los archivos a Nginx
Nginx sirve en el puerto 8080
Redirección de /api al backend

Esto evita problemas de CORS al manejar todo como un mismo origen.

### 3.4 Redes Docker

Se utiliza la red:

#### teslo-network

Permite comunicación interna entre:

db (PostgreSQL)
backend
frontend
3.5 Volúmenes Docker

Se utiliza:

#### postgres-data

Permite:

Persistir datos
Evitar pérdida de información
Mantener datos aunque se eliminen contenedores

## 4. Tecnologías utilizadas

* Docker
* Docker Compose
* PostgreSQL
* NestJS
* Angular
* Nginx
* Node.js
* TypeScript
* JWT
* Swagger

## 5. Conclusión

Este proyecto implementa una arquitectura moderna basada en contenedores utilizando Docker. Gracias a Docker Compose, es posible ejecutar una aplicación completa con frontend, backend y base de datos de forma sencilla.

La contenerización permite:

* Facilidad de despliegue
* Portabilidad entre entornos
* Escalabilidad
* Reproducibilidad del sistema

## Imagenes

  1. Dockerfile del backend
     
    


  2. Dockerfile del Frontend
     
     


   3. Creacion del Nginx.config del Frontend
      
      


   4. Configuracion del .env.example y modificiacion del .env
      
      


   5. Confguracion del start.sh
      
      
   

   6. Construyendo las imágenes
      
      


  7. imágenes creadas

   


   8. Configuracion del Stop.sh
      
      


   9. Version del docker y version del docker compose
      
      


   10. Permisos a los Scripts
       
       


   11. Docker-compose.yml terminado
       
       


  12. Lanzar la aplicacion
      
      


 
  13. aplicación funcionando
      
      


  14. Verificacion de que servicios estan corriendo
      
      


  15. Poblar la base de datos con el Seed
      
      


  16. Vista de la app desde la API
      
      


  17. Vista de la app desde el Frontend
      
      
