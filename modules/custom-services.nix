{ config, pkgs, ... }:

{
  systemd.services.systemd-hibernate.preStart = "${pkgs.kbd}/bin/chvt 6";

  systemd.services.my-suspend-fix = {
    enable = true;
    description = "Fix suspend issue";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
       ExecStart="/bin/sh -c 'echo GPP0 > /proc/acpi/wakeup'";     
    };
  };

  systemd.services.after-hibernate-kostyl = {
    enable = true;
    description = "kostyl`";
    after = [ "hibernate.target" ];
    wantedBy = [ "hibernate.target" ];
    serviceConfig = {
       ExecStart="${pkgs.kbd}/bin/chvt 1";
    };
  };
}
