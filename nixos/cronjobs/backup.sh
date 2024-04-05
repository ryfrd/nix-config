# pass directories to be backed up to hetzner as arguments eg.
# sh backup.sh /home/james/pics /mnt/data/films

remote="u370354@u370354.your-storagebox.de"
i=1
for dir in "$@" 
do
    rsync -a --delete -e 'ssh -p 23' $dir $remote:/home ||
    #curl -d "back up of $dir to $remote failed" https://ntfy.dymc.win/homelab
    xmppc --jid "alerts@chat.dymc.win" --pwd "!JKcaFp2CxQVK6b" --mode message chat "james@chat.dymc.win" "back up of $dir to $remote failed"
    i=$((i + 1))
done
