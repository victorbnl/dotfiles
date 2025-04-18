{
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

      safe.directory = [ "/dotfiles" ];
    };
  };
}
