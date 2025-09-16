#!/bin/bash

HUBSY_PATH="$HOME/hubsy"

source ~/hubsy/bin/header

read -p "Do you want to install Hubsy? (y/n): " answer

case "$answer" in
    [Yy]* )
        echo "Installation started..."

        if ! command -v gum &> /dev/null; then
            echo "gum not found. Installing..."
            sudo apt update
            sudo apt install -y gum
        else
            echo "gum already installed."
        fi

        ;;
    [Nn]* )
        echo "Installation aborted..."
        exit 0
        ;;
    * )
        echo "Invalid answer. Use y to yes or n to no."
        exit 1
        ;;
esac

echo " "
gum spin --spinner dot --title "Checking for .bash_aliases file..." -- sleep 1

if [ ! -f "$HOME/.bash_aliases" ]; then
    echo ".bash_aliases not found, creating it..."
    touch "$HOME/.bash_aliases"
fi

gum spin --spinner dot --title "Checking alias for hubsy in .bash_aliases..." -- sleep 1

if ! grep -q "alias hubsy=" "$HOME/.bash_aliases"; then
    echo "-> Adding alias for hubsy to .bash_aliases..."
    echo "alias hubsy='bash $HUBSY_PATH/bin/menu'" >> "$HOME/.bash_aliases"
else 
    echo "-> Alias for hubsy already exists in .bash_aliases"
fi

echo " "
echo " "

gum confirm "Instalation complete! Do you want to start Hubsy now?" &&

source ~/.bash_aliases && source $HUBSY_PATH/bin/hubsy