mount="/mnt/warhead"

btrfs scrub start $mount &&
btrfs balance start -musage=30 -dusage=50 $mount
