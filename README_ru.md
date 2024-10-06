# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> Приложение для Доставки  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 Языки
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

Этот репозиторий представляет собой бэкенд на Rails для приложения доставки, включая интерфейс управления данными для пользователей с ролями администратора и разработчика.

![Иллюстрация использования интерфейса администратора](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 Связанные репозитории</strong></summary>

  - 🛒 [Приложение Consumy](https://github.com/SamuelRocha91/consumy/blob/main/README_ru.md) - Приложение для потребителей
  - 👨‍💼 [Приложение Продавца](https://github.com/SamuelRocha91/seller_application/blob/main/README_ru.md) - Приложение для продавцов
  - 💲 [API Paymenty](https://github.com/SamuelRocha91/paymenty/blob/main/README_ru.md) - API для платежей

</details>

---

## <h2>📚 Используемые концепции и библиотеки</h2>

<details>
  <summary><strong>🔍 Нажмите, чтобы развернуть детали библиотек и концепций</strong></summary>

- **Фоновая обработка**: Использование **Sidekiq** для обработки асинхронных задач. **Redis** используется как очередь для хранения этих задач.
  
- **Пагинация**: Реализация пагинации для списков ресурсов с использованием библиотеки **Kaminari**.

- **Тестирование с RSpec и Shoulda Matchers**: Использование **RSpec** для написания юнит-тестов, интеграционных и функциональных тестов.

- **Покрытие тестами с помощью SimpleCov**: Интеграция с библиотекой **SimpleCov** для анализа покрытия кода.

- **Мягкое удаление с Discard**: Реализация мягкого удаления с использованием библиотеки **Discard**.

- **Bullet для обнаружения запросов N+1**: Библиотека **Bullet** используется для обнаружения и предотвращения проблем с производительностью, таких как запросы **N+1**.

- **Анонимизация данных**: Применение методов анонимизации для защиты конфиденциальных данных, соответствие требованиям законодательства о защите персональных данных, таким как **LGPD**.

- **RESTful API**: Разработка **RESTful** API, следуя принципам архитектуры программного обеспечения для обеспечения эффективной связи между бэкендом и фронтендом.

- **Swagger**: Автоматическая документация API с использованием библиотеки **Rswag** (на основе Swagger).

- **Docker**: Возможность контейнеризации с использованием **Docker** для упрощения разработки, тестирования и развертывания.

- **Обработка изображений**: Использование библиотеки **ImageProcessing** для обработки изображений, такой как изменение размера и сжатие.

- **WebSockets и SSE**: Реализация связи в реальном времени с использованием **WebSockets**.

- **Расчет расстояний**: Использование библиотеки **Geocoder** для реализации расчета расстояний между клиентом и коммерческим предприятием.

- **Потоки**: Использование **потоков** для повышения параллелизма и производительности приложения при выполнении параллельных операций.

- **Управление сессиями и аутентификация**: Реализация аутентификации пользователей с использованием **Devise** и аутентификации через **JWT**.

- **Управление CORS**: Использование библиотеки **rack-cors** для управления разрешениями **CORS**.

- **Автоматы состояний с помощью State Machines**: Использование библиотеки **state_machines-activerecord** для реализации **автоматов состояний** в моделях ActiveRecord.

- **Faraday для работы с внешними API**: Интеграция с внешними сервисами с использованием библиотеки **Faraday**.

- **Автоматизация задач и DevOps**: Структура **DevOps** поддерживается такими инструментами, как **Sidekiq** и **Docker**.

</details>

---

## <h2>⚙️ Настройка проекта</h2>

<details>
  <summary><strong>🛠️ С Docker</strong></summary>

  ### Предварительные требования

  - Убедитесь, что на вашем компьютере установлены Docker и Docker Compose.
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### Настройка

  1. Клонируйте связанные репозитории:

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. Скачайте файл `docker-compose.yml`:

     - [Скачать docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. В корне проекта выполните следующую команду:

     ```sh
     docker-compose up --build
     ```

  4. Нажмите "RUN PENDING MIGRATES" в приложении бэкенда.

  5. Войдите в контейнер бэкенда и выполните сиды:

     ```sh
     docker exec -it backendContainerName /bin/sh 
     rails db:seed
     ```

  6. Настройте переменные окружения:
Теперь все разделы переведены на русский язык, и ссылки настроены в соответствии с вашим запросом. Если вам нужно что-то еще, дайте знать!
     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. Перезапустите контейнеры, чтобы переменные загрузились.

</details>

<details>
  <summary><strong>🛠️ Без Docker</strong></summary>

  ### Предварительные требования

  - Убедитесь, что Redis и Sidekiq настроены и работают на вашем локальном компьютере.
  
  - Установите зависимости для R:

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### Установите зависимости

  ```sh
  bundle install
  ```

  ### Настройте базу данных

  Создайте базу данных и выполните миграции:

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### Запустите локальный сервер

  ```sh
  rails server
  ```

  ### Запустите тесты

  ```sh
  bundle exec rspec
  ```

  ### Запустите Redis и Sidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 Другие проекты</strong></summary>

  - 📏 [Приложение Precision на React](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_ru.md) - Интерфейс для регистрации измерений газа и воды
  - 🤖 [API Node](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_ru.md) - API для измерения и регистрации потребления
</details>
