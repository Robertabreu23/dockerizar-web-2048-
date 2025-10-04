# Dockerizar Web 2048

Práctica de dockerización del juego 2048 usando Docker, Nginx y Ubuntu.

Robert Abreu 23-0121
Se instaló Docker Desktop para Windows desde el sitio oficial, seleccionando WSL 2 como backend durante la instalación. Tras reiniciar el sistema, se verificó la instalación abriendo PowerShell y ejecutando:
powershelldocker --version
docker compose version
Se instaló Visual Studio Code y se agregaron las extensiones "Docker" de Microsoft y "YAML" de Red Hat para trabajar con archivos Docker.
Se crearon las cuentas necesarias:

Docker Hub con usuario robertabreu23
Token de acceso en Docker Hub: dckr_pat_UI5AqWA9Yo0QRZaZJtFB84WIoEE
GitHub con usuario Robertabreu23
Render vinculada a la cuenta de GitHub


4.2 Creación del Proyecto
Se creó la carpeta dockerizar-web-2048 en el directorio de Documentos. Se abrió con VS Code haciendo click derecho y seleccionando "Open with Code". En VS Code se abrió la terminal integrada con Ctrl + acento grave.

4.3 Creación del Dockerfile
Se creó un archivo llamado Dockerfile con el siguiente contenido:
dockerfileFROM ubuntu:latest
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y nginx git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /var/www/html/* && \
    git clone https://github.com/josejuansanchez/2048.git /var/www/html && \
    rm -rf /var/www/html/.git

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
Este Dockerfile cumple los 5 requisitos:

Usa Ubuntu latest como imagen base
Instala git y nginx
Clona el repositorio en /var/www/html/
Expone el puerto 80
Ejecuta nginx en primer plano con el CMD especificado


4.4 Creación del docker-compose.yml
Se creó el archivo docker-compose.yml:
yamlversion: '3.8'

services:
  web:
    build: .
    container_name: web-2048
    ports:
      - "80:80"
    restart: unless-stopped
Este archivo facilita el despliegue del contenedor mapeando el puerto 80 del host al puerto 80 del contenedor.

4.5 Construcción de la Imagen Docker
En la terminal de VS Code se ejecutó:
powershelldocker build -t nginx-2048 .
El proceso tardó aproximadamente 3-5 minutos e incluyó:

Descarga de la imagen base Ubuntu (77.8MB)
Instalación de Nginx y Git
Clonación del repositorio del juego 2048
Creación de las capas de la imagen

Se verificó la imagen creada con:
powershelldocker images
La imagen nginx-2048 apareció con un tamaño aproximado de 245MB.

4.6 Prueba Local
Se ejecutó un contenedor de prueba:
powershelldocker run -d -p 8080:80 --name test-2048 nginx-2048
Se verificó el contenedor corriendo:
powershelldocker ps
Se abrió el navegador y se accedió a http://localhost:8080. El juego 2048 cargó correctamente mostrando la interfaz completa con dos fichas iniciales de valor 2, el marcador en 0 y todas las funcionalidades operativas.
Tras verificar el funcionamiento, se detuvo y eliminó el contenedor de prueba:
powershelldocker stop test-2048
docker rm test-2048

4.7 Publicación en Docker Hub
Docker Desktop mantenía la sesión iniciada, por lo que no fue necesario autenticarse nuevamente.
Se etiquetó la imagen con el nombre de usuario de Docker Hub:
powershelldocker tag nginx-2048 robertabreu23/nginx-2048:1.0
docker tag nginx-2048 robertabreu23/nginx-2048:latest
Se verificaron las etiquetas:
powershelldocker images | Select-String "nginx-2048"
Se publicaron ambas versiones en Docker Hub:
powershelldocker push robertabreu23/nginx-2048:1.0
docker push robertabreu23/nginx-2048:latest
El proceso de subida tardó 3-5 minutos. La imagen quedó disponible públicamente en Docker Hub en el repositorio robertabreu23/nginx-2048 con los tags 1.0 y latest.

4.8 Versionado en GitHub
Se creó un repositorio público en GitHub llamado dockerizar-web-2048- desde la interfaz web.
Se creó un archivo README.md en VS Code con la siguiente información:
markdown# Dockerizar Web 2048

Práctica de dockerización del juego 2048 usando Docker, Nginx y Ubuntu.

## Docker Hub
Imagen disponible en: robertabreu23/nginx-2048

## Render
Aplicación desplegada en: dockerizar-web-2048.onrender.com

## Uso Local

Construir la imagen:
docker build -t nginx-2048 .

Ejecutar localmente:
docker run -d -p 8080:80 nginx-2048

Usar Docker Compose:
docker compose up -d

## Autor
Roberto Abreu
Los archivos se subieron manualmente a GitHub:

Se accedió al repositorio en GitHub
Se seleccionó "uploading an existing file"
Se arrastraron los tres archivos: Dockerfile, docker-compose.yml y README.md
Se realizó el commit con el mensaje "Initial commit: Dockerized 2048 game"

Los archivos quedaron disponibles en el repositorio público.

4.9 Despliegue en Render
Se accedió al dashboard de Render e inició sesión con la cuenta de GitHub.
Se creó un nuevo Web Service haciendo click en "New +" y seleccionando "Web Service".
Se eligió la opción "Deploy an existing image from a registry" y se hizo click en "Next".
Se configuró la imagen Docker:

Image URL: docker.io/robertabreu23/nginx-2048:latest

Se configuró el servicio:

Name: dockerizar-web-2048
Region: Oregon (US West)
Instance Type: Free

No fue necesario configurar el puerto manualmente ya que Render lo detectó automáticamente desde el Dockerfile.
Se hizo click en "Create Web Service" para iniciar el despliegue.
El proceso de despliegue tomó aproximadamente 4 minutos:

10:43:31 AM: Inicio del proceso, descarga de imagen desde Docker Hub
10:43:42 AM: Imagen descargada y verificada exitosamente
10:44:33 AM: Detección automática del puerto 80
10:44:45 AM: Servicio en estado Live

El servicio quedó accesible en: https://dockerizar-web-2048.onrender.com
Se verificó el funcionamiento abriendo la URL en el navegador. El juego 2048 cargó correctamente con todas sus funcionalidades operativas, confirmando un despliegue exitoso en producción.

4.10 Resumen del Flujo Completo
El proyecto se completó siguiendo este flujo:

Instalación y configuración de Docker Desktop y VS Code
Creación de cuentas en Docker Hub, GitHub y Render
Desarrollo del Dockerfile cumpliendo los 5 requisitos especificados
Construcción de la imagen Docker localmente
Pruebas locales exitosas en localhost:8080
Etiquetado y publicación de la imagen en Docker Hub con tags 1.0 y latest
Versionado del código en repositorio público de GitHub
Despliegue en Render usando la imagen de Docker Hub
Verificación del funcionamiento en producción

Tiempo total del proyecto: aproximadamente 1.5 a 2 horas
Resultado final:

Imagen Docker: 245MB, disponible públicamente
Repositorio GitHub: Código fuente documentado
Aplicación en producción: Accesible 24/7 con plan gratuito de Render

## 🐳 Docker Hub
https://hub.docker.com/r/robertabreu23/nginx-2048

## 🚀 Render
https://dockerizar-web-2048.onrender.com/




### Construir la imagen
```bash

docker build -t nginx-2048 .

