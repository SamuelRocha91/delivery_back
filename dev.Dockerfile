FROM ruby:3.2.2

# Instalar dependências do sistema
RUN apt-get update -qq && apt-get install -y build-essential libvips libvips-dev

# Instalar bundler
RUN gem install bundler

# Definir diretório de trabalho
WORKDIR /app

# Copiar Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Copiar o restante do código da aplicação
COPY . .

# Pré-compilar ativos se necessário
RUN bundle exec rake assets:precompile

# Executar migrações
RUN bundle exec rake db:migrate

# Executar sementes
RUN bundle exec rake db:seed

# Start the application
CMD ["sh", "-c", "rm -f /rails/tmp/pids/server.pid && bundle exec rails server"]
