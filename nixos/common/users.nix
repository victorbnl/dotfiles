{ secrets, names, ... }:

{
  users = {
    mutableUsers = false;

    groups.dotfiles = {};

    users = {
      root.password = secrets.session.root;

      "${names.user}" = {
        isNormalUser = true;
        extraGroups = [ "dotfiles" "libvirtd" "networkmanager" "wheel" "vboxusers" "input" ];
        password = secrets.session.user;
      };
    };
  };

  nix.settings.trusted-users = [ names.user ];
}
