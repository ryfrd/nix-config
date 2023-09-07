# pull image for all active podman containers

# grab images from podman ps and write to temp file
podman ps | tail -n +2 | awk '{print $2}' > /tmp/images.txt

# loop through temp file and pull images
while read -r line
do
  podman pull "$line"
done < /tmp/images.txt
