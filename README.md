# <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" /> Aplicação de Delivery  <img src="https://cdn-icons-png.flaticon.com/128/83/83522.png" alt="Java Projects Logo" width="42" height="30" />

## 🌐 Idiomas
[![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) 
[![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) 
[![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) 
[![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) 
[![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) 
[![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

Este repositório representa o backend em Rails para uma aplicação de delivery, incluindo uma interface de gerenciamento de dados para usuários com as roles admin e developer.

![Ilustração de uso da interface do admin](./assets/admin.gif)

---

<details>
  <summary><strong>🔗 Repositórios Relacionados</strong></summary>

  - 🛒 [Consumy Application](https://github.com/SamuelRocha91/consumy) - Aplicação do consumidor
  - 👨‍💼 [Seller Application](https://github.com/SamuelRocha91/seller_application) - Aplicação do vendedor
  - 💲 [Paymenty API](https://github.com/SamuelRocha91/paymenty) - API de pagamento

</details>

---

## <h2>📚 Conceitos e Gems Utilizadas</h2>

<details>
  <summary><strong>🔍 Clique para expandir os detalhes das Gems e Conceitos</strong></summary>

- **Processos em Background**: Utilização do **Sidekiq** para o processamento assíncrono de tarefas. O **Redis** é utilizado como fila de armazenamento para essas tarefas.
  
- **Paginação**: Implementação de paginação para listagem de recursos utilizando a gem **Kaminari**.

- **Testes com RSpec e Shoulda Matchers**: Utilização de **RSpec** para escrever testes de unidade, integração e funcionalidade. 

- **Cobertura de Testes com SimpleCov**: Integração com a gem **SimpleCov** para realizar análises de cobertura de código.

- **Soft Delete com Discard**: Implementação de exclusão suave (soft delete) com a gem **Discard**.

- **Bullet para Detecção de N+1 Queries**: A gem **Bullet** é utilizada para detectar e prevenir problemas de desempenho como **N+1 queries**.

- **Anonimização de Dados**: Aplicação de técnicas para anonimizar dados sensíveis, garantindo a conformidade com normas de privacidade e segurança, como a **LGPD**.

- **API RESTful**: Desenvolvimento de uma API **RESTful** que segue os princípios de arquiteturas de software para permitir uma comunicação eficiente entre o backend e o frontend.

- **Swagger**: Documentação automática da API utilizando a gem **Rswag** (baseada no Swagger).

- **Docker**: Opção de containerização utilizando **Docker** para facilitar o desenvolvimento, teste e deployment.

- **Manipulação de Imagens**: Utilização da gem **ImageProcessing** para manipulação de imagens, como redimensionamento e compressão.

- **WebSockets e SSE**: Implementação de comunicação em tempo real usando **WebSockets**.

- **Cálculo de Distância**: Utilização da gem **Geocoder** para implementar o cálculo de distância entre o cliente e o estabelecimento comercial.

- **Threads**: Uso de **threads** para melhorar a concorrência e o desempenho da aplicação em operações paralelas.

- **Gerenciamento de Sessão e Autenticação**: Implementação de autenticação de usuários com **Devise** e autenticação via **JWT**.

- **Controle de CORS**: Utilização da gem **rack-cors** para gerenciar as permissões de **CORS**.

- **Máquinas de Estado com State Machines**: Utilização da gem **state_machines-activerecord** para implementação de **máquinas de estado** nos modelos ActiveRecord.

- **Faraday para Consumo de APIs Externas**: Integração com serviços externos utilizando a gem **Faraday**.

- **Automação de Tarefas e DevOps**: A estrutura **DevOps** é suportada por ferramentas como **Sidekiq** e **Docker**.

</details>

---

## <h2>⚙️ Setup do Projeto</h2>

<details>
  <summary><strong>🛠️ Com Docker</strong></summary>

  ### Pré-requisitos

  - Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.
  - [Docker](https://docs.docker.com/get-docker/)
  - [Docker Compose](https://docs.docker.com/compose/install/)

  ### Configuração

  1. Clone os repositórios relacionados:

     ```
     git clone https://github.com/SamuelRocha91/consumy.git
     git clone https://github.com/SamuelRocha91/seller_application.git
     git clone https://github.com/SamuelRocha91/paymenty.git
     git clone https://github.com/SamuelRocha91/delivery_back.git
     ```

  2. Baixe o arquivo `docker-compose.yml`:

     - [Baixar docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

  3. Na raiz do projeto, execute o seguinte comando:

     ```sh
     docker-compose up --build
     ```

  4. Clique em "RUN PENDING MIGRATES" na aplicação back-end.

  5. Entre no container do back-end e rode as seeds:

     ```sh
     docker exec -it nomeDoContainerBackEnd /bin/sh 
     rails db:seed
     ```

  6. Configure as variáveis de ambiente:

     ```sh
     JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
     ```

  7. Reinicie os containers para as variáveis serem carregadas.

</details>

<details>
  <summary><strong>🛠️ Sem Docker</strong></summary>

  ### Pré-requisitos

  - Certifique-se de ter o Redis e o Sidekiq configurados e rodando localmente.
  
  - Instale as dependências do R:

     ```sh
     install.packages("FactoMineR")
     install.packages("ggplot2")
     install.packages("reshape2")
     ```

  ### Instalação das Dependências

  ```sh
  bundle install
  ```

  ### Configurar o Banco de Dados

  Crie o banco de dados e execute as migrações:

  ```sh
  rails db:create
  rails db:migrate
  ```

  ### Iniciar o Servidor Local

  ```sh
  rails server
  ```

  ### Executar Testes

  ```sh
  bundle exec rspec
  ```

  ### Iniciar Redis e Sidekiq

  ```sh
  redis-server
  bundle exec sidekiq
  ```

</details>

---

<details>
  <summary><strong>📝 Outros projetos</strong></summary>

  - 📏 [React Precision Application](https://github.com/SamuelRocha91/precisionReactApplication) - Interface de cadastro de medições de gás e de água
  - 🤖 [Node API](https://github.com/SamuelRocha91/apiMeasureWaterAndGas) - Api de medição e cadastro de consumo
</details>
