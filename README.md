# Aplicação de Delivery

Este repositório representa o backend em Rails para uma aplicação de delivery, incluindo uma interface de gerenciamento de dados para usuários com as roles admin e developer.

[![Em desenvolvimento](https://img.shields.io/badge/Status-Em%20desenvolvimento-yellow)](https://github.com/SamuelRocha91/delivery_app)

## Repositórios Relacionados

- [Consumy Application](https://github.com/SamuelRocha91/consumy) - Aplicação do consumidor
- [Seller Application](https://github.com/SamuelRocha91/seller_application) - Aplicação do vendedor
- [Paymenty API](https://github.com/SamuelRocha91/paymenty) - API de pagamento

### Conceitos e Gems Utilizadas

Este projeto aborda e utiliza os seguintes conceitos e gems:

- **Processos em Background:** Utilização do Sidekiq para processamento assíncrono de tarefas (junto com redis).
- **Paginação:** Implementação de paginação para listagem de recursos (kaminari).
- **Testes com RSpec e Shoulda Matchers:** Testes de unidade e integração utilizando RSpec com Shoulda Matchers para simplificar as asserções.
- **Cobertura de Testes com SimpleCov:** Análise de cobertura de código automatizada com SimpleCov.
- **Soft Delete com Discard:** Implementação de exclusão suave (soft delete) utilizando a gem Discard para manter registros no banco de dados sem excluí-los fisicamente.
- **Anonimização de Dados:** Aplicação de técnicas para anonimização de dados sensíveis.
- **API RESTful:** Desenvolvimento de uma API RESTful para comunicação entre o backend e o frontend.
- **Swagger:** Documentação automática da API com Swagger para facilitar o entendimento e uso.
- **Docker:** Opção de containerização com Docker para facilitar o desenvolvimento e deployment da aplicação.
- **Manipulação de Imagens:** Manipulação de imagens com ferramentas específicas para processamento de mídias.
- **WebSockets e SSE:** Implementação de comunicação em tempo real utilizando WebSockets e Server-Sent Events (SSE) para funcionalidades como chat ou atualizações em tempo real.
- **Cálculo de distância:** Uso da gem geocoder para implementar o cálculo de distância em km do estabelecimento comercial para a residência do cliente.
- **Threads:** Utilização de threads para melhorar a concorrência e o desempenho em operações paralelas.

## Setup do Projeto

### Com Docker

Para executar este projeto utilizando Docker, siga os passos abaixo:

#### Pré-requisitos

Certifique-se de ter o Docker e o Docker Compose instalados em sua máquina.

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

#### Configuração

1. Clone os repositórios relacionados:

   ```
   git clone https://github.com/SamuelRocha91/consumy.git
   git clone https://github.com/SamuelRocha91/seller_application.git
   git clone https://github.com/SamuelRocha91/paymenty.git
   git clone https://github.com/SamuelRocha91/delivery_app.git
   ```

2. Baixe o arquivo `docker-compose.yml` para configurar os serviços Docker necessários e insira-o na pasta raiz onde os repositórios foram clonados:

   - [Baixar docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. Na raiz do projeto, onde está localizado o arquivo `docker-compose.yml`, execute o seguinte comando para construir e iniciar os serviços:

   ```sh
   docker-compose up --build
   ```

### Sem Docker

Para configurar e executar o projeto localmente sem Docker, siga os passos abaixo:

#### Pré-requisitos

Certifique-se de ter o Redis e o Sidekiq configurados e executando localmente para o correto funcionamento da aplicação. Além disso, instale as dependências necessárias do R:

```sh
install.packages("FactoMineR")
install.packages("ggplot2")
install.packages("reshape2")
```

#### Instalação das Dependências

```sh
bundle install
```

#### Configurar o Banco de Dados

Crie o banco de dados e execute as migrações:

```sh
rails db:create
rails db:migrate
```

#### Iniciar o Servidor Local

Para iniciar o servidor localmente:

```sh
rails server
```

#### Executar Testes

Para executar os testes automatizados:

```sh
bundle exec rspec
```

#### Iniciar Redis e Sidekiq

Certifique-se de que o Redis está instalado e rodando. Inicie o Redis com o seguinte comando:

```sh
redis-server
```

Em seguida, inicie o Sidekiq:

```sh
bundle exec sidekiq
```

---

Este projeto foi criado como requisito avaliativo para o programa Quero Ser Dev 9ª edição da LWSA.

---
