FROM php:7.4-cli


COPY --from=composer /usr/bin/composer /usr/bin/composer

COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# install extensions
RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev unzip
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-install bcmath

# install PHP packages
RUN composer install
#RUN php update.php

EXPOSE 80
ENV HOST 0.0.0.0

CMD [ "php", "./goLive.php", "--web" ]