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
git clone https://github.com/Mariana-Bastidas/tesloshop-app.git
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
  
     <img width="834" height="1028" alt="Captura de pantalla 2026-04-08 164513" src="https://github.com/user-attachments/assets/d8a304f2-0830-40f7-b51a-b3d47c39f74a" />


  2. Dockerfile del Frontend
     
     <img width="917" height="717" alt="Captura de pantalla 2026-04-08 165245" src="https://github.com/user-attachments/assets/cd49551a-8c53-4420-bc3d-e6f87b16bf3e" />


   3. Creacion del Nginx.config del Frontend
      
      <img width="865" height="1029" alt="Captura de pantalla 2026-04-08 165352" src="https://github.com/user-attachments/assets/c5d0f4f6-67a9-4c85-97f4-bb64dd316961" />
      

   4. Configuracion del .env.example y modificiacion del .env
      
      <img width="883" height="719" alt="Captura de pantalla 2026-04-08 165540" src="https://github.com/user-attachments/assets/129dcab7-0d2c-4e18-8ff8-360ed8bb6349" />
      
      <img width="876" height="634" alt="Captura de pantalla 2026-04-08 165631" src="https://github.com/user-attachments/assets/cdbe36c6-9f8c-4e87-95f0-6d3ddaeeccc1" />

   5. Configuracion del start.sh
      
      <img width="874" height="758" alt="Captura de pantalla 2026-04-08 165721" src="https://github.com/user-attachments/assets/294530c9-c56a-414c-b62e-12fd652ef0ad" />
   

   6. Construyendo las imágenes
      
      <img width="1193" height="801" alt="Captura de pantalla 2026-04-08 165825" src="https://github.com/user-attachments/assets/d8f87783-4b7c-4c80-90e9-d295c8408c59" />


  7. imágenes creadas

   <img width="610" height="139" alt="Captura de pantalla 2026-04-08 165935" src="https://github.com/user-attachments/assets/eaa2430e-393a-480b-8f54-aebd9905852b" />


   8. Configuracion del Stop.sh
      
      <img width="795" height="338" alt="Captura de pantalla 2026-04-08 170014" src="https://github.com/user-attachments/assets/f69b5e31-039d-4a61-a400-05229ba67a5c" />


   9. Version del docker y version del docker compose
      
      <img width="650" height="85" alt="Captura de pantalla 2026-04-08 170336" src="https://github.com/user-attachments/assets/d5c38ea0-5da1-444f-b22a-7fb4bb2631ae" />


   10. Permisos a los Scripts
       
       <img width="669" height="44" alt="Captura de pantalla 2026-04-08 170538" src="https://github.com/user-attachments/assets/06cf62ba-e163-4954-a3c2-d69e4630d077" />


   11. Docker-compose.yml terminado
       
       <img width="844" height="1059" alt="Captura de pantalla 2026-04-08 170626" src="https://github.com/user-attachments/assets/4be99ce3-4343-4880-9382-7133705b151b" />



  12. Lanzar la aplicacion
      
      <img width="1512" height="588" alt="Captura de pantalla 2026-04-08 171028" src="https://github.com/user-attachments/assets/a7c24450-47bf-44b7-a6d9-6c4577f20ab1" />

 
  13. aplicación funcionando
      
      <img width="1524" height="353" alt="Captura de pantalla 2026-04-08 171117" src="https://github.com/user-attachments/assets/c1740eb1-68c8-43e0-9cf5-306bdf02bd0c" />


  14. Verificacion de que servicios estan corriendo
      
      <img width="1039" height="98" alt="Captura de pantalla 2026-04-08 171211" src="https://github.com/user-attachments/assets/6d34c506-4f1d-4e1d-bd26-c272830dd648" />


  15. Poblar la base de datos con el Seed
      
      <img width="997" height="99" alt="Captura de pantalla 2026-04-08 171239" src="https://github.com/user-attachments/assets/333c6455-b9c4-4c78-9dcf-8920a5c3fa80" />


  16. Vista de la app desde la API
      
      <img width="1352" height="1077" alt="Captura de pantalla 2026-04-08 171328" src="https://github.com/user-attachments/assets/5c528822-9301-42c6-8746-fade43fb5530" />

  17. Vista de la app desde el Frontend
      
      <img width="1728" height="1152" alt="Captura de pantalla 2026-04-08 171513" src="https://github.com/user-attachments/assets/8434fec6-9de8-44d8-8a3d-f73cd6726c46" />
