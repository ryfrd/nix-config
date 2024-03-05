docker exec -it mastodon-web-1 tootctl media remove --days 1
docker exec -it mastodon-web-1 tootctl media remove --days 1 --prune-profiles
docker exec -it mastodon-web-1 tootctl media remove --days 1 --remove-headers
docker exec -it mastodon-web-1 tootctl preview_cards remove --days 1
