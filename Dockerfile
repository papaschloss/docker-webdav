FROM ubuntu:18.04

RUN apt-get update
RUN apt-get --no-install-recommends -y -v --no-cache install \
  apache2 apache2-utils
RUN apt-get autoremove -y && rm -rf /var/lib/apt/lists/*

RUN a2enmod dav dav_fs include
RUN a2dissite 000-default

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN mkdir -p /var/lock/apache2; chown www-data /var/lock/apache2
RUN mkdir -p /var/webdav; chown www-data /var/webdav

ADD webdav.conf /etc/apache2/sites-available/webdav.conf
RUN a2ensite webdav
ADD run.sh /	
RUN chmod +x /run.sh

EXPOSE 80

VOLUME /var/webdav

CMD ["/run.sh"]
