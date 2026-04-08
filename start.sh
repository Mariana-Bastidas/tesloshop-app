#!/bin/bash

# Script para levantar TesloShop
echo "Iniciando TesloShop..."
echo ""

# Verificamos si Docker está activo
# (si no, este comando falla y no deja continuar)
if ! docker info > /dev/null 2>&1; then
    echo "Error: Docker no está corriendo. Inicia Docker Desktop porfa."
    exit 1
fi

echo "Docker está corriendo 👍"
echo ""

# Construye las imágenes (por si hubo cambios)
# y levanta todos los servicios en segundo plano
echo "Construyendo e iniciando contenedores..."
docker-compose up --build -d

echo ""
echo "Esperando un momentico a que todo cargue..."
sleep 10

echo ""
echo "TesloShop ya está arriba 🚀"
echo ""
echo "Puedes entrar aquí:"
echo "   Frontend:    http://localhost"
echo "   Backend API: http://localhost:3000/api"
echo "   Base de datos: localhost:5432"
echo ""
echo "Para ver logs:"
echo "   docker-compose logs -f"
echo ""
echo "Para detener todo:"
echo "   docker-compose down"
echo ""