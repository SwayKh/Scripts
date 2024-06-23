# Can't put this in ~/scripts/function.sh, The shell exits with lf
lfcd_old() {
  tmp="$(mktemp)"
  lf -last-dir-path="$tmp" "$@"
  if [ -f "$tmp" ]; then
    dir="$(cat "$tmp")"
    rm -f "$tmp"
    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir" || exit
  fi
}

lfcd() {
  # `command` is needed in case `lfcd` is aliased to `lf`
  cd "$(command lf -print-last-dir "$@")"
}

yy() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

pacPreviewAll() {
  pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse
}

pacPreviewInstalled() {
  pacman -Qeq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

pacPreviewInstalledAll() {
  pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
}

rename_directories() {
  for dir in "$1"/*; do
    if [ -d "$dir" ]; then
      file=$(basename "$dir"/*)
      dir_path=$(dirname "$dir")
      mv "$dir" "$dir_path/$file"
      echo "Renamed '$dir' to '$dir_path/$file'"
    fi
  done
}

# This needs to be defined in root user.
#  recovery-pacman() {
#     pacman "$@"  \
#     --log /dev/null   \
#     --noscriptlet     \
#     --dbonly          \
#     --overwrite "*"   \
#     --nodeps          \
#     --needed
# }
