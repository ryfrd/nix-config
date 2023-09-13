remote="james@bastion"

declare -a targets=(
    "$HOME/snik"
)

for target in "${targets[@]}"; do
    rsync -av --delete -e 'ssh -p 97' $target $remote:/home/james/backup/phalanx &&
done
