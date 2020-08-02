#!/bin/sh	
set -e

apt-get update && apt-get upgrade 
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2/apache2.pid

/usr/sbin/apache2ctl -D FOREGROUND
