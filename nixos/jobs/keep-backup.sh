rsync -av --delete -e 'ssh -p 97' /mnt/warhead/pics james@bastion:/home/james/backup/keep
rsync -av --delete -e 'ssh -p 97' /mnt/warhead/docs james@bastion:/home/james/backup/keep
rsync -av --delete -e 'ssh -p 97' /home/james/docker james@bastion:/home/james/backup/keep
