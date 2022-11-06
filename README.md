# Dotfiles

My personal dotfiles

![](.readme/screenshot.jpg)

## Installation

*Run commands in this directory*

Install the [requirements](REQUIREMENTS.md)

### One-time installation (copy)

```
cp -ar home/* $HOME/
cp -ar root/* /
```

### Keep files in sync (symlink)

```
stow -t $HOME home
stow -t / root
```
