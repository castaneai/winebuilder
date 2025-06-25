# winebuilder

🍷 Wine build environment with Docker

## Building Wine

```bash
# Make wine-source up-to-date
git submodule update --init
# Enter a builder
make up
make bash

# Buildig wine with new WoW64 mode
cd /wine-build
/wine-source/configure --enable-archs=x86_64,i386
make
# Start wine
./wine --version
./wine notepad
```

## Tips

### PulseAudio on host machine

Add the following line to your pulseaudio configuration file on your host machine.

```
load-module module-native-protocol-tcp auth-ip-acl=127.0.0.1;172.0.0.0/24 auth-anonymous=1
```

### WSLg

[WSLg](https://github.com/microsoft/wslg) enables Wine apps with audio in WSL2 on Windows 11.
Change the `PULSE_SERVER` as follows:

```diff
--- a/docker-compose.yml
+++ b/docker-compose.yml
     volumes:
+      - /mnt/wslg:/mnt/wslg
     environment:
-      PULSE_SERVER: host.docker.internal:4713
+      PULSE_SERVER: /mnt/wslg/PulseServer
```

### winetricks

```bash
cd /wine-build
WINE=./wine winetricks ...
```

### winedbg

```bash
cd /wine-build
./wine ./programs/winedbg/winedbg.exe
```
