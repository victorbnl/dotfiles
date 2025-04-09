{
  users = {
    groups.dotfiles = {};

    users = {
      victor = {
        isNormalUser = true;
        description = "Victor";
        extraGroups = [ "dotfiles" "libvirtd" "networkmanager" "wheel" "vboxusers" "input" ];
      };
    };
  };

  nix.settings.trusted-users = [
    "victor"
  ];
}
