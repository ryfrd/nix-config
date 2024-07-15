target_mac="6c:2b:59:47:92:3e"
wol $target_mac &&
curl -d "waking up backup machine" ntfy.dymc.win/homelab ||
curl -d "problem waking up backup machine" ntfy.dymc.win/homelab
