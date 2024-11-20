{ pkgs, inputs, nur, ... }:

{
  imports = [
    (import ./firefox.nix { inherit nur inputs; })
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
