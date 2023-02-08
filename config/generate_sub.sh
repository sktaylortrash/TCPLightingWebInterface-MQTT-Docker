#!/bin/bash
while true
do
  sleep 10s
  # This generates a new version of the listener script so newly added or removed devices are available
  echo Generating updated MQTT subscription script
  wget -q http://127.0.0.1/MQTTGenerator.php
  # This synchronizes topics with device states. If you use the web interface no MQTT data is published
  echo Publising MQTT State info
  wget -q http://127.0.0.1/mqttstate.php
  # Comment out the following two lines if not using Home Assistant Device Discovery
  echo Refreshing Home Assistant Discovery 
  wget -q http://127.0.0.1/mqttdiscovery.php
  echo Done.
  sleep 5m
done
