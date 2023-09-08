![HeaderWebInterface](https://user-images.githubusercontent.com/23568795/64644718-85070980-d3d0-11e9-83a8-034f91ee0f4f.png)
## TCPLightingWebInterface-MQTT
This docker project leverages (https://github.com/sktaylortrash/TCPLightingWebInterface-MQTT). Which is an MQTT focused fork of the fabulous TCPLightingWebInterface (https://github.com/bren1818/TCPLightingWebInterface) created by bren1818.

It removes the complicated setup of the larger project by encapsulating it in a Docker container

This fork removes cloud dependance by leveraging MQTT and is geared towards compatibility with Home Assistant (https://www.home-assistant.io/)  

#### While components like the scheduler and IFTTT endpoints are technically still available in this project. They are not configured in this version and would require additional changes to the container.

### A ready to go image is hosted on Docker Hub: 
(https://hub.docker.com/repository/docker/polargeek/tcp-lighting-web-interface-mqtt/general)

Cloning the code in this repo would only be necessary if you wanted to build your own version of the image. 

The docker-compose.yaml as shown below must be edited to match your environment. It assumes you already have a working MQTT broker in your environment.
The most important fields are:
* TCPBRIDGE_IP
* TCPBRIDGE_PORT
* MQTT_IP
* MQTT_PORT=1883
* MQTT_USERNAME
* MQTT_PASSWORD

Also if you want to expose the service on a port other than the default webserver port of 80. Change "80:80" to something like "1234:80" to make the webserver available at port 1234

### By configuring the volumes variable to point to a local copy of tcp.token. The generated token will survive container recreation and upgrades. Otherwise you will have to press the sync button to regenerate the token everytime.

```yaml
version: '3'
services:
            
  tcplights:
    image: polargeek/tcp-lighting-web-interface-mqtt:latest
    ports:
      - "80:80"
    # Mounting this single file allows the authorization token to survive container re-creation 
    volumes:
      - '/tcplights/tcp.token:/var/www/html/tcp.token' # Change as needed to point to your local volume store
    environment:
      - TCPBRIDGE_IP=172.16.33.69               # IP address of TCP Bridge/Gateway
      - TCPBRIDGE_PORT=443                       # 443 for new firmware, 80 for legacy - If you don't know, leave it at 443
      - LOCAL_URL=http://localhost               # Can be left - this is used in runSchedule to call the API
      - TOKEN_EMAIL=user@email.com               # Only needs to be changed if you are running multiple bridge instances
      - TOKEN_PASSWORD=letmein                   # Only needs to be changed if you are running multiple bridge instances
      - FADE_ON=0                                # 0/1 makes it so when lights are turned off they fade to 0 (Like Philips Bulbs)
      - FADE_OFF=0                               # 0/1 makes it so when lights are turned on they fade to their assigned value from 0 (Like Philips Bulbs)
      - TCP_TIMEZONE=America/Regina              # Enter your timezone code to use scheduling in the web app
      - TCP_LATITUDE=50.445211                   # Enter your latitude to use the Sunup/Sundown feature
      - TCP_LONGITUDE=-104.618894                # Enter your longitude to use the Sunup/Sundown feature
      - MQTT_IP=172.16.33.14                     # IP of the MQTT Server, you can use 
      - MQTT_PORT=1883                           # Port of the MQTT Server (1883 is standard)
      - MQTT_USERNAME=admin                      # Username for your MQTT server
      - MQTT_PASSWORD=zhgcfn                     # Password for your MQTT server
      - MQTT_subscriber=tcp-subscriber           # Only needs to be changed if you are running multiple bridge instances
      - MQTT_publisher=tcp-publisher             # Only needs to be changed if you are running multiple bridge instances
      - MQTT_prefix=light                        # Only needs to be changed if you are running multiple bridge instances
                                                 # Topic prefix for lights - ie light/<room-name>/<light-name>/<UniqueBulbID>
      - MQTTcontrol=tcp                         # Only needs to be changed if you are running multiple bridge instances
                                                 # Control topic identifier for host and script control ie control/<MQTT_control>
      - HA_Discovery=1                           # 0/1 Enable Home Assistant Discovery Topics
      - HASSTopic_id=homeassistant               # Only change if you have modified Home Assistants default MQTT settings
                                                 # Topic prefix for Home Assistant Discovery Topics - this must match with HASS
      - HASSOnline=homeassistant/status          # Only change if you have modified Home Assistants default MQTT settings
                                                 # Topic Home Assistant publishes to, to announce its online
      - APACHE_RUN_USER=www-data                 # Dont change unless youve modified defaults
      - APACHE_RUN_GROUP=www-data                # Dont change unless youve modified defaults
      - APACHE_LOG_DIR=/var/log/apache2          # Dont change unless youve modified defaults
      - APACHE_LOCK_DIR=/var/lock/apache2        # Dont change unless youve modified defaults
      - APACHE_PID_FILE=/var/run/apache2.pid     # Dont change unless youve modified defaults
```




