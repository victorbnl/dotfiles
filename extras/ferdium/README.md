# Ferdium

This is my custom CSS for Ferdium.

## Installation

As you might know, Ferdium doesn't support custom CSS. I opened
[an issue](https://github.com/ferdium/ferdium-app/issues/807) to ask for that
feature.

For now, I think building Ferdium from source is nearly the only way. You need
to put the `custom.scss` file in the `src/styles/` folder and add
`@import './custom.scss'` at the very end of the `main.scss` file. Now, if
you're on Gentoo, portage has a very convenient patching system as far as I
know, so you should have no trouble going further. If you're on Arch, you can
modify the PKGBUILD so that it makes these edits before building. If you're on
any other distro, look for documentation on what you can do to patch source
code with your package manager. At the end of the day, you might have to
[build it](https://github.com/ferdium/ferdium-app/blob/develop/CONTRIBUTING.md)
yourself.
