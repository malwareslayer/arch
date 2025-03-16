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
sudo homectl update $USER --capability-ambient-set="cap_dac_override cap_net_bind_service cap_net_admin cap_net_raw cap_sys_nice cap_sys_resource cap_sys_time cap_perfmon cap_bpf"
```

```
sudo homectl update malwareslayer \
             --setenv="AMD_VULKAN_ICD=RADV" \
             --setenv="DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1" \
             --setenv="GALLIUM_DRIVER=zink" \
             --setenv="GDK_BACKEND=wayland" \
             --setenv="GNOME_KEYRING_CONTROL=/run/user/$(id -u)/keyring" \
             --setenv="GOBIN=$HOME/.local/bin" \
             --setenv="GOCACHE=$XDG_CACHE_HOME/go/" \
             --setenv="GOMODCACHE=$XDG_DATA_HOME/go/pkg/mod" \
             --setenv="GOPATH=$XDG_DATA_HOME/go" \
             --setenv="GRADLE_USER_HOME=/var/user/$USER/gradle" \
             --setenv="HSA_OVERRIDE_GFX_VERSION=11.0.3" \
             --setenv="GSK_RENDERER=gl" \
             --setenv="PYTORCH_ROCM_ARCH=gfx1103" \
             --setenv="LIBVA_DRIVER_NAME=radeonsi" \
             --setenv="MESA_LOADER_DRIVER_OVERRIDE=zink" \
             --setenv="QT_AUTO_SCREEN_SCALE_FACTOR=1" \
             --setenv="QT_QPA_PLATFORM=xcb;wayland" \
             --setenv="ROCM_PATH=/opt/rocm" \
             --setenv="SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh" \
             --setenv="VDPAU_DRIVER=radeonsi" \
             --setenv="VK_DRIVER_FILES=/usr/share/vulkan/icd.d/amd_pro_icd64.json:/usr/share/vulkan/icd.d/amd_pro_icd32.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json" \
             --setenv="VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_pro_icd64.json:/usr/share/vulkan/icd.d/amd_pro_icd32.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/radeon_icd.i686.json" \
             --setenv="XDG_CACHE_HOME=/var/user/$USER/cache" \
             --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
             --setenv="XDG_CONFIG_HOME=$HOME/.config" \
             --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_HOME:$XDG_DATA_HOME/flatpak/exports/share:/var/lib/flatpak/exports/share" \
             --setenv="XDG_DATA_HOME=$HOME/.local/share" \
             --setenv="XDG_RUNTIME_DIR=/run/user/$(id -u)" \
             --setenv="XDG_STATE_HOME=$HOME/.local/state" \
             --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
             --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa"
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX        /               ext4            rw,relatime,data=ordered,delalloc,discard,journal_checksum      0 1

UUID=XXXX-XXXX          /efi            vfat            rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

UUID=XXXX-XXXX          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

tmpfs                   /dev/shm        tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /run            tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           rw,relatime,size=8G 0 0

hugetlbfs               /dev/hugepages  hugetlbfs       mode=01770,gid=kvm 0 0
```
