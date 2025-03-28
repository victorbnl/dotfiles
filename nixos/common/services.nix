{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  services = {
    fwupd.enable = true;

    earlyoom.enable = true;

    fprintd.enable = true;

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;

      settings = {
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
      };
    };

    udisks2.enable = true;
    gvfs.enable = true;

    printing = {
      enable = true;
      browsing = true;
      browsedConf = ''
        BrowseDNSSDSubTypes _cups,_print
        BrowseLocalProtocols all
        BrowseRemoteProtocols all
        CreateIPPPrinterQueues All
        BrowseProtocols all
      '';
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    logind.powerKey = "ignore";
  };
}
