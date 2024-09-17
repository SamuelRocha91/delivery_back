# Приложение для Доставки

<h2>🌐</h2>
<ul>
  <li><a href="https://github.com/SamuelRocha91/delivery_back" target="_blank">Português</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md" target="_blank">Español</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md" target="_blank">English</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md" target="_blank">Русский</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md" target="_blank">中文</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md" target="_blank">العربية</a></li>
</ul>

Этот репозиторий представляет собой Rails-бэкенд для приложения по доставке, включая интерфейс управления данными для пользователей с ролями администратора и разработчика.

![Иллюстрация использования интерфейса администратора](./assets/admin.gif)

## Связанные Репозитории

- [Consumy Application](https://github.com/SamuelRocha91/consumy) - Приложение для потребителей
- [Seller Application](https://github.com/SamuelRocha91/seller_application) - Приложение для продавцов
- [Paymenty API](https://github.com/SamuelRocha91/paymenty) - API для платежей

### Используемые Концепции и Гемы

Этот проект охватывает и использует следующие концепции и гемы:

- **Фоновые Процессы:** Использование Sidekiq для асинхронной обработки задач (вместе с Redis).
- **Пагинация:** Реализация пагинации для перечисления ресурсов (kaminari).
- **Тестирование с RSpec и Shoulda Matchers:** Юнит- и интеграционные тесты с использованием RSpec и Shoulda Matchers для упрощения утверждений.
- **Покрытие Тестов с SimpleCov:** Автоматизированный анализ покрытия кода с помощью SimpleCov.
- **Мягкое Удаление с Discard:** Реализация мягкого удаления с использованием гема Discard для сохранения записей в базе данных без их физического удаления.
- **Анонимизация Данных:** Применение методов для анонимизации чувствительных данных.
- **RESTful API:** Разработка RESTful API для взаимодействия между бэкендом и фронтендом.
- **Swagger:** Автоматическая документация API с помощью Swagger для облегчения понимания и использования.
- **Docker:** Опция контейнеризации с использованием Docker для упрощения разработки и развертывания приложения.
- **Обработка Изображений:** Обработка изображений с использованием специфических инструментов для медиаобработки.
- **WebSockets и SSE:** Реализация коммуникации в реальном времени с использованием WebSockets и Server-Sent Events (SSE) для таких функций, как чат или обновления в реальном времени.
- **Расчет Расстояния:** Использование гема geocoder для реализации расчета расстояния в км от коммерческого заведения до места жительства клиента.
- **Потоки:** Использование потоков для улучшения параллелизма и производительности в параллельных операциях.

## Настройка Проекта

### С Docker

Чтобы запустить этот проект с помощью Docker, выполните следующие шаги:

#### Предварительные Требования

Убедитесь, что у вас установлены Docker и Docker Compose.

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Конфигурация

1. Клонируйте связанные репозитории:

   ```sh
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. Скачайте файл `docker-compose.yml` для настройки необходимых сервисов Docker и поместите его в корневую папку, где были клонированы репозитории:

   - [Скачать docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. В корневой папке проекта, где находится файл `docker-compose.yml`, выполните следующую команду для сборки и запуска сервисов:

   ```sh
   docker-compose up --build
   ```

4. При доступе к бэкенд-приложению в браузере нажмите на "RUN PENDING MIGRATES", чтобы создать миграции.

5. Рекомендуется войти в контейнер бэкенд-приложения и запустить сиды:

   ```sh
   docker exec -it backendContainerName /bin/sh 
   rails db:seed
   ```

6. Необходимо настроить переменные окружения в файле .env внутри приложения delivery_back. Пример:

   ```sh
   JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```

7. Необходимо настроить переменные окружения в файле .env.development внутри приложений consumy и seller. Пример:

   ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**ПРИМЕЧАНИЕ** API-ключи могут быть сгенерированы внутри контейнера бэкенда через консоль, а затем вставлены в файл .env.

**ПРИМЕЧАНИЕ** Другой способ - сгенерировать их через пользователя с ролью разработчика в интерфейсе бэкенда и скопировать и вставить в соответствующее приложение.

**ПРИМЕЧАНИЕ** Не забудьте перезапустить контейнеры, чтобы переменные были загружены.

![Пример конфигурации](./assets/apikey.gif)

### Без Docker

Чтобы настроить и запустить проект локально без Docker, выполните следующие шаги:

#### Предварительные Требования

Убедитесь, что Redis и Sidekiq настроены и работают локально для правильного функционирования приложения. Также установите необходимые зависимости R:

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### Установка Зависимостей

```sh
bundle install
```

#### Настройка Базы Данных

Создайте базу данных и выполните миграции:

```sh
rails db:create
rails db:migrate
```

#### Запуск Локального Сервера

Чтобы запустить сервер локально:

```sh
rails server
```

#### Запуск Тестов

Чтобы выполнить автоматизированные тесты:

```sh
bundle exec rspec
```

#### Запуск Redis и Sidekiq

Убедитесь, что Redis установлен и работает. Запустите Redis с помощью следующей команды:

```sh
redis-server
```

Затем запустите Sidekiq:

```sh
bundle exec sidekiq
```

---

Этот проект был создан как часть оценочного требования для программы Quero Ser Dev 9-го выпуска от LWSA.

---