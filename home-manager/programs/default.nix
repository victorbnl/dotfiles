{ pkgs, inputs, ... }:

{
  imports = [
    ./alacritty.nix
    ./firefox.nix
    ./notepadqq.nix
    ./spotify.nix
    ./vscode.nix
  ];

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";
  };
}
