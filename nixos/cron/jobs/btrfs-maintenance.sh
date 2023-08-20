mount="/mnt/warhead"

btrfs scrub start $mount && gotify push "scrub on $mount completed"
btrfs balance start -musage=30 -dusage=50 $mount && gotify push "balance on $mount completed"

