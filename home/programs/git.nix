{
  programs.git = {
    enable = true;

    userEmail = "marie.bonnelle@proton.me";
    userName = "Marie Bonnelle";

    signing.signByDefault = true;

    ignores = [
      ".devenv*"
      ".direnv"
      ".vscode"
      "__pycache__"
    ];

    extraConfig = {
      credential = {
        helper = "store";
      };
    };
  };
}
