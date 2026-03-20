#!/usr/bin/env bash

command -v fzf >/dev/null || {
  echo "fzf não instalado"
  exit 1
}

container_line=$(podman container ls -a \
  --format "{{.Names}}\t{{.Status}}" | \
  fzf --prompt="Container > ")

[ -z "$container_line" ] && exit 0

container=$(echo "$container_line" | cut -f1)

action=$(printf "start\nstop\nrestart\nlogs\nbash\n" | \
  fzf --prompt="$container > ")
  
case "$action" in
  start)
    gum spin --spinner dot --title "starting the container..." -- sleep 0.5
    podman start "$container"
    ;;
  stop)
    gum spin --spinner dot --title "stopping the container..." -- sleep 0.5
    podman stop "$container"
    ;;
  restart)
    gum spin --spinner dot --title "restarting the container..." -- sleep 0.5
    podman restart "$container"
    ;;
  logs)
    gum spin --spinner dot --title "pulling log from the container..." -- sleep 0.5
    podman logs -f "$container"
    ;;
  bash)
    gum spin --spinner dot --title "entering the container..." -- sleep 0.5
    podman exec -it "$container" bash || podman exec -it "$container" sh
    ;;
esac

echo "$action completed."
echo " "