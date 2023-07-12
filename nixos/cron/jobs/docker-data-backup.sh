cp -r /srv /mnt/warhead/backup/docker 
&& echo "Backed up docker data!" | gotify push
|| echo "problem backing up docker data! :(" | gotify push
