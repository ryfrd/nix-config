rsync -az --delete -e 'ssh -p 97' james@keep:/mnt/warhead/pics /home/james/backup/keep
rsync -az --delete -e 'ssh -p 97' james@keep:/mnt/warhead/docs /home/james/backup/keep
rsync -az --delete -e 'ssh -p 97' james@keep:/home/james/docker /home/james/backup/keep
rsync -az --delete -e 'ssh -p 97' james@phalanx:/home/james/docker /home/james/backup/phalanx
