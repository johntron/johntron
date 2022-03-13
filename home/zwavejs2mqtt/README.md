* Connect Aeotec Zstick to USB port of Raspberry Pi
* Install any OS that can run Docker
* Run zwavejs2mqtt:

```
docker run -d -p 80:8091 -p 3000:3000 --restart unless-stopped --device=/dev/ttyACM0 -v $(pwd)/store:/usr/src/app/store zwavejs/zwavejs2mqtt:latest
```
