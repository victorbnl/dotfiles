{ secrets, ... }:

{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./librewolf.nix
    ./vim.nix
    ./vscode.nix
  ];

  programs = {
    bash.enable = true;

    direnv = {
      enable = true;
      enableBashIntegration = true;
    };

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*".identityFile = "${secrets.sshKey}";
    };
  };
}
