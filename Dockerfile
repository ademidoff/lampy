FROM ubuntu:14.04
MAINTAINER Alex Tymchuk <alex@visionlabs.pro>

# Use baseimage-docker's init system.
# CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
# makes nano or vim run without error
ENV TERM xterm
ENV TIMEZONE Etc/UTC

#echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/02apt-speedup
#RUN apt-get --no-install-recommends -y install pwgen

RUN echo $TIMEZONE > /etc/timezone && dpkg-reconfigure tzdata && \
    apt-get update && apt-get install -y \
    nano \
    wget \
    mysql-server \
    apache2 \
    php5 \
    php5-imap \
    php5-mcrypt \
    php5-gd \
    php5-curl \
    php5-apcu \
    php5-mysqlnd \
    php-pear && \
    pecl install channel://pecl.php.net/ssh2-0.12

# Cleanup
RUN apt-get clean && rm -rf /tmp/* /var/tmp/* 
# RUN rm -f /etc/dpkg/dpkg.cfg.d/02apt-speedup
# RUN rm -rf /var/lib/apt/lists/*
# RUN find /var/lib/apt/lists -mindepth 1 -delete -print
# RUN find /tmp /var/tmp -mindepth 2 -delete

# Cleanup the default html directory
RUN rm -rf /var/www/html && mkdir -p /var/www/html

# Give the ownership to the apache2 default user & group
RUN chown -R www-data:www-data /var/www

# Note: expires is an Apache module for caching
RUN a2enmod rewrite headers expires ssl > /dev/null

# Expose HTTP and MySQL (you can add 443 for hhtps)
EXPOSE 80

# Use supervisord to start apache / mysql
# COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
# CMD /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/bin/bash", "-c", "exec /usr/sbin/mysqld && source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"]

CMD /bin/bash
