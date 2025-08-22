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
    --ssh-authorized-keys="" \
    --drop-caches=true \
    --fs-type=ext4 \
    --storage=luks \
    --luks-discard=false \
    --luks-offline-discard=false \
    --luks-sector-size=4096 \
    --luks-pbkdf-type=argon2id \
    --luks-pbkdf-hash-algorithm=sha256 \
    --luks-pbkdf-memory-cost=2048M \
    --luks-pbkdf-parallel-threads 4 \
    --luks-extra-mount-options="rw,relatime,data=ordered,delalloc,commit=16,journal_ioprio=2,i_version" \
    --home-dir="/home/<user name>" \
    --image-path=/dev/nvmeXnY
```

Open
```
cryptsetup open /dev/nvmeXnYpZ home-user
```

Reformat Generated Disk With Tuning Disk

```
mkfs.ext4 -O ^64bit,^bigalloc,dir_index,dir_nlink,ea_inode,extent,fast_commit,filetype,extent,extra_isize,filetype,flex_bg,has_journal,^huge_file,large_dir,large_file,^metadata_csum,^metadata_csum_seed,^meta_bg,orphan_file,resize_inode,sparse_super,uninit_bg /dev/mapper/home-user
```

After Installation

```
sudo homectl update <user> --member-of="adm,android-sdk,audio,dbus,gdm,kvm,network,power,proc,realtime,render,rtkit,storage,tss,uuidd,video,wheel"
```

```
sudo homectl update <user> --capability-ambient-set="CAP_AUDIT_CONTROL CAP_BPF CAP_DAC_OVERRIDE CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_PERFMON CAP_SYS_NICE CAP_SYS_RESOURCE CAP_SYS_TIME"
```

```
sudo homectl update <user> \
                 --setenv="DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1" \
                 --setenv="GALLIUM_DRIVER=zink" \
                 --setenv="GDK_BACKEND=wayland" \
                 --setenv="GNOME_KEYRING_CONTROL=/run/user/60466/keyring" \
                 --setenv="GOBIN=/home/<user>/.local/bin" \
                 --setenv="GOCACHE=/home/<user>/.cache/go" \
                 --setenv="GOMODCACHE=/home/<user>/.local/share/go/pkg/mod" \
                 --setenv="GOPATH=/home/<user>/.local/share/go" \
                 --setenv="HSA_OVERRIDE_GFX_VERSION=11.0.1" \
                 --setenv="LIBGL_KOPPER_DRI2=1" \
                 --setenv="LIBVA_DRIVER_NAME=radeonsi" \
                 --setenv="MESA_LOADER_DRIVER_OVERRIDE=radeonsi" \
                 --setenv="PYTORCH_ROCM_ARCH=gfx1101" \
                 --setenv="QT_QPA_PLATFORM=wayland" \
                 --setenv="QT_QPA_PLATFORMTHEME=qt5ct" \
                 --setenv="SSH_AUTH_SOCK=/run/user/60466/gnupg/S.gpg-agent.ssh" \
                 --setenv="TZ=Asia/Jakarta" \
                 --setenv="VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json:/usr/share/vulkan/icd.d/amd_icd64.json:/usr/share/vulkan/icd.d/lvp_icd.x86_64.json:/usr/share/vulkan/icd.d/lvp_icd.i686.json:/usr/share/vulkan/icd.d/gfxstream_vk_icd.x86_64.json:/usr/share/vulkan/icd.d/gfxstream_vk_icd.i686.json" \
                 --setenv="VDPAU_DRIVER=radeonsi" \
                 --setenv="XDG_CACHE_HOME=/home/<user>/.cache" \
                 --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
                 --setenv="XDG_CONFIG_HOME=/home/<user>/.config" \
                 --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:/home/<user>/.local/share:/home/<user>/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share" \
                 --setenv="XDG_DATA_HOME=/home/<user>/.local/share" \
                 --setenv="XDG_RUNTIME_DIR=/run/user/60466" \
                 --setenv="XDG_STATE_HOME=/home/<user>/.local/state" \
                 --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
                 --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa"
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX        /               ext4            rw,relatime,data=ordered,delalloc,commit=16,journal_ioprio=2,i_version     0 1

UUID=XXXX-XXXX          /efi            vfat            rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

UUID=XXXX-XXXX          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

tmpfs                   /dev/shm        tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /run            tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           rw,relatime,size=8G 0 0
```
