# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> Delivery Application  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 Languages
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

This repository represents the Rails backend for a delivery application, including a data management interface for users with admin and developer roles.

![Illustration of admin interface usage](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 Related Repositories</strong></summary>

  - 🛒 [Consumy Application](https://github.com/SamuelRocha91/consumy/blob/main/README_en.md) - Consumer application
  - 👨‍💼 [Seller Application](https://github.com/SamuelRocha91/seller_application/blob/main/README_en.md) - Seller application
  - 💲 [Paymenty API](https://github.com/SamuelRocha91/paymenty/blob/main/README_en.md) - Payment API

</details>

---

## <h2>📚 Concepts and Gems Used</h2>

<details>
  <summary><strong>🔍 Click to expand the details of the Gems and Concepts</strong></summary>

- **Background Processing**: Utilization of **Sidekiq** for asynchronous task processing. **Redis** is used as a storage queue for these tasks.
  
- **Pagination**: Implementation of pagination for resource listing using the **Kaminari** gem.

- **Testing with RSpec and Shoulda Matchers**: Utilization of **RSpec** to write unit, integration, and functional tests. 

- **Test Coverage with SimpleCov**: Integration with the **SimpleCov** gem for code coverage analysis.

- **Soft Delete with Discard**: Implementation of soft delete using the **Discard** gem.

- **Bullet for N+1 Queries Detection**: The **Bullet** gem is used to detect and prevent performance issues such as **N+1 queries**.

- **Data Anonymization**: Application of techniques to anonymize sensitive data, ensuring compliance with privacy and security regulations, such as the **LGPD**.

- **RESTful API**: Development of a **RESTful** API that follows software architecture principles to allow efficient communication between the backend and frontend.

- **Swagger**: Automatic documentation of the API using the **Rswag** gem (based on Swagger).

- **Docker**: Containerization option using **Docker** to facilitate development, testing, and deployment.

- **Image Manipulation**: Utilization of the **ImageProcessing** gem for image manipulation, such as resizing and compression.

- **WebSockets and SSE**: Implementation of real-time communication using **WebSockets**.

- **Distance Calculation**: Utilization of the **Geocoder** gem to implement distance calculation between the customer and the commercial establishment.

- **Threads**: Use of **threads** to improve concurrency and performance of the application in parallel operations.

- **Session Management and Authentication**: Implementation of user authentication with **Devise** and authentication via **JWT**.

- **CORS Control**: Utilization of the **rack-cors** gem to manage **CORS** permissions.

- **State Machines with State Machines**: Utilization of the **state_machines-activerecord** gem to implement **state machines** in ActiveRecord models.

- **Faraday for Consuming External APIs**: Integration with external services using the **Faraday** gem.

- **Task Automation and DevOps**: **DevOps** structure is supported by tools like **Sidekiq** and **Docker**.

</details>

---

## <h2>⚙️ Project Setup</h2>

<details>
  <summary><strong>🛠️ With Docker</strong></summary>

  ### Prerequisites

  - Make sure you have Docker and Docker Compose installed on your machine.
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### Setup

  1. Clone the related repositories:

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. Download the `docker-compose.yml` file:

     - [Download docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. In the root of the project, run the following command:

     ```sh
     docker-compose up --build
     ```

  4. Click on "RUN PENDING MIGRATES" in the backend application.

  5. Enter the backend container and run the seeds:

     ```sh
     docker exec -it backendContainerName /bin/sh 
     rails db:seed
     ```

  6. Configure the environment variables:

     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. Restart the containers for the variables to be loaded.

</details>

<details>
  <summary><strong>🛠️ Without Docker</strong></summary>

  ### Prerequisites

  - Make sure you have Redis and Sidekiq configured and running locally.
  
  - Install the R dependencies:

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### Install Dependencies

  ```sh
  bundle install
  ```

  ### Configure the Database

  Create the database and run migrations:

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### Start the Local Server

  ```sh
  rails server
  ```

  ### Run Tests

  ```sh
  bundle exec rspec
  ```

  ### Start Redis and Sidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 Other Projects</strong></summary>

  - 📏 [React Precision Application](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_en.md) - Registration interface for gas and water measurements
  - 🤖 [Node API](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_en.md) - API for measuring and registering consumption
</details>