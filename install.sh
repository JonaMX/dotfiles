#!/bin/bash

VIM_DIRECTORY="${HOME}/.vim"

function die()
{
  echo "${@}"
  exit 1
}

link() {
    # Force create/replace the symlink.
    ln -fs "${VIM_DIRECTORY}/${1}" "${HOME}/${2}"
}

rm -rf ~/.vim.old
# Add .old to any existing Vim file in the home directory
for filepath in "${HOME}/.vim" "${HOME}/.vimrc" "${HOME}/.gvimrc"; do
  if [ -e $filepath ]; then
    mv "${filepath}" "${filepath}.old" || die "Could not move ${filepath} to ${filepath}.old"
    echo "${filepath} has been renamed to ${filepath}.old"
  fi
done

# Clone Neovim dotfiles into .vim
git clone https://github.com/jonamx/dotfiles.git "${HOME}/.vim" \
  || die "Could not clone the repository to ${HOME}/.vim"

cd "${HOME}/.vim" || die "Could not go into the ${HOME}/.vim"

link "vim/vimrc"    ".vimrc"
link "autoload" "~/.config/nvim/autoload"
link "plugged"  "~/.config/nvim/plugged"
