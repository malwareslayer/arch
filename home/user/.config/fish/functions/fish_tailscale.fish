function fish_tailscale -d 'Show Status Tailscale (short IPv4 only)'
  set -l socket /run/user/(id -u)/tailscale/tailscaled.sock
  set -l fqdn (tailscale --socket $socket status --json | jq -r '.Self.DNSName' 2>/dev/null | string trim -r -c '.')
    
  if test -z "$fqdn"
    set fqdn "tailscale"
  end

  set -l devices (tailscale --socket $socket status | awk '/^\s*$/ {exit} {print}')
  set -l total   (printf '%s\n' $devices | awk 'END{print NR}')
  set -l offline (printf '%s\n' $devices | grep -c 'offline')
  set -l online  (math $total - $offline)
  set -l ip4 (tailscale --socket $socket ip -4 | head -n 1)

  set -l self_online (tailscale --socket $socket status --json | jq -r '.Self.Online' 2>/dev/null)
    
  if test "$self_online" = "false"
    echo "Disconnect ($online Last Online)"
  else
    echo "$fqdn $ip4 ($online Online)"
  end
end

