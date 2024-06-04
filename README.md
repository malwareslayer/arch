# Arch Linux

Tweak & Peak Arch Linux Configuration, See Branches For Respective Devices Tweak Configuration

---

### Volume

If there's more than 1 device use stripped rather than 

```
# Physical

pvcreate --dataalignment 1M /dev/<device>

# Group

vgcreate --dataalignment 1M /dev/<device> <name>

# Logical


```

Reference:
 - 

### Partitioning Format

```
# System

mkfs.ext4 -L system -O has_journal,ext_attr,64bit,large_file,huge_file,large_dir,dir_nlink,dir_index,extent,filetype,orphan_file,resize_inode,ea_inode,extra_isize,flex_bg,metadata_csum,metadata_csum_seed,sparse_super,fast_commit,orphan_present,needs_recovery,encrypt /dev/<device>
```
