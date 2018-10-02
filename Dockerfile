# See https://github.com/docker-library/php/blob/master/7.1/fpm/Dockerfile
FROM ddall/docker-php-base

RUN apt-get update && apt-get install -y \
    zip unzip \
	gnupg \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
    libicu-dev \
	libfreetype6-dev libjpeg62-turbo-dev libpng-dev
	
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install pdo pdo_mysql xsl json intl zip gd

RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash - && apt-get install -y nodejs
RUN npm install --global yarn

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc
RUN echo 'alias go="./go.sh"' >> ~/.bashrc
RUN echo 'alias load="sf doctrine:fixtures:load && go"' >> ~/.bashrc
RUN echo 'alias dump="sf doctrine:schema:update --dump-sql"' >> ~/.bashrc
RUN echo 'alias force="sf doctrine:schema:update --force"' >> ~/.bashrc
RUN echo 'alias update="composer update -vvv && chmod 777 -R var/cache && chmod 777 -R vendor"' >> ~/.bashrc
RUN echo 'alias dge="sf doctrine:generate:entities"' >> ~/.bashrc

WORKDIR /var/www/symfony
