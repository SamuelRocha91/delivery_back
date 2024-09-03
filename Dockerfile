FROM ruby:3.2.2

RUN apt-get update -qq && \
    apt-get install -y \
    build-essential \
    libvips \
    libvips-dev \
    r-base \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN gem install bundler

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

RUN R -e "install.packages('ggplot2', repos='https://cran.rstudio.com/', dependencies=TRUE)"
RUN R -e "install.packages('reshape2', repos='https://cran.rstudio.com/', dependencies=TRUE)"

COPY . .

RUN mkdir -p tmp/cache/assets/sprockets && \
    chmod -R 755 tmp
    
EXPOSE 3000

CMD ["sh", "-c", "rm -f /app/tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"]
