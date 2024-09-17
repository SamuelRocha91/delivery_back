# Delivery Application

<h2>🌐</h2>
<ul>
  <li><a href="https://github.com/SamuelRocha91/delivery_back" target="_blank">Português</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md" target="_blank">Español</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md" target="_blank">English</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md" target="_blank">Русский</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md" target="_blank">中文</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md" target="_blank">العربية</a></li>
</ul>

This repository represents the Rails backend for a delivery application, including a data management interface for users with admin and developer roles.

![Admin Interface Usage Illustration](./assets/admin.gif)

## Related Repositories

- [Consumy Application](https://github.com/SamuelRocha91/consumy) - Consumer application
- [Seller Application](https://github.com/SamuelRocha91/seller_application) - Seller application
- [Paymenty API](https://github.com/SamuelRocha91/paymenty) - Payment API

### Concepts and Gems Used

This project addresses and uses the following concepts and gems:

- **Background Processes:** Using Sidekiq for asynchronous task processing (along with Redis).
- **Pagination:** Implementation of pagination for resource listing (kaminari).
- **Testing with RSpec and Shoulda Matchers:** Unit and integration tests using RSpec with Shoulda Matchers to simplify assertions.
- **Test Coverage with SimpleCov:** Automated code coverage analysis with SimpleCov.
- **Soft Delete with Discard:** Implementing soft delete using the Discard gem to keep records in the database without physically deleting them.
- **Data Anonymization:** Applying techniques for anonymizing sensitive data.
- **RESTful API:** Developing a RESTful API for communication between the backend and frontend.
- **Swagger:** Automatic API documentation with Swagger to facilitate understanding and use.
- **Docker:** Containerization option with Docker to facilitate the development and deployment of the application.
- **Image Handling:** Image processing with specific tools for media processing.
- **WebSockets and SSE:** Implementing real-time communication using WebSockets and Server-Sent Events (SSE) for functionalities like chat or real-time updates.
- **Distance Calculation:** Using the geocoder gem to implement distance calculation in km from the commercial establishment to the customer's residence.
- **Threads:** Utilizing threads to improve concurrency and performance in parallel operations.

## Project Setup

### With Docker

To run this project using Docker, follow these steps:

#### Prerequisites

Ensure you have Docker and Docker Compose installed on your machine.

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Configuration

1. Clone the related repositories:

   ```sh
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. Download the `docker-compose.yml` file to configure the required Docker services and place it in the root folder where the repositories were cloned:

   - [Download docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. In the root of the project, where the `docker-compose.yml` file is located, run the following command to build and start the services:

   ```sh
   docker-compose up --build
   ```

4. When accessing the backend application in the browser, click on "RUN PENDING MIGRATES" to generate the migrations.

5. It is recommended to enter the backend application container and run the seeds:

   ```sh
   docker exec -it backendContainerName /bin/sh 
   rails db:seed
   ```

6. You need to configure environment variables in a .env file inside the delivery_back application. Example:

   ```sh
   JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```

7. You need to configure environment variables in a .env.development file inside the consumy and seller applications. Example:

   ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**NOTE** API keys can be generated inside the backend container through the console and then pasted into the .env file.

**NOTE** Another way is to generate them through a user with the developer role inside the backend interface and copy and paste into the appropriate application.

**NOTE** Don't forget to restart the containers for the variables to be loaded.

![Configuration Example](./assets/apikey.gif)

### Without Docker

To set up and run the project locally without Docker, follow these steps:

#### Prerequisites

Ensure Redis and Sidekiq are configured and running locally for the application to function correctly. Also, install the necessary R dependencies:

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### Installing Dependencies

```sh
bundle install
```

#### Configuring the Database

Create the database and run the migrations:

```sh
rails db:create
rails db:migrate
```

#### Starting the Local Server

To start the server locally:

```sh
rails server
```

#### Running Tests

To run automated tests:

```sh
bundle exec rspec
```

#### Starting Redis and Sidekiq

Ensure Redis is installed and running. Start Redis with the following command:

```sh
redis-server
```

Then, start Sidekiq:

```sh
bundle exec sidekiq
```

---

This project was created as an evaluative requirement for the Quero Ser Dev 9th edition program by LWSA.

---