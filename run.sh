#!/bin/bash	
set -e

# Apache gets grumpy about PID files pre-existing
rm -f /var/run/apache2.pid

exec httpd -DFOREGROUND
