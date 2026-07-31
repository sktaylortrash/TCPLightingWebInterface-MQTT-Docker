![HeaderWebInterface](https://user-images.githubusercontent.com/23568795/64644718-85070980-d3d0-11e9-83a8-034f91ee0f4f.png)
## TCPLightingWebInterface-MQTT
This docker project leverages [https://github.com/sktaylortrash/TCPLightingWebInterface-MQTT](https://github.com/sktaylortrash/TCPLightingWebInterface-MQTT). Which is an MQTT focused fork of the fabulous TCPLightingWebInterface [https://github.com/bren1818/TCPLightingWebInterface](https://github.com/bren1818/TCPLightingWebInterface) created by bren1818.

It removes the complicated setup of the larger project by encapsulating it in a Docker container

This fork removes cloud dependance by leveraging MQTT and is geared towards compatibility with Home Assistant [https://www.home-assistant.io/](https://www.home-assistant.io/)  

#### While components like the scheduler and IFTTT endpoints are technically still available in this project. They are not configured in this version and would require additional changes to the container.

### A ready to go image is hosted on Docker Hub: 
[https://hub.docker.com/repository/docker/polargeek/tcp-lighting-web-interface-mqtt](https://hub.docker.com/repository/docker/polargeek/tcp-lighting-web-interface-mqtt/general)

Cloning the code in this repo would only be necessary if you wanted to build your own version of the image. 


## Quick Start Guide

Two docker-compose files are made available:
* [docker-compose.yml](https://raw.githubusercontent.com/sktaylortrash/TCPLightingWebInterface-MQTT-Docker/main/docker-compose.yml)
* [docker-compose-with-mqtt.yml](https://raw.githubusercontent.com/sktaylortrash/TCPLightingWebInterface-MQTT-Docker/main/docker-compose-with-mqtt.yml)

The first contains only a container for this interface and assumes you have a functioning MQTT broker in place. 
While the second includes an MQTT broker with the lighting interface dependant on it being up and running prior to starting.

1. Select the version that is most appropriate to your configuration.
2. Either add the contents to an existing docker-compose.yml file or copy the example here to a new location
3. For the interface only create a sub-directory called **tcplights** and if using the broker version also create **mosquitto** in the directory where your docker-compose.yml resides
4. create a blank file in **tcplights** called ***tcp.token***  (if you don't create a permanent token file the bridge will have to be re-paired on every restart of the container)
5. Edit at minimum the variables described below
    - TCPBRIDGE_IP
    - TCPBRIDGE_PORT
    - MQTT_IP
    - MQTT_PORT=1883
    - MQTT_USERNAME
    - MQTT_PASSWORD
6. If using the version with the MQTT Broker you will need to setup Mosquitto first. This guide [From Home Automation Guy](https://www.homeautomationguy.io/blog/docker-tips/configuring-the-mosquitto-mqtt-docker-container-for-use-with-home-assistant) should contain the information you need
7. Put your bridge in pairing mode
8. Start the container with  *docker-compose up -d*

If you want to expose the service on a port other than the default webserver port of 80. Change "80:80" in docker-compose.yml to something like "1234:80" to make the webserver available at port 1234


## Room Light Groups
If you have multiple lights in a single room and group them in Home Assistant. You will find that they turn on in sequence rather than all at once. This is know as the "Popcorn Effect". While rooms are not exposed to Home Assistant Autodiscovery, they do exist and are fully useable as a single light. If you wish to use them you must define them manually in configuration.yaml like the example shown below.

```yaml
mqtt:
  light:
    - unique_id: "LivingRoom"
      name: "LivingRoom"
      state_topic: "light/LivingRoom/1/status"
      command_topic: "light/LivingRoom/1/switch"
      brightness_command_topic: "light/LivingRoom/1/brightness/set"
      brightness_state_topic: "light/LivingRoom/1/brightness"
      brightness_scale: 100
      payload_on: "1"
      payload_off: "0"
      optimistic: false
      device:
        identifiers: ["room1"]
        name: "Living Room"
        manufacturer: "TCP"
        model: "TCP Room"
```
