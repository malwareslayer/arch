# Setup

## File System

```
mkfs.fat -F 32 /dev/nvmeXnYpZ
```

**Note**: some `/boot` should be for bootable extended

### File System Root & User

For `<username>`

```
homectl create <username> \
    --real-name="" \
    --email-addres="" \
    --location="Asia/Jakarta" \
    --timezone="Asia/Jakarta" \
    --shell="/usr/bin/fish" \
    --drop-caches=true \
    --fs-type=ext4 \
    --storage=luks \
    --luks-discard=true \
    --luks-offline-discard=true \
    --luks-sector-size=512 \
    --luks-pbkdf-type=argon2id \
    --luks-pbkdf-hash-algorithm=sha256 \
    --luks-pbkdf-memory-cost=512M \
    --luks-pbkdf-parallel-threads 4 \
    --home-dir="/home/<user name>" \
    --image-path=/dev/nvmeXnY
```

After Installation

```
sudo homectl update $USER --member-of="adm android-sdk audio dbus kvm network power proc realtime render rtkit storage uuidd video wheel"
```

```
sudo homectl update $USER --capability-ambient-set="cap_dac_override cap_net_bind_service cap_net_admin cap_net_raw cap_ipc_lock cap_sys_nice cap_sys_resource cap_sys_time cap_audit_control cap_perfmon cap_bpf"
```

```
sudo homectl update malwareslayer \
    --setenv="GALLIUM_DRIVER=zink" \
    --setenv="GDK_BACKEND=wayland" \
    --setenv="GNOME_KEYRING_CONTROL=/run/user/60466/keyring" \
    --setenv="GOBIN=/home/malwareslayer/.local/bin" \
    --setenv="GOCACHE=/var/user/malwareslayer/cache/go/" \
    --setenv="GOMODCACHE=/home/malwareslayer/.local/share/go/pkg/mod" \
    --setenv="GOPATH=/home/malwareslayer/.local/share/go" \
    --setenv="GRADLE_USER_HOME=/var/user/malwareslayer/gradle" \
    --setenv="HSA_OVERRIDE_GFX_VERSION=11.0.3" \
    --setenv="LIBVA_DRIVER_NAME=radeonsi" \
    --setenv="MESA_LOADER_DRIVER_OVERRIDE=zink" \
    --setenv="PYTORCH_ROCM_ARCH=gfx1103" \
    --setenv="QT_AUTO_SCREEN_SCALE_FACTOR=1" \
    --setenv="QT_QPA_PLATFORM=wayland;xcb" \
    --setenv="ROCM_PATH=/opt/rocm" \
    --setenv="SSH_AUTH_SOCK=/run/user/60466/gnupg/S.gpg-agent.ssh" \
    --setenv="VDPAU_DRIVER=radeonsi" \
    --setenv="VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json" \
    --setenv="VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json" \
    --setenv="XDG_CACHE_HOME=/var/user/malwareslayer/cache" \
    --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
    --setenv="XDG_CONFIG_HOME=/home/malwareslayer/.config" \
    --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:/home/malwareslayer/.local/share:/home/malwareslayer/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share" \
    --setenv="XDG_DATA_HOME=/home/malwareslayer/.local/share" \
    --setenv="XDG_RUNTIME_DIR=/run/user/60466" \
    --setenv="XDG_STATE_HOME=/home/malwareslayer/.local/state" \
    --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
    --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa"
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX        /               ext4            rw,relatime,data=ordered,delalloc,discard      0 1

UUID=XXXX-XXXX          /efi            vfat            rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

UUID=XXXX-XXXX          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

tmpfs                   /dev/shm        tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /run            tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           rw,relatime,size=8G 0 0
```
