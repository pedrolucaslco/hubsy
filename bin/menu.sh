#!/bin/bash

EDITOR=code

while true; do
    scripts=($(find ~/scripts -maxdepth 1 -type f -executable))

    opcao=$(gum choose \
      "Run command..." \
      "Run scripts..." \
      "   " \
      "BRIGHTNESS =======================" \
      "   " \
      "Set Screen Britghtness to Max" \
      "Set Screen Britghtness to Min" \
      "   " \
      "SETTINGS =========================" \
      "   " \
      "Edit home.sh" \
      "Edit bashrc" \
      "Edit Aliases" \
      "Edit scripts..." \
      "Edit .configs" \
      "   " \
      "TOOLS ============================" \
      "   " \
      "Linutil — Chris Titus Tech's Linux Toolbox" \
      "   " \
      "OTHERS ===========================" \
      "   " \
      "About Hubsy" \
      "About This PC" \
      "   " \
      "Refresh Terminal" \
      "   " \
      "Exit")

    case "$opcao" in
        "==="*) ;; # ignora divisor
        "  "*) ;;  # ignora divisor

        "Edit bashrc")
            $EDITOR ~/.bashrc
            ;;

        "Edit .configs")
            $EDITOR ~/.config/.
            ;;

        "Run command...")
            return 0 2>/dev/null || break
            ;;

        "Run scripts...")
            if [ ${#scripts[@]} -eq 0 ]; then
                echo "No scripts found in ~/scripts"
                sleep 2
            else
                opcoes=("Back to menu")
                opcoes+=("${scripts[@]##*/}")

                escolha=$(printf "%s\n" "${opcoes[@]}" | gum choose)

                if [ "$escolha" = "Back to menu" ]; then
                    continue
                else 
                    bash ~/scripts/"$escolha"
                    gum confirm "Back to menu?" && continue
                fi
            fi
            ;;

        "Edit scripts...")
            $EDITOR ~/scripts/.
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

        "Edit Aliases")
            $EDITOR ~/.bash_aliases
            ;;

        "Linutil — Chris Titus Tech's Linux Toolbox")
            curl -fsSL https://christitus.com/linux | sh
            gum confirm "Back to menu?" && continue
            ;;

        "Refresh Terminal")
            source ~/.bashrc
            gum confirm "Back to menu?" && continue
            ;;

        "About This PC")
            clear
            fastfetch
            gum confirm "Back to menu?" && continue
            ;;

        "About Hubsy")
            clear
            echo "
  ╻ ╻╻ ╻┏┓ ┏━┓╻ ╻
  ┣━┫┃ ┃┣┻┓┗━┓┗┳┛
  ╹ ╹┗━┛┗━┛┗━┛ ╹ (v'"$VERSION"')
  by @pedrolucaslco 

  A lightweight Linux terminal hub designed to help new users
  quickly configure essential settings, manage scripts, and access
  useful tools for an improved user experience. Streamline setup,
  centralize your workflow, and explore powerful utilities from a
  single, easy-to-use interface.
  
  Visit my GitHub: https://github.com/pedrolucaslco
"
            gum confirm "Back to menu?" && continue
            ;;

        "Exit")
            clear 
            # echo "👋 bye"
            # exit 0
            return 0 2>/dev/null || break
            ;;
    esac
done

