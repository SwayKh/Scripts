#! /usr/bin/env bash
#
# Preview script for fzf used in various scripts

filetype=$(cliphist decode "$1" | file --mime-type -)

if [[ $filetype =~ "image" ]]; then
  cliphist decode "$1" |
    chafa -f sixels \
      -s "${FZF_PREVIEW_COLUMNS}"x"${FZF_PREVIEW_LINES}" -
else
  cliphist decode "$1" |
    bat --color=always \
      --style=numbers,grid \
      --wrap=auto \
      --theme=gruvbox-dark \
      --terminal-width "${FZF_PREVIEW_COLUMNS}"
fi
