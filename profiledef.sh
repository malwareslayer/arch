#!/usr/bin/env bash
# shellcheck disable=SC2034

iso_name="archlinux"
iso_label="ARCH_$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y%m)"
iso_publisher="Arch Linux <https://archlinux.org>"
iso_application="Arch Linux Live/Rescue DVD"
iso_version="$(date --date="@${SOURCE_DATE_EPOCH:-$(date +%s)}" +%Y.%m.%d)"
install_dir="arch"
buildmodes=('iso')
bootmodes=('uefi.systemd-boot')
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '16' '-b' '1M' '-noappend' '-always-use-fragments')
file_permissions=(
  ["/etc/shadow"]="0:0:400"
  ["/etc/systemd/tpm2-pcr-private-key.pem"]="0:0:600"
  ["/etc/systemd/tpm2-pcr-public-key.pem"]="0:0:644"
  ["/root"]="0:0:750"
)

