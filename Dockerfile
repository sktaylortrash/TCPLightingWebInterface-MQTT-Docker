FROM php:7.4-apache
RUN  apt-get update \
  && apt-get install -y wget python3-pip \
  && rm -rf /var/lib/apt/lists/*
RUN pip3 install paho-mqtt
RUN pip3 install requests

# Expose apache port
EXPOSE 80

# Copy project files.
ADD www /var/www/html
run chown -R www-data:www-data "/var/www/html"
run chmod -R 755 "/var/www/html"

# Add apache config
ADD config/site-config.conf /etc/apache2/sites-enabled/000-default.conf

# Move the startup scripts over, which:
#  Set up the config files, the MQTT processes, and start apache in the foreground.
ADD config/boot.sh /tmp/boot.sh
ADD config/generate_sub.sh /tmp/generate_sub.sh
ADD config/run_sub.sh /tmp/run_sub.sh
run chmod 777 "/tmp/boot.sh"
run chmod 777 "/tmp/generate_sub.sh"
run chmod 777 "/tmp/run_sub.sh"
run chmod 777 "/var/www/html/setup.sh"

# Start Container
CMD /tmp/boot.sh