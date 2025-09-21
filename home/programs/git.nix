{
  programs.git = {
    enable = true;

    userEmail = "marie.bonnelle@proton.me";
    userName = "Marie Bonnelle";

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
}
