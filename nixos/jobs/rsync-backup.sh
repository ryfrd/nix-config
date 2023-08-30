remote="james@bastion"

declare -a targets=(
    "/mnt/warhead/pics"
    "/mnt/warhead/docs"
    "$HOME/docker"
)

for target in "${targets[@]}"; do
    rsync -av --delete -e 'ssh -p 97' $target $remote:/home/james/backup &&
    gotify push "backed up $target to $remote" ||
    gotify push "failed backing up $target to $remote"
done
