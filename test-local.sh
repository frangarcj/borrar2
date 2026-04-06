#!/bin/bash

# Este script simula la ejecución del GitHub Action en local usando Docker.
# Solo ejecuta los pasos de construcción y test, excluyendo el despliegue SSH.

PROJECT_DIR=$(pwd)
IMAGE="node:20-alpine"

echo "🚀 Iniciando prueba local con Docker (Imagen: $IMAGE)..."

docker run --rm \
  -v "$PROJECT_DIR":/app \
  -w /app \
  $IMAGE \
  sh -c "npm install && npm run test-jenkins"

if [ $? -eq 0 ]; then
  echo "✅ Los tests han pasado correctamente."
  echo "📂 Los resultados están en ./coverage/test.results.xml"
else
  echo "❌ Los tests han fallado."
  exit 1
fi
