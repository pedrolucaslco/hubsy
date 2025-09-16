#!/bin/bash
# This boot script will be executed as raw file directly from curl easy install 
# command.

hubsy_logo='   
╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
┣━┫┃ ┃┣┻┓┗━┓┗┳┛
╹ ╹┗━┛┗━┛┗━┛ ╹ 
'

clear

echo -e "\n$hubsy_logo\n"

# Dependencies

sudo apt install -y git

# Variables

HUBSY_REPO="${pedrolucaslco/hubsy}"
HUBSY_REF="${main}"
HUBSY_PATH=~/hubsy
# Future path:
# HUBSY_PATH=~/.local/share/hubsy

echo -e "\nCloning Hubsy from: https://github.com/${HUBSY_REPO}.git"
# rm -rf $HUBSY_PATH
# git clone "https://github.com/${HUBSY_REPO}.git" $HUBSY_PATH >/dev/null

echo -e "\nInstallation starting..."
source $HUBSY_PATH/bin/install.sh