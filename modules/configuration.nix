# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ...  }:

{
  imports =
    [      
      #./hardware-configuration.nix
      #./boot-cfg.nix
      #./syncthing.nix
      #./home-manager.nix
      #./flatpak.nix
      #./custom-services.nix
      #./bebronix-branding.nix
      #./invisible-networking.nix
      #./vscodium.nix
    ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      hidapi
      fuse
      xorg.libXcomposite
      xorg.libXtst
      xorg.libXrandr
      xorg.libXext
      xorg.libX11
      xorg.libXfixes
      libGL
      libva
      pipewire
      xorg.libxcb
      xorg.libXdamage
      xorg.libxshmfence
      xorg.libXxf86vm
      libsForQt5.full
      
      ## Put here any library that is required when running a package
      ## ...
      ## Uncomment if you want to use the libraries provided by default in the steam distribution
      ## but this is quite far from being exhaustive
      ## https://github.com/NixOS/nixpkgs/issues/354513
      (pkgs.runCommand "steamrun-lib" {} "mkdir $out; ln -s ${pkgs.steam-run.fhsenv}/usr/lib64 $out/lib")
    ];
  };

  nix.settings = {
    trusted-substituters = [
      "https://cache.soopy.moe"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://unmojang.cachix.org"
    ];
    substituters = [
      "https://cache.soopy.moe"
      "https://hyprland.cachix.org"
      "https://nix-gaming.cachix.org"
      "https://unmojang.cachix.org"
    ];
    trusted-public-keys = [
      "hydra.soopy.moe:IZ/bZ1XO3IfGtq66g+C85fxU/61tgXLaJ2MlcGGXU8Q="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
      "unmojang.cachix.org-1:OfHnbBNduZ6Smx9oNbLFbYyvOWSoxb2uPcnXPj4EDQY="  
    ];
  };

  networking.extraHosts =
    ''
      127.0.0.1 cloud.rovio.com
      0.0.0.0 log-upload-os.hoyoverse.com
      0.0.0.0 overseauspider.yuanshen.com
    '';

  networking.hostName = "nix-desktop"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  networking.firewall = {
   enable = false;
   allowedTCPPorts = [ 25565 ];
  };

  networking.networkmanager.insertNameservers = [ "8.8.8.8" "8.8.4.4" ];

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  console.earlySetup = true;
  systemd.services.systemd-vconsole-setup.unitConfig.After = "local-fs.target";

  console = {
    font = "ter-v14n"; # Example: Terminus font, 24pt, normal
    packages = with pkgs; [ terminus_font ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "ru_RU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  programs.zsh = {
    enable = true;
    ohMyZsh = {
        enable = true;
        plugins = [];
        theme = "agnoster";
    };    
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.arseniy = {
    isNormalUser = true;
    description = "Arseniy";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "adbusers" "i2c" "dialout"];
    packages = with pkgs; [];
  };

  users.users.arseniy.shell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  environment.variables = {
    FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  };

  hardware.i2c.enable = true;
  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
  '';

  fonts.packages = with pkgs; [
    nerd-fonts.gohufont
    nerd-fonts.droid-sans-mono
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
     inputs.nixos-pince.packages.${pkgs.system}.default
     prismlauncher
     #logmein-hamachi
     #haguichi
     betterlockscreen
     corefonts
     libwebp
     git
     wireplumber
     pantum-driver
     libreoffice-qt6-fresh
     cheese
     ocamlPackages.gstreamer
     v4l-utils
     distrobox
     signal-desktop
     trash-cli
     xdotool
     xclip
     neovim
     kbd
     blueman
     bc
     qimgv
     steam-run
     rofimoji
     libsForQt5.breeze-qt5
     nwg-look
     gscreenshot
     picom     
     dunst
     nemo
     rofi
     nitrogen
     polybar
     #sbctl
     #pegasus-frontend
     droidcam
     conky
     kitty
     fastfetch
     git
     ayugram-desktop
     tmux
     ffmpeg
     pkgs.oh-my-zsh
     pkgs.zsh
     pkgs.zsh-completions
     pkgs.zsh-powerlevel10k
     pkgs.zsh-syntax-highlighting
     pkgs.zsh-history-substring-search
     bash
     keepassxc
     qbittorrent
     feishin
     wineWowPackages.full
     playerctl
     xdg-utils
     kdePackages.sddm
     killall
     xdg-desktop-portal-gtk
     networkmanagerapplet
     bat
     eza
     mangohud
     pavucontrol
     #mesa-demos
     kdePackages.ark
     ddnet
     android-tools
     #pantheon.elementary-iconbrowser
     xorg.setxkbmap
     samba4Full
     cifs-utils
     gvfs
     vesktop
     #retroarch-full
     bluez
     greetd.greetd
     greetd.tuigreet
     #toilet
     efibootmgr
     obsidian
     vlc
     #obs-studio
     gparted
     soteria
     jmtpfs
     glib
     polkit
     pamixer
     unrar
     gamemode
     qpwgraph
     dateutils
     viu
     imagemagick
     jq
     util-linux
     zerotierone
     syncthing
     teamspeak6-client
     jdk24    
     #dante
     #lmstudio
     #vscodium
     openssl
     kdePackages.kate
     btop
     ddcutil
     #xclicker
     p7zip
     power-profiles-daemon
     lm_sensors
     qalculate-qt
     kdePackages.qt6ct
     kdePackages.kdeconnect-kde
     xorg.xorgserver
     xorg.xinit
     xorg.xf86inputevdev
     xorg.xf86inputsynaptics
     xorg.xf86inputlibinput
     xorg.xf86videoati
     glava
     libsForQt5.qt5ct
     #arduino-ide
     kdePackages.filelight
     arandr
     dxvk
 ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  programs.adb.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  powerManagement.enable = true;
  powerManagement.cpuFreqGovernor = "ondemand";

  security.polkit.enable = true;
  security.soteria.enable = true;

  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  virtualisation.waydroid.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;
  hardware.bluetooth.enable = true;

  systemd.services = {
    # Ускоряем запуск служб
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };


  services = {
    logmein-hamachi.enable = true;

    printing = {
     enable = true;
     drivers = [ pkgs.pantum-driver ];
    };

    #logind.extraConfig = ''
    #  # hibernate when power button is short-pressed
    #  HandlePowerKey=hibernate
    #'';

    gvfs.enable = true;

    xserver = {
      videoDrivers = [ "nvidia" ];
      enable = true;
      exportConfiguration = true;

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dmenu #application launcher most people use
          i3status # gives you the default i3 status bar
          i3blocks #if you are planning on using i3blocks over i3status
        ];
      };
    };

    libinput.enable = true;
    libinput.mouse.accelProfile = "adaptive";
    libinput.mouse.accelSpeed = "-0.5";
    libinput.mouse.scrollMethod = "twofinger";

    libinput.touchpad = {
      accelProfile = "adaptive";
      accelSpeed = "-0.5";
      scrollMethod = "twofinger";
      tapping = true;
    };

    zerotierone = {
      enable = true;
      joinNetworks = [
        "c7c8172af1d8956c"
      ];
    };
    
    gnome.gnome-keyring.enable = true;
    flatpak.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
    

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time";
          user = "arseniy";
        };
      };
    };

    pipewire = {
      enable = true;
      # Disable X11 bell module, which plays a sound on urgency hint
      # (my prompt includes an urgency hint, so I want no sounds).
      extraConfig = {
        pipewire."99-silent-bell.conf" = {
          "context.properties" = {
            "module.x11.bell" = false;
          };
        };
      };
    };

    samba = {
      package = pkgs.samba4Full;
      # ^^ `samba4Full` is compiled with avahi, ldap, AD etc support (compared to the default package, `samba`
      # Required for samba to register mDNS records for auto discovery 
      # See https://github.com/NixOS/nixpkgs/blob/592047fc9e4f7b74a4dc85d1b9f5243dfe4899e3/pkgs/top-level/all-packages.nix#L27268
      enable = true;
      openFirewall = true;
      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "smb-nix";
          "netbios name" = "smb-nix";
          "security" = "user";
          #"use sendfile" = "yes";
          #"max protocol" = "smb2";
          # note: localhost is the ipv6 localhost ::1
          #"hosts allow" = "192.168.0. 127.0.0.1 localhost";
          #"hosts deny" = "0.0.0.0/0";
          "guest account" = "nobody";
          "map to guest" = "bad user";
          "acl allow execute always" = "True";
        };
        "Documents" = {
          "path" = "/home/arseniy/Документы";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "arseniy";
          #"force group" = "groupname";
        };
        "Downloads" = {
          "path" = "/home/arseniy/Документы";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "arseniy";
          #"force group" = "groupname";
        };
        "Pictures" = {
          "path" = "/home/arseniy/Изображения";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "create mask" = "0644";
          "directory mask" = "0755";
          "force user" = "arseniy";
          #"force group" = "groupname";
        };
      };
    };
    avahi = {
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
      # ^^ Needed to allow samba to automatically register mDNS records (without the need for an `extraServiceFile`
      nssmdns4 = true;
      # ^^ Not one hundred percent sure if this is needed- if it aint broke, don't fix it
      enable = true;
      openFirewall = true;
    };
    samba-wsdd = {
    # This enables autodiscovery on windows since SMB1 (and thus netbios) support was discontinued
      enable = true;
      openFirewall = true;
    };
  };

  xdg.portal.config.common.default = "*";
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
    ];
  };

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.legacy_470;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you re
}
