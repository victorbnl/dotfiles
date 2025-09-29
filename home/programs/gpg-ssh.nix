{ config, lib, pkgs, secrets, ... }:

{
  programs = {
    gpg.enable = true;

    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*".identityFile = "${secrets.sshKey}";
    };
  };

  home.activation.gpg-script = with secrets.gpg; lib.hm.dag.entryAfter ["writeBoundary"] ''
      gpg --import ${key}
      echo "${fingerprint}:6:" | gpg --import-ownertrust
    '';

  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
  };
}
