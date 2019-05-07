#!/bin/bash	
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2.pid

/usr/sbin/apache2 -D FOREGROUND
