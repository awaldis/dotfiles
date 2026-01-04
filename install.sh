#!/bin/bash
#
# Dotfiles bootstrap script
# Usage: curl -fsSL https://raw.githubusercontent.com/awaldis/dotfiles/master/install.sh | bash
#

set -e  # Exit on error

DOTFILES_DIR="$HOME/dotfiles"
REPO_URL="https://github.com/awaldis/dotfiles.git"

echo "=== Dotfiles Installation Script ==="
echo ""

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Detect package manager
detect_package_manager() {
    if command_exists apt-get; then
        echo "apt"
    elif command_exists dnf; then
        echo "dnf"
    elif command_exists yum; then
        echo "yum"
    elif command_exists pacman; then
        echo "pacman"
    elif command_exists brew; then
        echo "brew"
    else
        echo "unknown"
    fi
}

PKG_MANAGER=$(detect_package_manager)

# Install git if not present
if ! command_exists git; then
    echo "Installing git..."
    case $PKG_MANAGER in
        apt)
            sudo apt-get update && sudo apt-get install -y git
            ;;
        dnf)
            sudo dnf install -y git
            ;;
        yum)
            sudo yum install -y git
            ;;
        pacman)
            sudo pacman -S --noconfirm git
            ;;
        brew)
            brew install git
            ;;
        *)
            echo "ERROR: Could not detect package manager. Please install git manually."
            exit 1
            ;;
    esac
else
    echo "git is already installed."
fi

# Install oh-my-posh
if ! command_exists oh-my-posh; then
    echo "Installing oh-my-posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
else
    echo "oh-my-posh is already installed."
fi

# Clone dotfiles repository
if [ -d "$DOTFILES_DIR" ]; then
    echo "Dotfiles directory already exists at $DOTFILES_DIR"
    echo "Pulling latest changes..."
    cd "$DOTFILES_DIR" && git pull
else
    echo "Cloning dotfiles repository..."
    git clone --depth 1 "$REPO_URL" "$DOTFILES_DIR"
fi

# Backup existing .bashrc if it exists and is not a symlink
if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
    BACKUP_FILE="$HOME/.bashrc.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Backing up existing .bashrc to $BACKUP_FILE"
    mv "$HOME/.bashrc" "$BACKUP_FILE"
elif [ -L "$HOME/.bashrc" ]; then
    echo "Removing existing .bashrc symlink..."
    rm "$HOME/.bashrc"
fi

# Create symlink for .bashrc
echo "Creating symlink for .bashrc..."
ln -s "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"

# Backup and symlink .inputrc if it exists in repo
if [ -f "$DOTFILES_DIR/bash/.inputrc" ]; then
    if [ -f "$HOME/.inputrc" ] && [ ! -L "$HOME/.inputrc" ]; then
        BACKUP_FILE="$HOME/.inputrc.backup.$(date +%Y%m%d_%H%M%S)"
        echo "Backing up existing .inputrc to $BACKUP_FILE"
        mv "$HOME/.inputrc" "$BACKUP_FILE"
    elif [ -L "$HOME/.inputrc" ]; then
        rm "$HOME/.inputrc"
    fi
    echo "Creating symlink for .inputrc..."
    ln -s "$DOTFILES_DIR/bash/.inputrc" "$HOME/.inputrc"
fi

echo ""
echo "=== Installation complete! ==="
echo "Please restart your shell or run: source ~/.bashrc"
