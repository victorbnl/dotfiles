{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "aseprite"
    "discord"
    "steam"
    "steam-unwrapped"
    "vscode"
  ];

  home.packages = with pkgs; [
    blueman
    devenv
    file
    gimp
    gnumake
    htop
    nmap
    pavucontrol
    pcmanfm
    python3
    simple-scan
    sqlitebrowser
    ungit
    unzip
    viewnior
    virt-manager
    xarchiver
    zip
  ];
}
