FROM wordpress:php5.6

RUN apt install -y zlib1g zlib1g-dbg zlib1g-dev zlibc && docker-php-ext-install zip
RUN a2enmod ssl && a2enmod alias

COPY default-ssl.conf /tmp
COPY 000-default.conf /tmp
COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 80 443
