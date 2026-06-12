# winebuilder

🍷 Wine build environment with Docker

## Building Wine

```bash
# Make wine-source up-to-date
git submodule update --init
# Enter a builder
make up
make bash
```

### x86_64 host (new WoW64 mode)

```bash
cd /wine-build
/wine-source/configure --enable-archs=x86_64,i386
make -j$(nproc)
# Start wine
./wine --version
./wine notepad
```

### ARM64 host (Apple Silicon / aarch64 Linux)

Builds Wine with ARM64EC and uses [FEX](https://fex-emu.com/) as the x86 / x86-64
emulator, so that x86 / x86-64 Windows apps run on ARM64 hosts.
The image ships llvm-mingw (required for arm64ec; GCC cannot build it) and the
FEX backend DLLs (`fex-emu-wine` package).

```bash
cd /wine-build
/wine-source/configure --enable-archs=i386,x86_64,arm64ec,aarch64
make -j$(nproc)
```

If configure shows `arm64ec_CC: false`, llvm-mingw is missing from PATH
(preinstalled at `/opt/llvm-mingw/bin` in the image).

The bundled `xtajit64.dll` is a stub (`x64 emulation not implemented`) and
`xtajit.dll` (32bit backend) is not built at all, so place the FEX DLLs:

```bash
mkdir -p /wine-build/dlls/xtajit/aarch64-windows
cp /usr/lib/wine/aarch64-windows/libwow64fex.dll   /wine-build/dlls/xtajit/aarch64-windows/xtajit.dll
cp /usr/lib/wine/aarch64-windows/libarm64ecfex.dll /wine-build/dlls/xtajit64/aarch64-windows/xtajit64.dll
```

Note: re-running `make` restores the stubs, so copy them again after a rebuild.

```bash
./wine --version
./wine path/to/some_x86_app.exe
```

#### Page size notes (Apple Silicon)

The kernel page size depends on the VM (check with `getconf PAGE_SIZE` in the
container): OrbStack uses 4KB pages, while Asahi Linux and some VMs use 16KB.
On 4KB-page kernels there is no page-size issue. Wine 11 runs most apps on
16KB-page kernels too, but apps that strictly depend on 4KB physical pages
(guard pages, fine-grained memory protection) still fail; those need
[muvm](https://github.com/AsahiLinux/muvm) (a lightweight VM with a 4KB-page
guest).

For GPU acceleration of 32bit apps, the Vulkan driver must support
`VK_EXT_map_memory_placed` (Wine supports it since 9.4).

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
