FROM ubuntu:12.04
MAINTAINER Kittithorn nakarb

VOLUME ["/var/www"]

RUN apt-get update && \
    apt-get install -y \
      apache2 \
      php5 \
      php5-cli \
      libapache2-mod-php5 \
      php5-gd \
      php5-ldap \
      php5-mysql \
      php5-pgsql

COPY apache_default /etc/apache2/sites-available/default
COPY run /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2ensite default-ssl

RUN sed -ri 's/^display_errors\s*=\s*On/display_errors = Off/g' /etc/php5/apache2/php.ini
RUN sed -ri 's/^AllowOverride\s*=\s*None/AllowOverride = All/g' /etc/php5/apache2/php.ini

RUN service apache2 restart


EXPOSE 80 443
CMD ["/usr/local/bin/run"]
