#!/bin/bash

commandExists() {
    local cmdName=$1
    command -v "$cmdName" 2>&1
}

install_nvim_prereqs_ubuntu() {
    # Install build prerequisites for Ubuntu / Debian
    apt-get install ninja-build gettext cmake curl build-essential git
}

if commandExists "nvim"; then
    echo "nvim found"
else
    NVIM_REPO_URL="https://github.com/neovim/neovim.git"
    NVIM_GIT_TARGET_DIR="~/git/neovim"
    echo "Cloning Neovim to $NVIM_GIT_TARGET_DIR"
    git clone $NVIM_REPO_URL $NVIM_GIT_TARGET_DIR

    echo "Installing Neovim build prerequisites..."
    install_nvim_prereqs_ubuntu

    echo "Building Neovim from source..."
    pushd $NVIM_GIT_TARGET_DIR
    make CMAKE_INSTALL_PREFIX=/usr/local/bin CMAKE_BUILD_TYPE=Release
    popd
fi

