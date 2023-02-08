#!/bin/bash

# Set up config.inc.php
sed -i "s/TCPBRIDGEIP/$TCPBRIDGE_IP/" /var/www/html/config.inc.php
sed -i "s/TCPBRIDGEPORT/$TCPBRIDGE_PORT/" /var/www/html/config.inc.php
sed -i "s|LOCALURL|$LOCAL_URL|" /var/www/html/config.inc.php
sed -i "s|TOKENEMAIL|$TOKEN_EMAIL|" /var/www/html/config.inc.php
sed -i "s/TOKENPASSWORD/$TOKEN_PASSWORD/" /var/www/html/config.inc.php
sed -i "s/FADEON/$FADE_ON/" /var/www/html/config.inc.php
sed -i "s/FADEOFF/$FADE_OFF/" /var/www/html/config.inc.php
sed -i "s|TCPTIMEZONE|$TCP_TIMEZONE|" /var/www/html/config.inc.php
sed -i "s/TCPLATITUDE/$TCP_LATITUDE/" /var/www/html/config.inc.php
sed -i "s/TCPLONGITUDE/$TCP_LONGITUDE/" /var/www/html/config.inc.php
sed -i "s/MQTTIP/$MQTT_IP/" /var/www/html/config.inc.php
sed -i "s/MQTTPORT/$MQTT_PORT/" /var/www/html/config.inc.php
sed -i "s/MQTTUSER/$MQTT_USERNAME/" /var/www/html/config.inc.php
sed -i "s/MQTTPASS/$MQTT_PASSWORD/" /var/www/html/config.inc.php
sed -i "s|MQTTSubscriber|$MQTT_Subscriber|" /var/www/html/config.inc.php
sed -i "s|MQTTPublisher|$MQTT_Publisher|" /var/www/html/config.inc.php
sed -i "s|MQTTPrefix|$MQTT_prefix|" /var/www/html/config.inc.php
sed -i "s|MQTTControl|$MQTTcontrol|" /var/www/html/config.inc.php
sed -i "s|HADiscovery|$HA_Discovery|" /var/www/html/config.inc.php
sed -i "s|HASSTopicID|$HASSTopic_id|" /var/www/html/config.inc.php
sed -i "s|HASSOnlineTopic|$HASSOnline|" /var/www/html/config.inc.php

#Create Token and logs
/var/www/html/setup.sh
#Start Apache
/usr/sbin/apache2ctl -D FOREGROUND &
/tmp/generate_sub.sh &
/tmp/run_sub.sh 
