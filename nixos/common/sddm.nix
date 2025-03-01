{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.sddm-chili-theme.overrideAttrs(oldAttrs: {
      preInstall = (oldAttrs.preInstall or "") + ''
        sed -i 's/^background=.*$/background=\/etc\/sddm-background-image/' theme.conf
      '';
    }))
  ];

  services.displayManager.sddm = {
    enable = true;

    theme = "chili";

    settings = {
      Theme = {
        FacesDir = "${./account-icons}";
      };
    };
  };
}
