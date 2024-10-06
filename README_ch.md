# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> 送货应用程序  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 语言
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

该存储库是一个基于Rails的送货应用程序的后端，包括管理具有管理员和开发者角色的用户数据的接口。

![管理员界面使用示例](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 相关存储库</strong></summary>

  - 🛒 [消费者应用程序](https://github.com/SamuelRocha91/consumy/blob/main/README_ch.md) - 供消费者使用的应用程序
  - 👨‍💼 [卖方应用程序](https://github.com/SamuelRocha91/seller_application/blob/main/README_ch.md) - 供卖方使用的应用程序
  - 💲 [支付API](https://github.com/SamuelRocha91/paymenty/blob/main/README_ch.md) - 支付API

</details>

---

## <h2>📚 使用的概念和库</h2>

<details>
  <summary><strong>🔍 点击展开库和概念的详细信息</strong></summary>

- **后台处理**：使用 **Sidekiq** 处理异步任务。**Redis** 用作存储这些任务的队列。
  
- **分页**：使用 **Kaminari** 库实现资源列表的分页。

- **RSpec和Shoulda Matchers的测试**：使用 **RSpec** 编写单元测试、集成测试和功能测试。

- **使用SimpleCov进行测试覆盖**：集成 **SimpleCov** 库以分析代码覆盖率。

- **使用Discard的软删除**：使用 **Discard** 库实现软删除。

- **Bullet用于检测N+1查询**：使用 **Bullet** 库检测和防止性能问题，例如 **N+1** 查询。

- **数据匿名化**：应用匿名化方法保护敏感数据，以符合如 **LGPD** 等数据保护法规的要求。

- **RESTful API**：开发 **RESTful** API，遵循软件架构原则，以确保后端与前端之间的高效通信。

- **Swagger**：使用 **Rswag**（基于Swagger）库自动生成API文档。

- **Docker**：支持使用 **Docker** 进行容器化，以简化开发、测试和部署。

- **图像处理**：使用 **ImageProcessing** 库进行图像处理，如调整大小和压缩。

- **WebSockets和SSE**：使用 **WebSockets** 实现实时通信。

- **距离计算**：使用 **Geocoder** 库实现客户与商业之间的距离计算。

- **流**：使用 **流** 提高应用程序在并行操作时的并行性和性能。

- **会话管理和身份验证**：使用 **Devise** 实现用户身份验证，并通过 **JWT** 进行身份验证。

- **CORS管理**：使用 **rack-cors** 库管理 **CORS** 权限。

- **使用状态机的状态自动机**：使用 **state_machines-activerecord** 库在ActiveRecord模型中实现 **状态自动机**。

- **Faraday与外部API的交互**：使用 **Faraday** 库与外部服务集成。

- **任务自动化和DevOps**：通过 **Sidekiq** 和 **Docker** 等工具支持 **DevOps** 结构。

</details>

---

## <h2>⚙️ 项目设置</h2>

<details>
  <summary><strong>🛠️ 使用Docker</strong></summary>

  ### 前提条件

  - 确保您的计算机上已安装Docker和Docker Compose。
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### 设置

  1. 克隆相关存储库：

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. 下载 `docker-compose.yml` 文件：

     - [下载docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. 在项目根目录下运行以下命令：

     ```sh
     docker-compose up --build
     ```

  4. 在后端应用程序中点击“运行待处理的迁移”。

  5. 进入后端容器并运行种子：

     ```sh
     docker exec -it backendContainerName /bin/sh 
     rails db:seed
     ```

  6. 设置环境变量：

     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. 重新启动容器以加载变量。

</details>

<details>
  <summary><strong>🛠️ 不使用Docker</strong></summary>

  ### 前提条件

  - 确保Redis和Sidekiq已在您的本地计算机上设置并运行。
  
  - 安装R的依赖项：

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### 安装依赖

  ```sh
  bundle install
  ```

  ### 设置数据库

  创建数据库并运行迁移：

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### 启动本地服务器

  ```sh
  rails server
  ```

  ### 运行测试

  ```sh
  bundle exec rspec
  ```

  ### 启动Redis和Sidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 其他项目</strong></summary>

  - 📏 [Precision应用程序（React）](https://github.com/SamuelRocha91/precisionReactApplication/blob/main/README_ch.md) - 用于记录水和气体测量的界面
  - 🤖 [API节点](https://github.com/SamuelRocha91/apiMeasureWaterAndGas/blob/main/README_ch.md) - 用于测量和记录消费的API
</details>
