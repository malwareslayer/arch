function fish_zerotier -d 'Show Interface & Address Default Node'
    zerotier-cli -D/home/$USER/.local/lib/zerotier-one listnetworks | awk '/node-zero/ {print $8, $9}'
end
