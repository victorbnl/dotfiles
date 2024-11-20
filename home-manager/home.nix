{ pkgs, inputs, ... }:
let
  nur = import inputs.nur-repository {
    nurpkgs = pkgs;
    pkgs = pkgs;
  };
in
{
  imports = [
    (import ./programs { inherit pkgs inputs nur; })
    ./desktop
  ];

  programs.bash.enable = true;

  home.shellAliases = {
    "rebuild-nixos" = "sudo nixos-rebuild switch --flake path:/data/victor/dotfiles";
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
