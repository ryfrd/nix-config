gotify push "/dev/sdb $(smartctl -H /dev/sdb | tail -n 2)" 
gotify push "/dev/sda $(smartctl -H /dev/sda | tail -n 2)" 
