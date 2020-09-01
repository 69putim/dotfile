#!/bin/bash

DOTFILES_PATH=~/dotfiles

#リンクを貼らないディレクトリ・ファイル
for f in .??*
do
 ["$f" = ".git"] && continue
 ["$f" = ".DS_Store"] && continue

 ln -snfv "$DOTFILES_PATH/$f" "$HOME/$f"
done
