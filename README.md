# winebuilder

🍷 Wine build environment with Docker

## Building Wine

```bash
# Make wine-source up-to-date
git submodule update --init
# Enter a builder
make up
make bash

# Building 64-bit wine 
cd /wine64-build
/wine-source/configure --enable-win64
make

# Building 32-bit wine
cd /wine32-build
PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig \
/wine-source/configure --with-wine64=/wine64-build
make
```

## Debugging 

### Using VNC

vnc://localhost:5901

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

### Using WSLg

[WSLg](https://github.com/microsoft/wslg) enables Wine apps with audio in WSL2 on Windows 11.
Change the `PULSE_SERVER` as follows:

```diff
--- a/docker-compose.yml
+++ b/docker-compose.yml
@@ -7,9 +7,10 @@ services:
     volumes:
       - ./wine:/wine
       - x11socket:/tmp/.X11-unix/
+      - /mnt/wslg:/mnt/wslg
     environment:
       DISPLAY: ":0"
-      PULSE_SERVER: pulseaudio:4713
+      PULSE_SERVER: /mnt/wslg/PulseServer
       WINEDLLOVERRIDES: "mscoree=d;mshtml=d"
       LANG: ja_JP.UTF-8
       TZ: Asia/Tokyo
```

### Using winedbg

```bash
make up
make bash

./wine ./programs/winedbg/winedbg.exe.so
```
