{
  # For Steam
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services = {
    udisks2.enable = true;
    gvfs.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;

      alsa = {
        enable = true;
        support32Bit = true;
      };
    };

    logind.settings.Login.HandlePowerKey = "ignore";
  };
}
