{
 systemd.services.battery-charge-threshold =
    let
      CHARGE_THRESHOLD = "80";
    in
    {
      enable = true;
      description = "Set the battery charge threshold";
      startLimitBurst = 0;
      after = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        Restart = "on-failure";
        ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.coreutils}/bin/echo ${CHARGE_THRESHOLD} > /sys/class/power_supply/BATT/charge_control_end_threshold'";
        # ...
      };
      wantedBy = [ "multi-user.target" ];
      # ...

    };

    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

} 