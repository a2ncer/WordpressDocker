# Wordpress Docker Image with SSL Support

This is a minimal wordpress image built with latest official [wordpress image](https://hub.docker.com/_/wordpress/).

## Developing with this image

If you are developing with this image, mount your local folder into the `/var/www/html` directory in the container. 
Your local changes will be reflected instantly when you refresh your page.

```
docker run --name wordpress \
           -v `pwd`/:/var/www/html \
           -p 80:80 \
           a2ncer/wordpress
```

Docker-compose example:

```
version: '2'

services:
   db:
     image: mysql:5.5
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     ports:
       - "3306:3306"
     environment:
       MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
       MYSQL_DATABASE: ${MYSQL_DATABASE}
       MYSQL_USER: ${MYSQL_USER}
       MYSQL_PASSWORD: ${MYSQL_PASSWORD}

   wordpress:
     depends_on:
       - db
     image: a2ncer/wordpress:latest
     ports:
       - "80:80"
     restart: always
     volumes:
       - ./wordpress:/var/www/html
     environment:
       WORDPRESS_DB_HOST: ${MYSQL_HOST}
       WORDPRESS_DB_USER: ${MYSQL_USER}
       WORDPRESS_DB_PASSWORD: ${MYSQL_PASSWORD}
volumes:
    db_data:

```

### SSL support

To activate ssl support add environment variable SSL_ENABLE with value `true`

In the following example, the necessary files should be mounted to the container.

```
docker run --name wordpress \
           -e SSL_ENABLE=true \
           -p 80:80 \
           -p 443:443 \
           -v $(pwd)/private.key:/etc/ssl/private/private.key \
           -v $(pwd)/cert.pem://etc/ssl/certs/cert.pem \
           -d
           a2ncer/wordpress

```
Docker-compose example with ssl support

```
version: '2'

services:
   db:
     image: mysql:5.5
     volumes:
       - db_data:/var/lib/mysql
     restart: always
     ports:
       - "3306:3306"
     environment:
       MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
       MYSQL_DATABASE: ${MYSQL_DATABASE}
       MYSQL_USER: ${MYSQL_USER}
       MYSQL_PASSWORD: ${MYSQL_PASSWORD}

   wordpress:
     depends_on:
       - db
     image: a2ncer/wordpress:latest
     ports:
       - "80:80"
     restart: always
     volumes:
       - ./wordpress:/var/www/html
       - ./private.key:/etc/ssl/private/private.key
       - ./cert.pem:/etc/ssl/certs/cert.pem
     environment:
       WORDPRESS_DB_HOST: ${MYSQL_HOST}
       WORDPRESS_DB_USER: ${MYSQL_USER}
       WORDPRESS_DB_PASSWORD: ${MYSQL_PASSWORD}
       SSL_ENABLE: true
volumes:
    db_data:
    
```    
All `http` request will be automatically redirected to `https` version of your web site.
