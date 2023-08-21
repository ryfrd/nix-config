mount="/mnt/warhead"

btrfs scrub start $mount &&
gotify push "scrub on $mount completed" ||
gotify push "scrub on $mount failed"

btrfs balance start -musage=30 -dusage=50 $mount && 
gotify push "balance on $mount completed" ||
gotify push "balance on $mount failed"
