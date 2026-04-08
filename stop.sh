#!/bin/bash

# Script para bajar TesloShop
echo "Deteniendo TesloShop..."
docker-compose down

echo ""
echo "TesloShop detenido 👍"
echo ""
echo "Si quieres borrar también la data:"
echo "   docker-compose down -v"
echo ""