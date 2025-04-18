{ secrets, names, ... }:

{
  users = {
    mutableUsers = false;

    users = {
      root.password = secrets.session.root;

      "${names.user}" = {
        isNormalUser = true;
        password = secrets.session.user;

        extraGroups = [
          "libvirtd"
          "wheel"
          "input"
        ];
      };
    };
  };

  nix.settings.trusted-users = [ names.user ];
}
