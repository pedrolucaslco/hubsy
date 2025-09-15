#!/bin/bash
HUBSY_PATH="$HOME/hubsy"

EDITOR=code

CHOICES=(
  "Back to menu"
  "bashrc           Runs commands automatically whenever you open a terminal."
  "bash_aliases     Add/Edit custom shortcuts for commands at .bash_aliases file."
  "configs          Edit .config/. applications files."
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 26 --header "Choose a file to setup:")

if [[ "$CHOICE" == "Back to menu"* ]] || [[ -z "$CHOICE" ]]; then
  # Don't install anything
  echo ""
elif [[ "$CHOICE" == "> All"* ]]; then
  INSTALLER_FILE=$(gum file $OMAKUB_PATH/install)

  [[ -n "$INSTALLER_FILE" ]] &&
    gum confirm "Run installer?" &&
    source $INSTALLER_FILE &&
    gum spin --spinner globe --title "Install completed!" -- sleep 3
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

  case "$INSTALLER" in
  "bashrc") INSTALLER_FILE="$HUBSY_PATH/bin/setup/bashrc.sh" ;;
  "configs") INSTALLER_FILE="$HUBSY_PATH/bin/setup/configs.sh" ;;
  "bash_aliases") INSTALLER_FILE="$HUBSY_PATH/bin/setup/bash_aliases.sh" ;;
  "dev-editor") INSTALLER_FILE="$OMAKUB_PATH/bin/omakub-sub/install-dev-editor.sh" ;;
  "web-apps") INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/select-web-apps.sh" ;;
  "dev-language") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/select-dev-language.sh" ;;
  "dev-database") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/select-dev-storage.sh" ;;
  "ollama") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-ollama.sh" ;;
  "tailscale") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-tailscale.sh" ;;
  "geekbench") INSTALLER_FILE="$OMAKUB_PATH/install/terminal/optional/app-geekbench.sh" ;;
  *) INSTALLER_FILE="$OMAKUB_PATH/install/desktop/optional/app-$INSTALLER.sh" ;;
  esac

  source $INSTALLER_FILE && gum spin --title "Opening file..." -- sleep 1
  echo " "
  echo "You opened: $CHOICE"
  echo " "
fi

clear

source $HUBSY_PATH/bin/hubsy