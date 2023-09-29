rsync -av --delete -e 'ssh -p 97' /home/james/backup/keep/pics james@keep:/mnt/warhead/pics
rsync -av --delete -e 'ssh -p 97' /home/james/backup/keep/docs james@keep:/mnt/warhead/docs
rsync -av --delete -e 'ssh -p 97' /home/james/backup/keep/docker james@keep:/home/james/docker
rsync -av --delete -e 'ssh -p 97' /home/james/backup/phalanx/docker james@phalanx:/home/james/docker
