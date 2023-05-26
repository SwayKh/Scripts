#! /bin/bash

echo " "
echo "=========Updating Linux Notes in Obsidian========="
echo " "

# Put nala history into file and trim the output to different file and then remove the original
nala history | cut -c 45- --complement | cut -c -6 --complement > "$HOME"/dotfiles/NalaHistory.md

# grep the zsh_history file for install keyword and put it in dotfiles/installed.md
cut -b 1-15 --complement "$HOME"/.zsh_history | grep -e 'install' -e 'git clone' -e 'wget' > "$HOME"/dotfiles/Installed.md

#Clean up NalaHistory and Installed with AWK
awk -i inplace '!seen[$0]++' "$HOME"/dotfiles/NalaHistory.md
awk -i inplace '!seen[$0]++' "$HOME"/dotfiles/Installed.md

# Needs to be rsynced,  symlinks don't work
rsync -avP "$HOME"/dotfiles/Installed.md "$HOME"/Obsidian/Vault/Linux
rsync -avP "$HOME"/dotfiles/NalaHistory.md "$HOME"/Obsidian/Vault/Linux


echo " "
echo "=========Updating git repository========="
echo " "

# Push the dotfiles folder
commit=$(date)
cd "$HOME"/dotfiles || exit
pwd
git add .
read -r -p "Enter a Commit: " temp
if [ "$temp" != "" ]; then
	commit=$temp
fi
echo "$commit"

git commit -m "$commit"
git push

# Push the Scripts Folder

commit=$(date)
cd "$HOME"/Scripts || exit
pwd
git add .
read -r -p "Enter a Commit: " temp
if [ "$temp" != "" ]; then
	commit=$temp
fi
echo "$commit"

git commit -m "$commit"
git push
