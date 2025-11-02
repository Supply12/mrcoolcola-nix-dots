{ config, pkgs, lib, ... }:

let
    sources = import ./nix/sources.nix;
    lanzaboote = import sources.lanzaboote;
in
{
  imports =
    [ (let rev = "main"; in import (builtins.fetchTarball {
        url = "https://gitlab.com/VandalByte/darkmatter-grub-theme/-/archive/${rev}/darkmatter-grub-theme-${rev}.tar.gz";
        sha256 = "1i6dwmddjh0cbrp6zgafdrji202alkz52rjisx0hs1bgjbrbwxdj";
        }))
    ];

  #imports = [ lanzaboote.nixosModules.lanzaboote ];

  #system.nixos.label = "BebroNix";


  #boot.lanzaboote = {
  #  enable = true;
  #  pkiBundle = "/var/lib/sbctl";
  #  configurationLimit = 3;
  #};

  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot"; # ← use the same mount point here.
    };
    grub = {
       efiSupport = true;
       #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
       device = "nodev";
       gfxmodeEfi = "1920x1080";
       useOSProber = true;
       darkmatter-theme = {
         enable = true;
         style = "nixos";
         icon = "color";
         resolution = "1080p";
       };

    };
  };


  boot = {
    plymouth = {
      enable = true;
      theme = "tech_a";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "tech_a" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;

    initrd = {
      compressor = "zstd";
      compressorArgs = [ "-1" ];
      systemd.enable = true;
      verbose = false;
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "plymouth.use-simpledrm"
      "nvidia_drm.modeset=1"
      "nvidia_drm.fbdev=1"
      "kvm.enable_virt_at_load=0"
    ];

    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" "vboxdrv" "vboxnetflt" "vboxnetadp" "vboxpci" "binder" ]; # For droidcam
    extraModulePackages = [ pkgs.linuxPackages.v4l2loopback ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 5;
  };
}
