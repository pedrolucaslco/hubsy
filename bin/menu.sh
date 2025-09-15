#!/bin/bash
HUBSY_PATH="$HOME/hubsy"

EDITOR=code

while true; do
    scripts=($(find ~/scripts -maxdepth 1 -type f -executable))

    opcao=$(gum choose --header "Select an option with the arrow keys or type / to search by name" \
      "Terminal" \
      "Scripts" \
      "Install Apt Packages" \
      "Setup" \
      "Refresh Terminal" \
      "   " \
      "== TUI — Terminal Apps " \
      "Lazydocker — A simple terminal UI for docker" \
      "Btop — Resource Monitor" \
      "   " \
      "== Third Party Tools" \
      "Linutil — Chris Titus Tech's Linux Toolbox" \
      "   " \
      "== About" \
      "About This PC" \
      "About Hubsy" \
      "   " \
      "   " \
      "Exit Hubsy" \
      "   ")

    #   "== HUBSY DEBUG" \
    #   "Set Screen Britghtness to Max" \
    #   "Set Screen Britghtness to Min" \
    #   "Set all bin files as executable" \
    #   "Hubsy Dev Enviropment" \

    case "$opcao" in
        *"==="*) ;; # ignora divisor
        *"   "*) ;;  # ignora divisor 

        "Install Apt Packages")
            $HUBSY_PATH/bin/apt-install.sh
            gum confirm "Back to menu?" && continue
            ;;

        "Hubsy Dev Enviropment")
            gum spin --spinner dot --title "Opening Hubsy Development Enviropment..." -- sleep 1
            code $HUBSY_PATH
            gum confirm "Back to menu?" && continue
            ;;

        "Terminal")
            clear 
            echo "Opening a new terminal..."
            echo ""
            echo "To return do Hubsy, type 'hubsy' and press Enter."
            echo ""
            return 0 2>/dev/null || break
            ;;

        "Scripts")
            if [ ${#scripts[@]} -eq 0 ]; then
                echo "No scripts found in ~/scripts"
                sleep 2
            else
                options=("Back to menu")
                options+=("Edit scripts...")
                options+=("${scripts[@]##*/}")

                scriptchoice=$(printf "%s\n" "${options[@]}" | gum choose)

                if [ "$scriptchoice" = "Back to menu" ]; then
                    continue
                elif [ "$scriptchoice" = "Edit scripts..." ]; then
                    gum spin --spinner dot --title "Opening scripts folder..." -- sleep 1
                    $EDITOR ~/scripts/.
                    continue
                else 
                    bash ~/scripts/"$scriptchoice"
                    gum confirm "Back to menu?" && continue
                fi
            fi
            ;;

        "Setup")
            $HUBSY_PATH/bin/setup.sh
;;
        
        *"Lazydocker — A simple terminal UI for docker")
            if ! command -v lazydocker &> /dev/null; then
                echo "Lazydocker is not installed. Please install it first."
                sleep 2
            else
                lazydocker
                gum confirm "Back to menu?" && continue
            fi
            ;;

        *"Btop — Resource Monitor")
            if ! command -v btop &> /dev/null; then
                echo "Btop is not installed. Please install it first."
                sleep 2
            else
                btop
                gum confirm "Back to menu?" && continue
            fi
            ;;

        *"Set Screen Britghtness to Max")
            sudo brightnessctl set 70% -q
            echo "🔆 Brightness set to 70%"
            gum confirm "Back to menu?" && continue
            ;;

        *"Set Screen Britghtness to Min")
            sudo brightnessctl set 1% -q
            echo "🌑 Brightness set to 1%"
            gum confirm "Back to menu?" && continue
            ;;

        *"Linutil — Chris Titus Tech's Linux Toolbox")
            curl -fsSL https://christitus.com/linux | sh
            gum confirm "Back to menu?" && continue
            ;;

        "Refresh Terminal")
            gum spin --spinner dot --title "Refreshing terminal..." -- sleep 1
            
            [ -f ~/.bashrc ] && source ~/.bashrc
            [ -f ~/.bash_aliases ] && source ~/.bash_aliases
            exec "$SHELL"
            ;;

        *"About This PC")
            clear
            fastfetch
            gum confirm "Back to menu?" && continue
            ;;

        *"About Hubsy")
            clear
            source $HUBSY_PATH/bin/header.sh
            echo " "
            cat $HUBSY_PATH/description
            echo " "
            echo "Visit my GitHub: https://github.com/pedrolucaslco"
            echo " "
            gum confirm "Back to menu?" && continue
            ;;


        "Set all bin files as executable")
            find "$HUBSY_PATH/bin" -type f -exec sudo chmod +x {} \;
            gum confirm "Back to menu?" && continue
            ;;
        "Exit Hubsy")
            clear 
            # echo "👋 bye"
            # exit 0
            return 0 2>/dev/null || break
            ;;
    esac
done
