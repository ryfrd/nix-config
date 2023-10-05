# pass directories to be backed up to hetzner as arguments eg.
# sh backup.sh /home/james/pics /mnt/data/films

remote="u370354@u370354.your-storagebox.de";
i=1;
for dir in "$@" 
do
    rsync -a --delete -e 'ssh -p 23' $dir $remote:/home;
    i=$((i + 1));
done
