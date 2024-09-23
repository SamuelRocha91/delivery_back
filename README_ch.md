# <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Full Stack Projects" width="52" height="40" /> 外卖应用 <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Java Projects Logo" width="52" height="40" />

## 🌐 [![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) [![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) [![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) [![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) [![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) [![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

此存储库代表了一个用于外卖的Rails后端，包括一个用于管理数据的接口，适用于具有管理员和开发者角色的用户。

![管理员界面使用示例](./assets/admin.gif)

## 相关存储库

- [Consumy 应用](https://github.com/SamuelRocha91/consumy) - 消费者应用
- [Seller 应用](https://github.com/SamuelRocha91/seller_application) - 卖家应用
- [Paymenty API](https://github.com/SamuelRocha91/paymenty) - 支付 API

### 使用的概念和库（gems）

该项目涉及并使用以下概念和库（gems）：

- **后台处理**: 使用 **Sidekiq** 进行异步任务处理，**Redis** 作为任务队列。这允许将诸如发送电子邮件或数据处理等耗时操作从应用程序的主循环中移出，从而提高性能和用户体验。

- **分页**: 使用 **Kaminari** 实现资源列表的分页。分页功能简化了大数据集的处理，并通过将列表分割成页面来改善导航。

- **使用 RSpec 和 Shoulda Matchers 进行测试**: 使用 **RSpec** 编写单元测试、集成测试和功能测试。**Shoulda Matchers** 简化了断言，特别是在测试 ActiveRecord 的验证和关联时，使测试更具可读性和效率。

- **使用 SimpleCov 的测试覆盖率**: 集成 **SimpleCov** 库以自动分析代码的测试覆盖率。它提供了关于哪些代码部分仍需测试的报告，确保关键的应用程序区域都被覆盖。

- **使用 Discard 实现软删除**: 通过 **Discard** 库实现软删除，这允许“删除”记录而不将其从数据库中物理删除。这使得未来的数据恢复成为可能，并保持数据的历史完整性。

- **使用 Bullet 检测 N+1 查询**: **Bullet** 库用于检测和防止性能问题，例如 **N+1 查询**。当查询可以优化时，Bullet 会通知开发者，建议使用 **预加载（eager loading）** 来防止不必要的数据库查询，从而提高应用程序的性能。

- **数据匿名化**: 应用数据匿名化技术以保护敏感数据的隐私和安全，遵守 **LGPD**（数据保护法）的要求。使用诸如数据遮蔽和哈希化等技术。

- **RESTful API**: 开发 **RESTful API**，遵循软件架构的原则，确保前后端之间的高效通信。API 被设计为可扩展、模块化和易于维护的。

- **Swagger**: 使用 **Rswag**（基于 Swagger）进行 API 自动文档生成，简化了对 API 的理解和使用，并通过浏览器提供交互式接口来测试路由、参数和响应。

- **Docker**: 通过 **Docker** 实现容器化，以简化开发、测试和应用程序的部署。它确保依赖项和基础设施得到隔离，并可以轻松地在不同机器上重现。

- **图像处理**: 使用 **ImageProcessing** 库进行图像处理，例如调整大小和压缩。工具如 **ruby-vips** 被用于优化大批量图像处理，确保高性能。

- **WebSockets 和 SSE**: 使用 **WebSockets** 实现实时通信功能，例如需要即时交互的聊天、通知或实时更新。**服务器推送事件 (SSE)** 也被用于服务器向客户端单向推送更新。

- **距离计算**: 使用 **Geocoder** 库计算客户与商家的距离，以公里为单位进行计算。这为基于地理位置的服务提供了支持，并确保精确性和高效性。

- **线程**: 使用 **线程（threads）** 来提高并行操作中的并发性和性能，例如处理大数据集或与外部服务集成。线程允许多个操作同时执行，从而优化应用程序的响应时间。

- **会话管理和身份验证**: 使用 **Devise** 进行用户身份验证，这是 Rails 生态系统中非常流行的库。还支持使用 **JWT**（JSON Web Token）进行身份验证，特别适用于 API 中的令牌验证。

- **CORS 管理**: 使用 **rack-cors** 库管理 **跨源资源共享 (CORS)** 权限，确保来自不同域的安全 API 访问。

- **状态机管理（State Machines）**: 使用 **state_machines-activerecord** 库在 ActiveRecord 模型中实现 **状态机**。它允许控制状态之间的转换，确保执行某些流程和任务流，例如订单、付款状态或自动化流程的变化。

- **使用 Faraday 进行外部 API 调用**: 使用 **Faraday** 库与外部服务集成，这是一个灵活高效的 HTTP 客户端，用于执行 REST 请求。它简化了与第三方 API 的交互，支持中间件、重试机制和错误处理。

- **任务自动化与 DevOps**: 使用 **Sidekiq** 和 **Docker** 等工具支持 **DevOps** 架构，自动化持续集成、部署和后台任务的监控流程。

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
## 其他项目
- 📏 [React 精准应用程序](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_ch.md) - 燃气和水的测量登记界面
- 🤖 [Node API](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_ch.md) - 用于测量和登记水和燃气消耗的 API
