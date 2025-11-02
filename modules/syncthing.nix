{ config, pkgs, ... }:

{
  services.syncthing = {
    enable = true;
    user = "arseniy";
    dataDir = "/home/arseniy";  # default location for new folders
    configDir = "/home/arseniy/.config/syncthing";
    settings = {
      devices = {
        "phone" = { id = "QPD4RQZ-QJWYI6O-P2HH3EH-SDVULAA-7CAAHVU-WZ5HPCP-QY2LTFA-4Q6MNQW"; };
      };
      folders = {
        obsidian = {
          id = "tg2r8-nn5ct";
          path = "/data/Obsidian";
          devices = [ "phone" ];
          ignorePerms = true;
        };
        bardak = {
          id = "pdo4u-8dorn";
          path = "~/Документы/Разное-На-Синхрон";
          devices = [ "phone" ];
          ingorePerms = true;
        };
        mobile_gallery = {
          id = "mi_8_lite_vd24 фото";
          path = "~/Изображения/Mobile-Gallery";
          devices = [ "phone" ];
          ingorePerms = true;
        };
      };
    };
  };
}
