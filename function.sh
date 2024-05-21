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
