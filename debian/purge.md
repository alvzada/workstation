# Purge residual configuration files:

``# apt-get purge $(dpkg -l | awk '/^rc/ { print $2 }')``
