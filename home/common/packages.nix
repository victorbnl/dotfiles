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
    devenv
    file
    gimp
    gnumake
    htop
    nmap
    pavucontrol
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
