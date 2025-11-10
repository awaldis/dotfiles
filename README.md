# Dotfiles

My personal dotfiles managed with GNU Stow.

## Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Install GNU Stow:
   ```bash
   sudo apt-get install stow  # Debian/Ubuntu
   ```

3. Use stow to create symlinks:
   ```bash
   stow bash  # Creates ~/.bashrc symlink
   ```

## Adding More Dotfiles

To add a new config file:

1. Create a directory for the application:
   ```bash
   mkdir -p ~/dotfiles/appname
   ```

2. Move the config file(s) into it:
   ```bash
   mv ~/.config/appname ~/dotfiles/appname/.config/
   ```

3. Run stow:
   ```bash
   cd ~/dotfiles
   stow appname
   ```

## Removing Dotfiles

To unlink a package:
```bash
cd ~/dotfiles
stow -D bash  # Removes ~/.bashrc symlink
```

## Structure

Each directory represents a "package" that stow can manage:
- `bash/` - Bash configuration (.bashrc)
