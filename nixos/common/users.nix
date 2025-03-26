{
  users = {
    groups.dotfiles = {};

    users = {
      victor = {
        isNormalUser = true;
        description = "Victor";
        extraGroups = [ "dotfiles" "networkmanager" "wheel" "vboxusers" "input" ];
      };

      study = {
        isNormalUser = true;
        description = "Study";
        extraGroups = [ "networkmanager" "wheel" "vboxusers" "input" ];
      };

      work = {
        isNormalUser = true;
        description = "Work";
        extraGroups = [ "networkmanager" "wheel" "vboxusers" "input" ];
      };
    };
  };

  nix.settings.trusted-users = [
    "victor"
  ];
}
