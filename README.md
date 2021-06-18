
## Building Wine

```bash
# Make wine-source up-to-date
cd ./wine
git pull origin master

# Build wine
cd ../
make build
make up
make bash

CC='ccache gcc' PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig ./configure
make -j16 # 16: the number of processors
```

## Using winetricks

```bash
make bash

winetricks ...
```

## Debugging 

### Using VNC

vnc://localhost:5900

### Using pulseaudio on host machine

Add the following line to your pulseaudio configuration file on your host machine.

```
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.0.0.0/24 auth-anonymous=1
```

Change the PulseAudio address (`PULSE_SERVER`) to that of the host machine.

```diff
--- a/docker-compose.yml
+++ b/docker-compose.yml
@@ -9,12 +9,16 @@ services:
       - x11socket:/tmp/.X11-unix/
     environment: 
       DISPLAY: ":0"
-      PULSE_SERVER: pulseaudio:4713
+      PULSE_SERVER: host.docker.internal:4713
       WINEDLLOVERRIDES: "mscoree=d;mshtml=d"
```

### Using winedbg

```bash
make up
make bash

./wine ./programs/winedbg/winedbg.exe.so
```
