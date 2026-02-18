function fish_zerotier -d 'Show Interface & IPv4 address Default Node (JSON)'
  set -l peers (zerotier-cli -D/home/$USER/.local/state/zerotier-one peers -j | jq '[.[] | select(.role=="LEAF" and .isOnline==true)] | length')
  set -l total (math $peers + 1)

  echo "$total Online"
end

