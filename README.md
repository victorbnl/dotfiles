# Dotfiles

My personal dotfiles

![Screenshot](.readme/screenshot.jpg)

## Installation

1. [Install dotter](https://github.com/SuperCuber/dotter#installation)
2. Install the dependencies: `paru -S - < dependencies.txt` (replace `paru` with
   your AUR helper if you use another)
3. Change directory to `dotfiles`
4. Create a `.dotter/local.toml` file with the packages you want, for instance

  ```
  packages = [
    "i3",
    "polybar",
  ]
  ```

5. Run `dotter`
