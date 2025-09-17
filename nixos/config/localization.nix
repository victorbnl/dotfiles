{
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "fr";

  services.xserver.xkb = {
    layout = "fr,fr(ergol)";
    options = "grp:alt_space_toggle";
  };
}
