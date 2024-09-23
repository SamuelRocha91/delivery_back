# <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Full Stack Projects" width="52" height="40" /> Aplicação de Delivery <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTchGHKMA3VyA1ySh2ITWb0CIm_cnhF1cGvlQ&s" alt="Java Projects Logo" width="52" height="40" />  


## 🌐 [![Português](https://img.shields.io/badge/Português-green)](https://github.com/SamuelRocha91/delivery_back/blob/main/README.md) [![Español](https://img.shields.io/badge/Español-yellow)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_es.md) [![English](https://img.shields.io/badge/English-blue)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_en.md) [![Русский](https://img.shields.io/badge/Русский-lightgrey)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ru.md) [![中文](https://img.shields.io/badge/中文-red)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ch.md) [![العربية](https://img.shields.io/badge/العربية-orange)](https://github.com/SamuelRocha91/delivery_back/blob/main/README_ar.md)

Este repositório representa o backend em Rails para uma aplicação de delivery, incluindo uma interface de gerenciamento de dados para usuários com as roles admin e developer.

![Ilustração de uso da interface do admin](./assets/admin.gif)


## Repositórios Relacionados

- 🛒 [Consumy Application](https://github.com/SamuelRocha91/consumy) - Aplicação do consumidor
- 👨‍💼 [Seller Application](https://github.com/SamuelRocha91/seller_application) - Aplicação do vendedor
- 💲 [Paymenty API](https://github.com/SamuelRocha91/paymenty) - API de pagamento

### Conceitos e Gems Utilizadas

Este projeto aborda e utiliza os seguintes conceitos e gems:

- **Processos em Background**: Utilização do **Sidekiq** para o processamento assíncrono de tarefas. O **Redis** é utilizado como fila de armazenamento para essas tarefas, garantindo que as operações de longa duração, como envio de e-mails ou processamento de dados, sejam realizadas fora do ciclo principal da aplicação, melhorando a performance e a experiência do usuário.

- **Paginação**: Implementação de paginação para listagem de recursos utilizando a gem **Kaminari**, que facilita o tratamento de grandes volumes de dados e permite a divisão das listagens em páginas, melhorando a navegabilidade e a usabilidade da aplicação.

- **Testes com RSpec e Shoulda Matchers**: Utilização de **RSpec** para escrever testes de unidade, integração e funcionalidade. O uso da gem **Shoulda Matchers** simplifica as asserções, especialmente ao testar validações e associações ActiveRecord, permitindo uma sintaxe mais legível e eficiente para os testes.

- **Cobertura de Testes com SimpleCov**: Integração com a gem **SimpleCov** para realizar análises de cobertura de código. Isso garante que as áreas críticas da aplicação estejam cobertas por testes automatizados, fornecendo relatórios claros para identificar quais partes do código ainda precisam de cobertura.

- **Soft Delete com Discard**: Implementação de exclusão suave (soft delete) com a gem **Discard**, que permite marcar registros como "excluídos" sem removê-los fisicamente do banco de dados. Isso possibilita a recuperação futura dos dados e mantém a integridade histórica dos registros.

- **Bullet para Detecção de N+1 Queries**: A gem **Bullet** é utilizada para detectar e prevenir problemas de desempenho como **N+1 queries**. A Bullet alerta o desenvolvedor quando uma consulta poderia ser otimizada, sugerindo a utilização de **eager loading** para evitar múltiplas consultas desnecessárias ao banco de dados, melhorando a eficiência da aplicação.

- **Anonimização de Dados**: Aplicação de técnicas para anonimizar dados sensíveis, garantindo a conformidade com normas de privacidade e segurança, como a **LGPD** (Lei Geral de Proteção de Dados). Técnicas como mascaramento e hashing são implementadas para proteger informações pessoais.

- **API RESTful**: Desenvolvimento de uma API **RESTful** que segue os princípios de arquiteturas de software para permitir uma comunicação eficiente entre o backend e o frontend. A API é projetada para ser escalável, modular e fácil de manter.

- **Swagger**: Documentação automática da API utilizando a gem **Rswag** (baseada no Swagger), que facilita o entendimento e o uso da API, oferecendo uma interface interativa para testar as rotas, endpoints, parâmetros e retornos diretamente no navegador.

- **Docker**: Opção de containerização utilizando **Docker**, o que facilita o desenvolvimento, teste e deployment da aplicação em ambientes controlados. Isso garante que as dependências e a infraestrutura estejam isoladas e sejam facilmente replicáveis em diferentes máquinas.

- **Manipulação de Imagens**: Utilização da gem **ImageProcessing** para manipulação de imagens, como redimensionamento e compressão. Ferramentas como **ruby-vips** são usadas para otimizar o processamento de imagens em larga escala, garantindo alta performance.

- **WebSockets e SSE**: Implementação de comunicação em tempo real usando **WebSockets** para funcionalidades que exigem interatividade imediata, como chats, notificações ou atualizações em tempo real. **Server-Sent Events (SSE)** é outra abordagem utilizada para envio de atualizações unidirecionais do servidor para o cliente.

- **Cálculo de Distância**: Utilização da gem **Geocoder** para implementar o cálculo de distância entre o cliente e o estabelecimento comercial, facilitando a entrega de serviços baseados em localização. O cálculo da distância pode ser feito em quilômetros, garantindo precisão e eficiência.

- **Threads**: Uso de **threads** para melhorar a concorrência e o desempenho da aplicação em operações paralelas, como processamento de grandes volumes de dados ou integração com serviços externos. O uso de threads permite que múltiplas operações sejam executadas simultaneamente, otimizando o tempo de resposta da aplicação.

- **Gerenciamento de Sessão e Autenticação**: Implementação de autenticação de usuários com **Devise**, uma gem amplamente utilizada no ecossistema Rails. Também há suporte para autenticação via **JWT** (JSON Web Token) para permitir autenticação baseada em tokens, especialmente útil para APIs.

- **Controle de CORS**: Utilização da gem **rack-cors** para gerenciar as permissões de **Cross-Origin Resource Sharing (CORS)**, garantindo que a API seja acessível de diferentes domínios com segurança.

- **Máquinas de Estado com State Machines**: Utilização da gem **state_machines-activerecord** para implementação de **máquinas de estado** nos modelos ActiveRecord. Isso permite o controle detalhado de transições de estado, garantindo que certos processos ou objetos sigam fluxos pré-definidos, como mudanças de status de pedidos, pagamentos, ou processos automáticos.

- **Faraday para Consumo de APIs Externas**: Integração com serviços externos utilizando a gem **Faraday**, uma biblioteca de HTTP cliente que permite realizar requisições HTTP/REST de forma flexível e eficiente. Isso facilita a comunicação com APIs de terceiros, oferecendo suporte a middlewares, retries, e tratamento de erros.

- **Automação de Tarefas e DevOps**: A estrutura **DevOps** é suportada por ferramentas como **Sidekiq** e **Docker** para automatizar a integração contínua, o deployment e o monitoramento de tarefas em background.

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
   git clone https://github.com/SamuelRocha91/delivery_back.git
   ```

2. Baixe o arquivo `docker-compose.yml` para configurar os serviços Docker necessários e insira-o na pasta raiz onde os repositórios foram clonados:

   - [Baixar docker-compose.yml](https://drive.google.com/file/d/1kzs-DJGCvYImBQAqr1GI-zwoNha_b8tA/view?usp=drive_link)

3. Na raiz do projeto, onde está localizado o arquivo `docker-compose.yml`, execute o seguinte comando para construir e iniciar os serviços:

   ```sh
   docker-compose up --build
   ```

4. Ao entrar na aplicação back-end no navegador, clique em "RUN PENDING MIGRATES" para gerar as migrações

5. É recomendável entrar no container da aplicação back-end e rodar as seeds:

  ```sh
   docker exec -it nomeDoContainerBackEnd /bin/sh 
   rails db:seed
   ```

6. É necessário configurar as variáveis de ambiente num arquivo .env dentro da aplicação delivery_back. Ex:

  ```sh
    JWT_SECRET_KEY=xxxxxxxxxxxxxxxxxxxxx
   ```


6. É necessário configurar as variáveis de ambiente num arquivo .env.development dentro da aplicação consumy e seller. Ex:

  ```sh
   VITE_BASE_URL=http://localhost:3000
   VITE_X_API_KEY=Z34dqYJ8qBelcmcBfWNuHc5JB/w=
   ```

**OBS** As api_keys podem ser geradas dentro do container back-end através do console e depois colada no arquivo .env.

**OBS** Outra forma é gerá-la através de um usuário com a role developer dentro da interface do backend e copiar e colar na aplicação devida.

 **OBS** Não esquecer de reiniciar os containers para as variáveis serem carregadas

![Exemplo de configuração](./assets/apikey.gif)


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

## Outros projetos

- 📏 [React Precision Application](https://github.com/SamuelRocha91/precisionReactApplication) - Interface de cadastro de medições de gás e de água
- 🤖 [Node API](https://github.com/SamuelRocha91/apiMeasureWaterAndGas) - Api de medição e cadastro de consumo
