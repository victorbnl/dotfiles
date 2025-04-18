{ pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
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
    networkmanagerapplet
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
