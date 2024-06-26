
# Aplicação de Delivery

Este repositório representa o backend em Rails para uma aplicação de delivery, além de uma interface de gerenciamento de dados dos usuários para users com as roles admin e developer.

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

## Setup do Projeto

Para configurar e executar o projeto localmente, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter o Redis e o Sidekiq configurados e executando localmente para o correto funcionamento da aplicação.
É necessário também ter o R instalado com os seguintes pacotes:

- FactoMineR
- ggplot2
- reshape2

Você pode instalar esses pacotes no R com os seguintes comandos:

```R
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

Para iniciar o servidor localmente:

```sh
rails server
```

### Executar Testes

Para executar os testes automatizados:

```sh
bundle exec rspec
```

### Iniciar Redis e Sidekiq

Certifique-se de que o Redis está instalado e rodando. Você pode iniciar o Redis com o seguinte comando:

```sh
redis-server
```

Em seguida, inicie o Sidekiq:

```sh
bundle exec sidekiq
```

### Docker

Atualmente, a aplicação não possui suporte a Docker, mas há planos para incluir esta funcionalidade em breve.

---

Este projeto foi criado como requisito avaliativo para o programa Quero Ser Dev 9ª edição da LWSA.

---
