remote="james@bastion"

declare -a targets=(
    "/mnt/warhead/pics"
    "/mnt/warhead/docs"
    "$HOME/docker"
)

for target in "${targets[@]}"; do
    rsync -av --delete -e 'ssh -p 97' $target $remote:/home/james/backup/keep
done
