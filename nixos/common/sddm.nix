{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    sddm-chili-theme
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
