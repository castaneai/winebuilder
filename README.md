
## Building Wine

```bash
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

### Using winedbg

```bash
make up
make bash

./wine ./programs/winedbg/winedbg.exe.so
```
