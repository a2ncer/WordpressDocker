FROM wordpress:php5.6

RUN apt-get update && apt-get install -y zlib1g zlib1g-dbg zlib1g-dev zlibc && docker-php-ext-install zip && \
    apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
	rm -rf /var/lib/apt/lists/*
RUN a2enmod ssl && a2enmod alias

COPY default-ssl.conf /tmp
COPY 000-default.conf /tmp
COPY docker-entrypoint.sh /usr/local/bin/

EXPOSE 80 443
