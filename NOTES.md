# Notes

These are notes about customisations that can't be done with simple files, i.e.
software that require interacting with the GUI.

## Appearance

### GTK, icons, cursor

GTK theme, icon theme and cursor can be set using `lxappearance`.

**Theme**: Adapta-Nokto  
**Icon theme**: Papirus-Dark  
**Cursor**: Breeze Light

### Qt

Qt style is configured through `kvantum`.

**Theme**: KvAdaptaDark

## Firefox

**Theme**: Default Dark

### Extensions

- [uBlock Origin](https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/)
- [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/)
- [SponsorBlock](https://addons.mozilla.org/en-US/firefox/addon/sponsorblock/)

### Tabs

![](https://user-images.githubusercontent.com/85301851/180248812-8aecba52-77bd-4ee5-9e04-e6f07276dfa4.PNG)

- Enable userChrome.css
  - `toolkit.legacyUserProfileCustomizations.stylesheets`: `true`
- Install [WaveFox](https://github.com/QNetITQ/WaveFox)
- Choose tab style
  - `userChrome.PhotonTabs-Enabled`: `true`

## Visual Studio Code

**Theme:** One Dark Pro  
**Extensions:** Material Icon Theme
