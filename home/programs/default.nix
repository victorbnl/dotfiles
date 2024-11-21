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

  programs.vim = {
    enable = true;

    settings = {
      expandtab = true;

      number = true;
      relativenumber = true;
    };

    extraConfig = ''
      set laststatus=0
    '';
  };
}
