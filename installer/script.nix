{ pkgs, disko, flake, host, user }:

pkgs.writeScript "install-system"
''
set -e

${disko}/disko \
  --mode destroy,format,mount \
  --flake path:${flake}#${host}

nixos-install --flake path:${flake}#${host}

cp -r ${flake} /mnt/home/${user}/dotfiles

nixos-enter -c "
  chown -R ${user}:users /home/${user}/dotfiles
  nix-daemon --daemon &
  su - ${user} -c 'home-manager switch --flake path:/home/${user}/dotfiles#${user}@${host}'
"
''
