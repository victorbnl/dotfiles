{
  imports = [
    ./alacritty.nix
    ./git.nix
    ./gpg-ssh.nix
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

    vesktop = {
      enable = true;

      settings = {
        discordBranch = "stable";
        minimizeToTray = false;
        arRPC = false;
      };
    };
  };
}
