mount="/mnt/warhead"

btrfs scrub start $mount && gotify push "scrub on $mount completed"
btrfs balance start -musage=0 -dusage=0 $mount && gotify push "balance on $mount completed"
btrfs filesystem defragment -t 32m -f $mount && gotify push "defragment on $mount completed"
fstrim $mount && gotify push "trim on $mount completed"

