repo_url=$(docker inspect "jellyfin" --format='{{.Config.Image}}')
local_hash=$(docker image inspect "$repo_url" --format '{{.RepoDigests}}')

echo $local_hash
