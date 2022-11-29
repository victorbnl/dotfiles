# Ferdium

![](.readme/screenshot.png)

## Installation

As you might know, Ferdium doesn't support custom CSS. I opened
[an issue](https://github.com/ferdium/ferdium-app/issues/807) to ask for that
feature.

For now, I think building Ferdium from source is nearly the only way. You need
to put the `custom.scss` file in the `src/styles/` folder and add
`@import './custom.scss'` at the very end of the `main.scss` file.

### Gentoo

Now, if you're on Gentoo, portage has a very convenient patching system as far
as I know, so you should have no trouble going further.

### Arch

If you're on Arch, you can modify the PKGBUILD so that it makes these edits
before building.

1. `git clone https://aur.archlinux.org/ferdium-git.git`
2. copy `custom.scss` to `ferdium-git/`
3. add `'custom.scss'` to the `$source` array (don't forget to add a second
   `'SKIP'` to the `$sha512sums`)
4. add at the end of the `prepare` function:
   ```sh
   cp "$srcdir/custom.scss" "$srcdir/$_sourcedirectory/src/styles"
   echo "@import './custom.scss'" >> "$srcdir/$_sourcedirectory/src/styles/main.scss"
   ```
5. install the package: `makepkg -si`


### Other

If you're on any other distro, look for documentation on what you can do to
patch source code with your package manager. At the end of the day, you might
have to
[build it](https://github.com/ferdium/ferdium-app/blob/develop/CONTRIBUTING.md)
yourself. Good luck.
