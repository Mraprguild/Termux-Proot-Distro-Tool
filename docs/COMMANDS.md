# Command Reference

## Native proot-distro

```bash
proot-distro install ubuntu:24.04 --name ubuntu
proot-distro login ubuntu
proot-distro login ubuntu -- /bin/uname -a
proot-distro list
proot-distro rename ubuntu ubuntu-dev
proot-distro backup ubuntu-dev --output ubuntu-dev.tar.xz
proot-distro restore ubuntu-dev.tar.xz
proot-distro reset ubuntu-dev
proot-distro remove ubuntu-dev
```

Run `proot-distro --help` and `proot-distro <command> --help` for the version installed on your device.

## Wrapper CLI

```bash
proot-tool menu
proot-tool install IMAGE NAME
proot-tool login NAME
proot-tool list
proot-tool run NAME COMMAND...
proot-tool backup NAME [OUTPUT]
proot-tool restore ARCHIVE
proot-tool remove NAME
proot-tool version
```
