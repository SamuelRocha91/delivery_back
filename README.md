# Aplicação de Delivery

Este repositório representa o backend em Rails para uma aplicação de delivery, além de uma interface de gerenciamento de dados dos usuários para users com as roles admin e developer.

[![Em desenvolvimento](https://img.shields.io/badge/Status-Em%20desenvolvimento-yellow)](https://github.com/SamuelRocha91/delivery_app)

## Repositórios Relacionados

- [Consumy Application](https://github.com/SamuelRocha91/consumy) - Aplicação do consumidor
- [Seller Application](https://github.com/SamuelRocha91/seller_application) - Aplicação do vendedor

### Conceitos e Gems Utilizadas

Este projeto aborda e utiliza os seguintes conceitos e gems:

- **Processos em Background:** Utilização do Sidekiq para processamento assíncrono de tarefas(junto com redis).
- **Paginação:** Implementação de paginação para listagem de recursos(kaminari).
- **Testes com RSpec e Shoulda Matchers:** Testes de unidade e integração utilizando RSpec com Shoulda Matchers para simplificar as asserções.
- **Cobertura de Testes com SimpleCov:** Análise de cobertura de código automatizada com SimpleCov.
- **Soft Delete com Discard:** Implementação de exclusão suave (soft delete) utilizando a gem Discard para manter registros no banco de dados sem excluí-los fisicamente.
- **Anonimização de Dados:** Aplicação de técnicas para anonimização de dados sensíveis.
- **API RESTful:** Desenvolvimento de uma API RESTful para comunicação entre o backend e o frontend.
- **Swagger:** Documentação automática da API com Swagger para facilitar o entendimento e uso.
- **Docker:** Opção de containerização com Docker para facilitar o desenvolvimento e deployment da aplicação.
- **Manipulação de Imagens:** Manipulação de imagens com ferramentas específicas para processamento de mídias.
- **WebSockets e SSE:** Implementação de comunicação em tempo real utilizando WebSockets e Server-Sent Events (SSE) para funcionalidades como chat ou atualizações em tempo real.


## Setup do Projeto

Para configurar e executar o projeto localmente, siga os passos abaixo:

### Pré-requisitos

Certifique-se de ter o Redis e o Sidekiq configurados e executando localmente para o correto funcionamento da aplicação.

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

---

Este projeto foi criado como requisito avaliativo para o programa Quero Ser Dev 9ª edição da LWSA.

---
