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
  echo ""
else
  CHOICE=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

  case "$CHOICE" in
  *) CHOICE_FILE="$HUBSY_PATH/bin/setup/$CHOICE" ;;
  esac

  source $CHOICE_FILE && gum spin --title "Opening file..." -- sleep 1
  echo " "
  echo "You opened: $CHOICE"
  echo " "
fi