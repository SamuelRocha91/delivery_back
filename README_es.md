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

### Conceptos y Gems Utilizados

Este proyecto aborda y utiliza los siguientes conceptos y gems:

- **Procesos en segundo plano**: Uso de **Sidekiq** para el procesamiento asíncrono de tareas. **Redis** se utiliza como cola para estas tareas, asegurando que las operaciones de larga duración, como el envío de correos electrónicos o el procesamiento de datos, se gestionen fuera del ciclo principal de la aplicación, mejorando el rendimiento y la experiencia del usuario.

- **Paginación**: Implementación de paginación para listar recursos utilizando la gem **Kaminari**, lo que facilita el manejo de grandes volúmenes de datos y permite dividir listas en páginas, mejorando la usabilidad y navegación de la aplicación.

- **Pruebas con RSpec y Shoulda Matchers**: Uso de **RSpec** para escribir pruebas unitarias, de integración y funcionales. La gem **Shoulda Matchers** simplifica las afirmaciones, especialmente cuando se prueban las validaciones y asociaciones de ActiveRecord, permitiendo una sintaxis de pruebas más legible y eficiente.

- **Cobertura de pruebas con SimpleCov**: Integración con la gem **SimpleCov** para realizar análisis automatizados de cobertura de código. Esto asegura que las áreas críticas de la aplicación estén cubiertas por pruebas, proporcionando informes claros sobre qué partes del código necesitan aún ser cubiertas.

- **Eliminación suave con Discard**: Implementación de eliminación suave utilizando la gem **Discard**, lo que permite "eliminar" registros sin quitarlos físicamente de la base de datos. Esto posibilita la futura recuperación de datos y mantiene la integridad histórica.

- **Bullet para la detección de consultas N+1**: La gem **Bullet** se utiliza para detectar y prevenir problemas de rendimiento como las **consultas N+1**. Bullet alerta al desarrollador cuando una consulta puede optimizarse, sugiriendo el uso de **carga ansiosa** (eager loading) para evitar múltiples consultas innecesarias a la base de datos, mejorando así la eficiencia de la aplicación.

- **Anonimización de datos**: Aplicación de técnicas para anonimizar datos sensibles, garantizando el cumplimiento de las normativas de privacidad y seguridad, como la **LGPD** (Ley General de Protección de Datos). Se implementan técnicas como el enmascaramiento y hashing para proteger la información personal.

- **API RESTful**: Desarrollo de una **API RESTful** que sigue principios de arquitectura de software, permitiendo una comunicación eficiente entre el backend y el frontend. La API está diseñada para ser escalable, modular y fácil de mantener.

- **Swagger**: Documentación automática de la API usando la gem **Rswag** (basada en Swagger), que facilita la comprensión y uso de la API proporcionando una interfaz interactiva para probar rutas, endpoints, parámetros y respuestas directamente en el navegador.

- **Docker**: Opción para la contenerización utilizando **Docker**, lo que simplifica el desarrollo, pruebas y despliegue de la aplicación en entornos controlados. Esto asegura que las dependencias y la infraestructura estén aisladas y puedan replicarse fácilmente en diferentes máquinas.

- **Procesamiento de imágenes**: Uso de la gem **ImageProcessing** para la manipulación de imágenes, como el redimensionamiento y la compresión. Herramientas como **ruby-vips** se utilizan para optimizar el procesamiento de imágenes a gran escala, asegurando un alto rendimiento.

- **WebSockets y SSE**: Implementación de comunicación en tiempo real utilizando **WebSockets** para características que requieren interactividad inmediata, como chats, notificaciones o actualizaciones en vivo. **Server-Sent Events (SSE)** también se usa para actualizaciones unidireccionales del servidor al cliente.

- **Cálculo de distancia**: Uso de la gem **Geocoder** para calcular distancias entre el cliente y el establecimiento comercial, facilitando servicios basados en la ubicación. Los cálculos de distancia se realizan en kilómetros, asegurando precisión y eficiencia.

- **Hilos**: Uso de **hilos** (threads) para mejorar la concurrencia y el rendimiento en operaciones paralelas, como el procesamiento de grandes cantidades de datos o la integración con servicios externos. Los hilos permiten que múltiples operaciones se ejecuten simultáneamente, optimizando el tiempo de respuesta de la aplicación.

- **Gestión de sesiones y autenticación**: La autenticación de usuarios se gestiona con **Devise**, una gem muy utilizada en el ecosistema de Rails. También se proporciona soporte para autenticación con **JWT** (JSON Web Token), especialmente útil para la autenticación basada en tokens en una API.

- **Control de CORS**: Uso de la gem **rack-cors** para gestionar los permisos de **Cross-Origin Resource Sharing (CORS)**, garantizando que la API pueda ser accedida de forma segura desde diferentes dominios.

- **Máquinas de estado con State Machines-Activerecord**: Uso de la gem **state_machines-activerecord** para implementar **máquinas de estado** en los modelos de ActiveRecord. Esto permite un control detallado sobre las transiciones de estado, asegurando que ciertos procesos u objetos sigan flujos predefinidos, como cambios en los estados de pedidos, pagos o procesos automatizados.

- **Faraday para consumo de API externas**: Integración con servicios externos utilizando la gem **Faraday**, una librería de cliente HTTP que permite realizar solicitudes HTTP/REST de forma flexible y eficiente. Esto facilita la comunicación con APIs de terceros, ofreciendo soporte para middleware, reintentos y manejo de errores.

- **Automatización de tareas y DevOps**: La estructura de **DevOps** está respaldada por herramientas como **Sidekiq** y **Docker** para automatizar la integración continua, el despliegue y la monitorización de tareas en segundo plano.

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
