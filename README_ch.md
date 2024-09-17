# 外卖应用

<h2>🌐</h2>
<ul>
  <li><a href="https://github.com/SamuelRocha91/delivery_back" target="_blank">Português</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md" target="_blank">Español</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md" target="_blank">English</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md" target="_blank">Русский</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md" target="_blank">中文</a></li>
  <li><a href="https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md" target="_blank">العربية</a></li>
</ul>

此存储库代表了一个用于外卖的Rails后端，包括一个用于管理数据的接口，适用于具有管理员和开发者角色的用户。

![管理员界面使用示例](./assets/admin.gif)

## 相关存储库

- [Consumy 应用](https://github.com/SamuelRocha91/consumy) - 消费者应用
- [Seller 应用](https://github.com/SamuelRocha91/seller_application) - 卖家应用
- [Paymenty API](https://github.com/SamuelRocha91/paymenty) - 支付 API

### 使用的概念和 Gem

本项目涉及并使用了以下概念和 Gem：

- **后台处理：** 使用 Sidekiq 进行异步任务处理（配合 Redis）。
- **分页：** 实现资源列表的分页（kaminari）。
- **RSpec 和 Shoulda Matchers 测试：** 使用 RSpec 和 Shoulda Matchers 进行单元和集成测试，以简化断言。
- **SimpleCov 测试覆盖：** 使用 SimpleCov 自动化代码覆盖分析。
- **Discard 软删除：** 使用 Discard Gem 实现软删除，保持数据库中的记录而不进行物理删除。
- **数据匿名化：** 应用敏感数据匿名化技术。
- **RESTful API：** 开发 RESTful API 用于后端和前端之间的通信。
- **Swagger：** 使用 Swagger 自动生成 API 文档，便于理解和使用。
- **Docker：** 使用 Docker 进行容器化，以简化应用的开发和部署。
- **图像处理：** 使用特定工具进行媒体处理。
- **WebSockets 和 SSE：** 使用 WebSockets 和 Server-Sent Events (SSE) 实现实时通信，用于聊天或实时更新等功能。
- **距离计算：** 使用 geocoder Gem 实现从商业场所到客户住宅的公里距离计算。
- **线程：** 使用线程提升并发性和并行操作的性能。

## 项目设置

### 使用 Docker

要使用 Docker 运行此项目，请按照以下步骤操作：

#### 先决条件

确保您的计算机上已安装 Docker 和 Docker Compose。

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### 配置

1. 克隆相关存储库：

   ```sh
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. 下载 `docker-compose.yml` 文件以配置所需的 Docker 服务，并将其放入克隆的存储库根目录：

   - [下载 docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. 在项目根目录（包含 `docker-compose.yml` 文件的位置），执行以下命令以构建和启动服务：

   ```sh
   docker-compose up --build
   ```

4. 访问后端应用程序时，点击“RUN PENDING MIGRATES”以生成迁移。

5. 推荐进入后端应用程序的容器并运行种子数据：

   ```sh
   docker exec -it backendContainerName /bin/sh 
   rails db:seed
   ```

6. 需要在 `delivery_back` 应用程序中创建一个 `.env` 文件来配置环境变量。例如：

   ```sh
   JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```

7. 需要在 `consumy` 和 `seller` 应用程序中创建一个 `.env.development` 文件来配置环境变量。例如：

   ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**注意** API 密钥可以在后端容器内通过控制台生成，然后粘贴到 `.env` 文件中。

**注意** 另一种方法是通过具有开发者角色的用户在后端界面中生成密钥，然后复制粘贴到相应的应用程序中。

**注意** 不要忘记重新启动容器以加载环境变量。

![配置示例](./assets/apikey.gif)

### 不使用 Docker

要在本地环境中配置和运行项目而不使用 Docker，请按照以下步骤操作：

#### 先决条件

确保 Redis 和 Sidekiq 已正确配置并运行在本地。此外，安装 R 所需的依赖：

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### 安装依赖

```sh
bundle install
```

#### 配置数据库

创建数据库并执行迁移：

```sh
rails db:create
rails db:migrate
```

#### 启动本地服务器

要本地启动服务器：

```sh
rails server
```

#### 运行测试

要运行自动化测试：

```sh
bundle exec rspec
```

#### 启动 Redis 和 Sidekiq

确保 Redis 已安装并正在运行。使用以下命令启动 Redis：

```sh
redis-server
```

然后启动 Sidekiq：

```sh
bundle exec sidekiq
```

---

该项目作为 LWSA Quero Ser Dev 第9届计划的评估要求创建。

---