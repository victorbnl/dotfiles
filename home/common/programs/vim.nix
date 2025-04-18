{
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
