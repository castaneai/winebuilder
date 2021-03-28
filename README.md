
## Building Wine

```bash
docker-compose build
docker-compose run builder bash

CC='ccache gcc' PKG_CONFIG_PATH=/usr/lib/i386-linux-gnu/pkgconfig ./configure
make -j16 # 16: the number of processors
```

## Debugging 

### Using winedbg

```
docker-compose up -d xserver
docker-compose run builder bash

./wine ./programs/winedbg/winedbg.exe.so
```
