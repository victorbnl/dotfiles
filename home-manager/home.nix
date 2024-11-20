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
    (import ./programs/vscode.nix { inherit pkgs inputs; })

    ./programs/alacritty.nix
    ./programs/rofi.nix
    ./programs/spotify.nix
    ./appearance.nix
    ./desktop-entries.nix
    ./dunst.nix
    ./i3.nix
    ./polybar.nix
  ];

  programs.bash.enable = true;

  home.shellAliases = {
    "rebuild-nixos" = "sudo nixos-rebuild switch --flake path:/data/victor/dotfiles";
  };

  xresources.properties = {
    "Xft.dpi" = 134;
  };

  services.picom = {
    enable = true;

    backend = "glx";
    vSync = true;

    settings = {
      inactive-dim = 0.2;
    };
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
