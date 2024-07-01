FROM ruby:3.2.2

# Instalar dependências do sistema
RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libvips \
    libvips-dev \
    r-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar o bundler
RUN gem install bundler

# Definir diretório de trabalho
WORKDIR /app

# Copiar Gemfile e Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Instalar gems
RUN bundle install

# Instalar pacotes R necessários
RUN R -e "install.packages(c('FactoMineR', 'ggplot2', 'reshape2'), repos='https://cran.rstudio.com/')"

# Copiar o restante do código da aplicação
COPY . .

EXPOSE 3000
# Remove o arquivo de PID do servidor, se existir, e inicia o servidor Rails
CMD ["sh", "-c", "rm -f /app/tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
