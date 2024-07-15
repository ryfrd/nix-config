# homelab wakes me up 1 hour before this script runs

# pull backup from homelab
syncoid -r james@homelab:warhead/high-prio warhead/homelab-backup --delete-target-snapshots --no-privilege-elevation --sshport=97 --sshkey=/root/.ssh/id_ed25519 &&
curl -d "backup happy :)" ntfy.dymc.win/homelab ||
curl -d "backup unhappy :(" ntfy.dymc.win/homelab

# srub backup
zpool scrub warhead

# wait for scrub to finish
while zpool status warhead | grep -q "scan: *scrub in progress"; do
  echo "scrub still scrubbing"
  sleep 60
done

# send notif
curl -d "scrub finished" ntfy.dymc.win/homelab
curl -d "$(zpool status)" ntfy.dymc.win/homelab
curl -d "going to sleep" ntfy.dymc.win/homelab

# go to sleep
systemctl suspend

# homelab will wake me up in a week
