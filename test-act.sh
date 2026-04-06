#!/bin/bash

# Simula la ejecución del Action usando el contenedor oficial de 'act'.
# Este método permite ejecutar el workflow real (.github/workflows/build.yml)
# sin tener 'act' instalado en el host, usando Docker-in-Docker.

PROJECT_DIR=$(pwd)

echo "🚀 Ejecutando 'act' desde un contenedor Docker..."
echo "📦 Usando imagen: nektos/act:latest"

# Montamos:
# 1. El socket de Docker para que act pueda crear contenedores (siblings).
# 2. El directorio actual para que act encuentre el workflow.
mkdir -p "$PROJECT_DIR/artifacts"

docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v "$PROJECT_DIR":/app \
  -w /app \
  nektos/act:latest \
  -W .github/workflows/build.yml \
  --container-architecture linux/amd64 \
  --artifact-server-path /app/artifacts

if [ $? -eq 0 ]; then
  echo "✅ Ejecución de 'act' completada con éxito."
else
  echo "❌ Error al ejecutar 'act'."
  exit 1
fi
