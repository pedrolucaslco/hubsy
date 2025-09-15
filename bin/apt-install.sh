#!/bin/bash
HUBSY_PATH="$HOME/hubsy"

fzf_args=(
  --multi
  --preview 'apt-cache show {1} 2>/dev/null | head -n 40'
  --preview-label='alt-p: toggle description, alt-j/k: scroll, tab: multi-select, F11: maximize'
  --preview-label-pos='bottom'
  --preview-window 'down:65%:wrap'
  --bind 'alt-p:toggle-preview'
  --bind 'alt-d:preview-half-page-down,alt-u:preview-half-page-up'
  --bind 'alt-k:preview-up,alt-j:preview-down'
  --color 'pointer:green,marker:green'
)

pkg_names=$(apt list 2>/dev/null | cut -d/ -f1 | tail -n +2 | fzf "${fzf_args[@]}")

if [[ -n "$pkg_names" ]]; then
  echo "$pkg_names" | tr '\n' ' ' | xargs sudo apt install -y
  $HUBSY_PATH/bin/hubsy-show-done
fi
