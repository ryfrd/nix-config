remote="u370354@u370354.your-storagebox.de";
i=1;
for dir in "$@" 
do
    rsync -caz --delete -e 'ssh -p 23' $dir $remote:/home;
    i=$((i + 1));
done
