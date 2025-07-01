#! /usr/bin/env bash

# Create a detached session with Session name
session="Project"

SESSIONEXISTS=$(tmux list-sessions | grep $session)

# Only create tmux session if it doesn't already exist
if [ "$SESSIONEXISTS" = "" ]; then
  fzf_dir=$(
    fd . \
      --base-directory ~/Projects \
      --maxdepth 2 \
      --type d \
      --exclude .git |
      fzf \
        --ansi \
        --margin=20% \
        --border=rounded \
        --preview-window=50% \
        --preview "$HOME/scripts/preview.sh ~/Projects/{}"
  )

  if [ -n "$fzf_dir" ]; then
    dir="$HOME/Projects/$fzf_dir"
  else
    exit 1
  fi

  tmux new-session -d -s $session

  tmux rename-window -t "$session:1" 'Main'
  tmux send-keys -t "$session:1" "cd '$dir' && clear" C-m
  tmux send-keys -t "$session:1" "nvim" C-m
  tmux new-window -t "$session:2" -n "Terminal"
  tmux send-keys -t "$session:2" "cd '$dir' && clear" C-m

  tmux attach-session -t "$session:1"
else
  tmux attach-session -t "$session:1"
fi
