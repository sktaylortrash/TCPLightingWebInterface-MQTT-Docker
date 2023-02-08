#!/bin/bash
while true
do
  sleep 10s
  echo Generating updated MQTT subscription script
  wget -q http://127.0.0.1/MQTTGenerator.php
  echo Done.
  sleep 5m
done
