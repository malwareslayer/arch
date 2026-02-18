#cluster_addr = "https://vault.malwareslayer.home.arpa"
api_addr = "https://vault.malwareslayer.home.arpa"

ui = true

storage "etcd" {
  address = "https://etcd.user.home.arpa:2379"
  etcd_api = "v3"
  tls_ca_file = "/home/user/.config/letsencrypt/live/etcd.user.home.arpa/chain.pem"
  tls_cert_file = "/home/user/.config/letsencrypt/live/etcd.user.home.arpa/fullchain.pem"
  tls_key_file = "/home/user/.config/letsencrypt/live/etcd.user.home.arpa/privkey.pem"
}

# HTTPS listener
listener "tcp" {
  address = "127.0.0.1:8200"
  tls_cert_file = "/home/user/.config/letsencrypt/live/vault.user.home.arpa/fullchain.pem"
  tls_key_file = "/home/user/.config/letsencrypt/live/vault.user.home.arpa/privkey.pem"
}

#listener "tcp" {
  #address = "[::1]:8200"
  #tls_disable = 1
#}

listener "tcp" {
  address = "[fc93:825a:fa8a:e6d2:4cea:dead:c0de:8200]:443"
  tls_cert_file = "/home/user/.config/letsencrypt/live/vault.user.home.arpa/fullchain.pem"
  tls_key_file = "/home/user/.config/letsencrypt/live/vault.user.home.arpa/privkey.pem"
}

# Enterprise license_path
# This will be required for enterprise as of v1.8
#license_path = "/etc/vault.hclic"

# Example AWS KMS auto unseal
#seal "awskms" {
#  region = "us-east-1"
#  kms_key_id = "REPLACE-ME"
#}

# Example HSM auto unseal
#seal "pkcs11" {
#  lib            = "/usr/vault/lib/libCryptoki2_64.so"
#  slot           = "0"
#  pin            = "AAAA-BBBB-CCCC-DDDD"
#  key_label      = "vault-hsm-key"
#  hmac_key_label = "vault-hsm-hmac-key"
#}
