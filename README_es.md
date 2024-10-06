# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> Aplicación de Entrega  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 Idiomas
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

Este repositorio representa el backend en Rails para una aplicación de entrega, incluyendo una interfaz de gestión de datos para usuarios con roles de administrador y desarrollador.

![Ilustración del uso de la interfaz de administrador](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 Repositorios Relacionados</strong></summary>

  - 🛒 [Aplicación Consumy](https://github.com/SamuelRocha91/consumy/blob/main/README_es.md) - Aplicación para consumidores
  - 👨‍💼 [Aplicación Vendedor](https://github.com/SamuelRocha91/seller_application/blob/main/README_es.md) - Aplicación para vendedores
  - 💲 [API Paymenty](https://github.com/SamuelRocha91/paymenty/blob/main/README_es.md) - API de pagos

</details>

---

## <h2>📚 Conceptos y Gems Utilizadas</h2>

<details>
  <summary><strong>🔍 Haz clic para expandir los detalles de las Gems y Conceptos</strong></summary>

- **Procesamiento en segundo plano**: Utilización de **Sidekiq** para el procesamiento de tareas asíncronas. **Redis** se utiliza como cola de almacenamiento para estas tareas.
  
- **Paginación**: Implementación de paginación para el listado de recursos utilizando la gem **Kaminari**.

- **Pruebas con RSpec y Shoulda Matchers**: Utilización de **RSpec** para escribir pruebas unitarias, de integración y funcionales. 

- **Cobertura de Pruebas con SimpleCov**: Integración con la gem **SimpleCov** para el análisis de cobertura de código.

- **Eliminación Suave con Discard**: Implementación de eliminación suave utilizando la gem **Discard**.

- **Bullet para Detección de Consultas N+1**: La gem **Bullet** se utiliza para detectar y prevenir problemas de rendimiento, como consultas **N+1**.

- **Anonymización de Datos**: Aplicación de técnicas para anonimizar datos sensibles, asegurando el cumplimiento de regulaciones de privacidad y seguridad, como la **LGPD**.

- **API RESTful**: Desarrollo de una API **RESTful** que sigue principios de arquitectura de software para permitir una comunicación eficiente entre el backend y el frontend.

- **Swagger**: Documentación automática de la API utilizando la gem **Rswag** (basada en Swagger).

- **Docker**: Opción de contenedorización utilizando **Docker** para facilitar el desarrollo, las pruebas y el despliegue.

- **Manipulación de Imágenes**: Utilización de la gem **ImageProcessing** para la manipulación de imágenes, como el redimensionamiento y la compresión.

- **WebSockets y SSE**: Implementación de comunicación en tiempo real utilizando **WebSockets**.

- **Cálculo de Distancias**: Utilización de la gem **Geocoder** para implementar el cálculo de distancias entre el cliente y el establecimiento comercial.

- **Hilos**: Uso de **hilos** para mejorar la concurrencia y el rendimiento de la aplicación en operaciones paralelas.

- **Gestión de Sesiones y Autenticación**: Implementación de autenticación de usuarios con **Devise** y autenticación mediante **JWT**.

- **Control de CORS**: Utilización de la gem **rack-cors** para gestionar permisos de **CORS**.

- **Máquinas de Estados con State Machines**: Utilización de la gem **state_machines-activerecord** para implementar **máquinas de estados** en los modelos de ActiveRecord.

- **Faraday para Consumir APIs Externas**: Integración con servicios externos utilizando la gem **Faraday**.

- **Automatización de Tareas y DevOps**: La estructura de **DevOps** está soportada por herramientas como **Sidekiq** y **Docker**.

</details>

---

## <h2>⚙️ Configuración del Proyecto</h2>

<details>
  <summary><strong>🛠️ Con Docker</strong></summary>

  ### Requisitos Previos

  - Asegúrate de tener Docker y Docker Compose instalados en tu máquina.
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### Configuración

  1. Clona los repositorios relacionados:

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. Descarga el archivo `docker-compose.yml`:

     - [Descargar docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. En la raíz del proyecto, ejecuta el siguiente comando:

     ```sh
     docker-compose up --build
     ```

  4. Haz clic en "RUN PENDING MIGRATES" en la aplicación de backend.

  5. Entra en el contenedor del backend y ejecuta las semillas:

     ```sh
     docker exec -it backendContainerName /bin/sh 
     rails db:seed
     ```

  6. Configura las variables de entorno:

     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. Reinicia los contenedores para que las variables se carguen.

</details>

<details>
  <summary><strong>🛠️ Sin Docker</strong></summary>

  ### Requisitos Previos

  - Asegúrate de tener Redis y Sidekiq configurados y funcionando localmente.
  
  - Instala las dependencias de R:

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### Instala las Dependencias

  ```sh
  bundle install
  ```

  ### Configura la Base de Datos

  Crea la base de datos y ejecuta migraciones:

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### Inicia el Servidor Local

  ```sh
  rails server
  ```

  ### Ejecuta Pruebas

  ```sh
  bundle exec rspec
  ```

  ### Inicia Redis y Sidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 Otros Proyectos</strong></summary>

  - 📏 [Aplicación de Precisión en React](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_es.md) - Interfaz de registro para mediciones de gas y agua
  - 🤖 [API Node](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_es.md) - API para medir y registrar consumo
</details>
