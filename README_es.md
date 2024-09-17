# Aplicación de Delivery

<h2>🌐</h2>
<ul>
  <li><a href="https://github.com/SamuelRocha91/delivery_back" target="_blank">Português</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md" target="_blank">Español</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md" target="_blank">English</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md" target="_blank">Русский</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md" target="_blank">中文</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md" target="_blank">العربية</a></li>
</ul>

Este repositorio representa el backend en Rails para una aplicación de delivery, incluyendo una interfaz de gestión de datos para usuarios con los roles de admin y developer.

![Ilustración de uso de la interfaz del admin](./assets/admin.gif)

## Repositorios Relacionados

- [Aplicación Consumidor](https://github.com/SamuelRocha91/consumy) - Aplicación para el consumidor
- [Aplicación Vendedor](https://github.com/SamuelRocha91/seller_application) - Aplicación para el vendedor
- [API Paymenty](https://github.com/SamuelRocha91/paymenty) - API de pagos

### Conceptos y Gems Utilizadas

Este proyecto aborda y utiliza los siguientes conceptos y gems:

- **Procesos en Segundo Plano:** Uso de Sidekiq para el procesamiento asíncrono de tareas (junto con Redis).
- **Paginación:** Implementación de paginación para la lista de recursos (kaminari).
- **Pruebas con RSpec y Shoulda Matchers:** Pruebas unitarias e integrales usando RSpec con Shoulda Matchers para simplificar las aserciones.
- **Cobertura de Pruebas con SimpleCov:** Análisis de cobertura de código automatizado con SimpleCov.
- **Eliminación Suave con Discard:** Implementación de eliminación suave (soft delete) utilizando la gem Discard para mantener registros en la base de datos sin eliminarlos físicamente.
- **Anonimización de Datos:** Aplicación de técnicas para la anonimización de datos sensibles.
- **API RESTful:** Desarrollo de una API RESTful para la comunicación entre el backend y el frontend.
- **Swagger:** Documentación automática de la API con Swagger para facilitar su comprensión y uso.
- **Docker:** Opción de contenedorización con Docker para facilitar el desarrollo y despliegue de la aplicación.
- **Manipulación de Imágenes:** Manipulación de imágenes con herramientas específicas para el procesamiento de medios.
- **WebSockets y SSE:** Implementación de comunicación en tiempo real utilizando WebSockets y Server-Sent Events (SSE) para funcionalidades como chat o actualizaciones en tiempo real.
- **Cálculo de Distancia:** Uso de la gem geocoder para implementar el cálculo de distancia en km desde el establecimiento comercial hasta la residencia del cliente.
- **Threads:** Uso de threads para mejorar la concurrencia y el rendimiento en operaciones paralelas.

## Configuración del Proyecto

### Con Docker

Para ejecutar este proyecto utilizando Docker, sigue los pasos a continuación:

#### Requisitos Previos

Asegúrate de tener Docker y Docker Compose instalados en tu máquina.

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Configuración

1. Clona los repositorios relacionados:

   ```sh
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. Descarga el archivo `docker-compose.yml` para configurar los servicios Docker necesarios y colócalo en la carpeta raíz donde se clonaron los repositorios:

   - [Descargar docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. En la raíz del proyecto, donde está ubicado el archivo `docker-compose.yml`, ejecuta el siguiente comando para construir e iniciar los servicios:

   ```sh
   docker-compose up --build
   ```

4. Al acceder a la aplicación backend en el navegador, haz clic en "RUN PENDING MIGRATES" para generar las migraciones.

5. Se recomienda ingresar al contenedor de la aplicación backend y ejecutar las seeds:

   ```sh
   docker exec -it nombreDelContenedorBackEnd /bin/sh 
   rails db:seed
   ```

6. Es necesario configurar las variables de entorno en un archivo .env dentro de la aplicación delivery_back. Ejemplo:

   ```sh
   JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```

7. Es necesario configurar las variables de entorno en un archivo .env.development dentro de las aplicaciones consumy y seller. Ejemplo:

   ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**OBS** Las api_keys pueden generarse dentro del contenedor backend a través de la consola y luego pegarse en el archivo .env.

**OBS** Otra forma es generarlas a través de un usuario con el rol de developer dentro de la interfaz del backend y copiar y pegar en la aplicación correspondiente.

**OBS** No olvides reiniciar los contenedores para que las variables se carguen.

![Ejemplo de configuración](./assets/apikey.gif)

### Sin Docker

Para configurar y ejecutar el proyecto localmente sin Docker, sigue los pasos a continuación:

#### Requisitos Previos

Asegúrate de tener Redis y Sidekiq configurados y en funcionamiento localmente para el correcto funcionamiento de la aplicación. Además, instala las dependencias necesarias de R:

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### Instalación de Dependencias

```sh
bundle install
```

#### Configurar la Base de Datos

Crea la base de datos y ejecuta las migraciones:

```sh
rails db:create
rails db:migrate
```

#### Iniciar el Servidor Local

Para iniciar el servidor localmente:

```sh
rails server
```

#### Ejecutar Pruebas

Para ejecutar las pruebas automatizadas:

```sh
bundle exec rspec
```

#### Iniciar Redis y Sidekiq

Asegúrate de que Redis esté instalado y funcionando. Inicia Redis con el siguiente comando:

```sh
redis-server
```

Luego, inicia Sidekiq:

```sh
bundle exec sidekiq
```

---

Este proyecto fue creado como requisito evaluativo para el programa Quero Ser Dev 9ª edición de LWSA.

---