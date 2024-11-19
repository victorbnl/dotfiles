{ pkgs, inputs, ... }:
let
  nur = import inputs.nur-repository {
    nurpkgs = pkgs;
    pkgs = pkgs;
  };
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default

    (import ./programs/firefox.nix { inherit nur inputs; })
    (import ./programs/vscode.nix { inherit inputs; })

    ./programs/alacritty.nix
    ./programs/rofi.nix
    ./programs/spotify.nix
    ./appearance.nix
    ./desktop-entries.nix
    ./dunst.nix
    ./i3.nix
    ./polybar.nix
  ];

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;
  };

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";
  };

  xdg.userDirs =
    let
      homeDir = "/home/victor";
    in
    {
      enable = true;

      desktop = "${homeDir}/desktop";
      documents = "${homeDir}/documents";
      download = "${homeDir}/downloads";
      music = "${homeDir}/music";
      pictures = "${homeDir}/pictures";
      publicShare = "${homeDir}/public";
      templates = "${homeDir}/templates";
      videos = "${homeDir}/videos";
    };

  home.stateVersion = "24.05";
}
