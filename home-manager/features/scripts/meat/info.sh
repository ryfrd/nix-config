bri=$(light)
bat=$(cat /sys/class/power_supply/BAT0/capacity)
vol=$(pamixer --get-volume)
time=$(date +'%H:%M')

info="time - $time\nbat - $bat%\nbri - $bri%\nvol - $vol%"

echo -e "$info" | wofi --show=dmenu --prompt="info"
