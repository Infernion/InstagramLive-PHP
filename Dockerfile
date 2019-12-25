FROM php:7.4-cli


# add composer to image
COPY --from=composer /usr/bin/composer /usr/bin/composer

# copy source, define work directory
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp

# install extensions
RUN apt-get update && apt-get install -y zlib1g-dev libpng-dev unzip
RUN docker-php-ext-install gd
RUN docker-php-ext-install exif
RUN docker-php-ext-install bcmath

# install PHP packages
RUN composer install

# prepare for web panel usage
EXPOSE 80
ENV HOST 0.0.0.0

# run with Web Control Panel enabled
CMD [ "php", "./goLive.php", "--web" ]
