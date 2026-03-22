# Setup

## File System

```
mkfs.fat -F 32 /dev/nvmeXnYpZ
```

**Note**: some `/boot` should be for bootable extended

### File System Root & User

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
    --luks-discard=false \
    --luks-offline-discard=false \
    --luks-sector-size=4096 \
    --luks-pbkdf-type=argon2id \
    --luks-pbkdf-hash-algorithm=sha256 \
    --luks-pbkdf-memory-cost=2048M \
    --luks-pbkdf-parallel-threads 4 \
    --luks-extra-mount-options="rw,relatime,data=ordered,delalloc,commit=16,journal_ioprio=2" \
    --home-dir="/home/<username>" \
    --image-path=/dev/nvmeXnY
```

Open
```
cryptsetup open /dev/nvmeXnYpZ home-<username>
```

Reformat Generated Disk With Tuning Disk

```
mkfs.ext4 -O ^64bit,^bigalloc,dir_index,dir_nlink,ea_inode,extent,ext_attr,fast_commit,filetype,extra_isize,flex_bg,has_journal,^huge_file,large_dir,large_file,^metadata_csum,^metadata_csum_seed,^meta_bg,orphan_file,resize_inode,sparse_super,stable_inodes,uninit_bg /dev/mapper/home-user
```

After Installation

```
sudo homectl update <username> --member-of="adm,android-sdk,audio,dbus,disk,games,gdm,kvm,locate,mem,network,power,proc,realtime,render,rtkit,seat,sgx,storage,tss,tty,uuidd,video,wheel"
```

```
sudo homectl update <username> --capability-ambient-set="cap_dac_override cap_kill cap_ipc_owner cap_sys_chroot cap_lease cap_audit_control cap_net_broadcast cap_net_admin cap_net_raw cap_ipc_lock cap_perfmon cap_bpf cap_setfcap cap_wake_alarm cap_setpcap cap_net_bind_service cap_sys_nice cap_sys_resource cap_sys_pacct cap_sys_admin cap_sys_time cap_sys_tty_config"
```

```
sudo homectl update <user> \
                 --setenv="DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1" \
                 --setenv="GALLIUM_DRIVER=zink" \
                 --setenv="GDK_BACKEND=wayland" \
                 --setenv="GNOME_KEYRING_CONTROL=/run/user/60466/keyring" \
                 --setenv="GOBIN=/home/<username>/.local/bin" \
                 --setenv="GOCACHE=/home/<username>/.cache/go" \
                 --setenv="GOMODCACHE=/home/<username>/.local/share/go/pkg/mod" \
                 --setenv="GOPATH=/home/<username>/.local/share/go" \
                 --setenv="HSA_OVERRIDE_GFX_VERSION=11.0.1" \
                 --setenv="LIBGL_KOPPER_DRI2=1" \
                 --setenv="LIBVA_DRIVER_NAME=radeonsi" \
                 --setenv="MESA_LOADER_DRIVER_OVERRIDE=radeonsi" \
                 --setenv="PYTORCH_ROCM_ARCH=gfx1101" \
                 --setenv="QT_QPA_PLATFORM=wayland" \
                 --setenv="QT_QPA_PLATFORMTHEME=qt5ct" \
                 --setenv="SSH_AUTH_SOCK=/run/user/60466/gnupg/S.gpg-agent.ssh" \
                 --setenv="TZ=Asia/Jakarta" \
                 --setenv="VK_DRIVER_FILES=/usr/share/vulkan/icd.d/radeon_icd.json:/usr/share/vulkan/icd.d/lvp_icd.json" \
                 --setenv="VDPAU_DRIVER=radeonsi" \
                 --setenv="XDG_CACHE_HOME=/home/<username>/.cache" \
                 --setenv="XDG_CONFIG_DIRS=/etc/xdg" \
                 --setenv="XDG_CONFIG_HOME=/home/<username>/.config" \
                 --setenv="XDG_DATA_DIRS=/usr/share:/usr/local/share:/home/<username>/.local/share:/home/<username>/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share" \
                 --setenv="XDG_DATA_HOME=/home/<username>/.local/share" \
                 --setenv="XDG_RUNTIME_DIR=/run/user/60466" \
                 --setenv="XDG_STATE_HOME=/home/<username>/.local/state" \
                 --setenv="__EGL_VENDOR_LIBRARY_FILENAMES=/usr/share/glvnd/egl_vendor.d/50_mesa.json" \
                 --setenv="__GLX_VENDOR_LIBRARY_NAME=mesa"
```

## File System Table

```
# Static information about the filesystems.
# See fstab(5) for details.

# <file system> <dir> <type> <options> <dump> <pass>

UUID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX        /               ext4            rw,relatime,data=ordered,delalloc,commit=16,journal_ioprio=2     0 1

UUID=XXXX-XXXX          /efi            vfat            rw,relatime,fmask=0137,dmask=0027,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

UUID=XXXX-XXXX          /boot           vfat            rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,utf8,errors=remount-ro   0 2

tmpfs                   /dev/shm        tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /run            tmpfs           rw,relatime,size=16G 0 0

tmpfs                   /tmp            tmpfs           rw,relatime,size=8G 0 0
```
