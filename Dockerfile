FROM ubuntu:18.04

RUN apt-get update
RUN apt-get --no-install-recommends -y install apache2
RUN /usr/sbin/a2enmod dav dav_fs include auth_digest deflate headers
RUN /usr/sbin/a2dissite 000-default

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_RUN_DIR /var/run/apache2

RUN /bin/mkdir -p /var/lock/apache2; /bin/chown www-data /var/lock/apache2
RUN /bin/mkdir -p /var/webdav; /bin/chown www-data /var/webdav

ADD webdav.conf /etc/apache2/sites-available/webdav.conf
RUN /usr/sbin/a2ensite webdav
ADD run.sh /	
RUN /bin/chmod +x /run.sh

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

VOLUME /var/webdav

CMD ["/run.sh"]
