{ pkgs, root, ... }:

{
  environment.systemPackages = [
    (pkgs.sddm-chili-theme.overrideAttrs(oldAttrs: {
      preInstall = (oldAttrs.preInstall or "") + ''
        sed -i 's|^background=.*$|background=${root + /assets/wallpapers/display-manager}|' theme.conf
      '';
    }))
  ];

  services.displayManager.sddm = {
    enable = true;

    theme = "chili";

    settings = {
      Theme = {
        FacesDir = "${root + /assets/account-icons}";
      };
    };
  };
}
