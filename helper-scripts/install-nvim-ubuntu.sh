#!/bin/bash

commandExists() {
    local cmdName=$1
    command -v "$cmdName" 2>&1
}

install_prereqs_ubuntu() {
    # Install prerequisites for Ubuntu / Debian
    apt-get install ninja-build gettext cmake curl build-essential git
    curl https://sh.rustup.rs -sSf | sh
    cargo install --locked tree-sitter-cli
    . "$HOME/.cargo/env"
}

if commandExists "nvim"; then
    echo "nvim found"
else
    NVIM_REPO_URL="https://github.com/neovim/neovim.git"
    NVIM_GIT_TARGET_DIR="$HOME/git/neovim"
    echo "Cloning Neovim to $NVIM_GIT_TARGET_DIR"
    git clone $NVIM_REPO_URL $NVIM_GIT_TARGET_DIR

    echo "Installing Neovim build prerequisites..."
    install_prereqs_ubuntu

    echo "Building Neovim from source..."
    pushd $NVIM_GIT_TARGET_DIR
    make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/neovim"
    make install
    export PATH="$HOME/neovim/bin:$PATH"

    popd
fi
