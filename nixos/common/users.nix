{ secrets, ... }:

{
  users = {
    mutableUsers = false;

    groups.dotfiles = {};

    users = {
      root.password = secrets.session.root;

      victor = {
        isNormalUser = true;
        description = "Victor";
        extraGroups = [ "dotfiles" "libvirtd" "networkmanager" "wheel" "vboxusers" "input" ];
        password = secrets.session.victor;
      };
    };
  };

  nix.settings.trusted-users = [
    "victor"
  ];
}
