{ pkgs, inputs, ... }:

{
  imports = [
    (import ./firefox.nix { inherit pkgs inputs; })
    (import ./vscode.nix { inherit pkgs inputs; })

    ./alacritty.nix
    ./notepadqq.nix
    ./spotify.nix
  ];

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";
  };
}
