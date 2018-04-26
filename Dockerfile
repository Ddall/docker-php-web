# See https://github.com/docker-library/php/blob/master/7.1/fpm/Dockerfile
FROM ddall/docker-php-base

RUN apt-get update && apt-get install -y \
    unzip \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install pdo pdo_mysql xsl json intl

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc
RUN echo 'alias go="./go.sh"' >> ~/.bashrc
RUN echo 'alias load="sf doctrine:fixtures:load && go"' >> ~/.bashrc
RUN echo 'alias dump="sf doctrine:schema:update --dump-sql"' >> ~/.bashrc
RUN echo 'alias force="sf doctrine:schema:update --force"' >> ~/.bashrc
RUN echo 'alias update="composer update -vvv && chmod 777 -R var/cache && chmod 777 -R vendor"' >> ~/.bashrc
RUN echo 'alias dge="sf doctrine:generate:entities"' >> ~/.bashrc


WORKDIR /var/www/symfony
