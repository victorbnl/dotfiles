{
  imports = [
    ./alacritty.nix
    ./ferdium.nix
    ./librewolf.nix
    ./notepadqq.nix
    ./vscode.nix
  ];

  programs.git = {
    enable = true;

    userEmail = "victor.bonnelle@protonmail.com";
    userName = "Victor Bonnelle";

    ignores = [
      ".devenv*"
      ".vscode"
      "__pycache__"
    ];

    extraConfig = {
      credential = {
        helper = "store";
      };
    };
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

  programs.bash.enable = true;

  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
  };
}
