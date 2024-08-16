#!/bin/bash

# Nombre del proyecto
PROJECT_NAME=$1

# Verificar si se proporcionó un nombre de proyecto
if [ -z "$PROJECT_NAME" ]; then
  echo "Por favor, proporciona un nombre para el proyecto."
  echo "Uso: ./create-react-app-with-tailwind.sh nombre-del-proyecto"
  exit 1
fi

# Crear el proyecto de React con TypeScript
echo "Creando proyecto React con TypeScript..."
npx create-react-app $PROJECT_NAME --template typescript

# Navegar al directorio del proyecto
cd $PROJECT_NAME || exit

# Instalar TailwindCSS y las dependencias necesarias
echo "Instalando TailwindCSS..."
npm install tailwindcss postcss autoprefixer

# Inicializar TailwindCSS
echo "Inicializando TailwindCSS..."
npx tailwindcss init -p

# Configurar TailwindCSS para que escanee los archivos en src/
echo "Configurando TailwindCSS..."
cat > tailwind.config.js <<EOL
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Agregar las directivas de TailwindCSS al archivo src/index.css
echo "Configurando estilos en src/index.css..."
cat > src/index.css <<EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Ejecutar el proyecto
echo "¡Configuración completa! Ejecutando el proyecto..."
npm start
