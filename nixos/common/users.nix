{ secrets, names, ... }:

{
  users = {
    mutableUsers = false;

    groups.dotfiles = {};

    users = {
      root.password = secrets.session.root;

      "${names.user}" = {
        isNormalUser = true;
        password = secrets.session.user;

        extraGroups = [
          "dotfiles"
          "libvirtd"
          "networkmanager"
          "wheel"
          "vboxusers"
          "input"
        ];
      };
    };
  };

  nix.settings.trusted-users = [ names.user ];
}
