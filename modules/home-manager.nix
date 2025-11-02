{ config, pkgs, ... }:
let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  lock-false = { 
    Value = false;
    Status = "locked";
  }; 
  lock-true = {
    Value = true;
    Status = "locked";
  };
  username = "arseniy";
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager.users.${username} = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "25.05";
    home.enableNixpkgsReleaseCheck = false;
    /* Here goes the rest of your home-manager config, e.g. home.packages = [ pkgs.foo ]; */

    programs.git = {
      enable = true;
      settings.user = {
        name  = "Supply12";
        email = "arseniyshtaub@gmail.com";
      };
    };
    home.sessionVariables = {
       #HTTP_PROXY="socks5://192.168.0.20:1080";
       #HTTPS_PROXY="socks5://192.168.0.20:1080";
       QT_QPA_PLATFORMTHEME="qt5ct";
       PATH="$HOME/Scripts:$PATH";
       TERM="xterm";
       #STEAM_EXTRA_COMPAT_TOOLS_PATHS="${HOME}/.steam/root/compatibilitytools.d”;
    };
    home.file.".local/share/applications/vesktop.desktop".text = ''
      [Desktop Entry]
      Categories=Network;InstantMessaging;Chat
      Exec=env http_proxy=socks5://192.168.0.20:1080 https_proxy=socks5://192.168.0.20:1080 vesktop --proxy-server="socks5://192.168.0.20:1080"
      GenericName=Internet Messenger
      Icon=vesktop
      Keywords=discord;vencord;electron;chat
      Name=Vesktop
      StartupWMClass=Vesktop
      Type=Application
      Version=1.4
      MimeType=x-scheme-handler/discord;
    '';

    home.file.".config/kitty/kitty.conf".text = ''
      cursor #1e90ff
      cursor_blink_interval 0.45 ease-in-out
      cursor_trail 1
      cursor_trail_decay 0.1 0.4

      scrollback_lines 2000

      url_color #0087bd
      url_style dashed

      background_opacity         0.6
      dynamic_background_opacity yes

      map ctrl+g copy_ansi_to_clipboard
    '';

    home.file.".tmux.conf".text = ''
      set -g pane-active-border-style fg='#1B81E5'
      set -g pane-border-style fg='#0F487F'
      set -g status-bg '#333333'
      set -g status-fg white
      bind-key -T root WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= \"#{pane_in_mode}\" \"send-keys -M\" \"copy-mode -et=\""
    '';

    home.file.".profile".text = ''
      # Environment variables
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      # Only source this once
      if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
        export __HM_ZSH_SESS_VARS_SOURCED=1
        export EDITOR="nano"
      fi
    '';

    home.file.".xprofile".text = ''
      # Environment variables
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      # Only source this once
      if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
        export __HM_ZSH_SESS_VARS_SOURCED=1
        export EDITOR="nano"
      fi
    '';

    home.file.".zshenv".text = ''
      # Environment variables
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"

      # Only source this once
      if [[ -z "$__HM_ZSH_SESS_VARS_SOURCED" ]]; then
        export __HM_ZSH_SESS_VARS_SOURCED=1
        export EDITOR="nano" 
      fi
    '';

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "inode/directory" = [ "nemo.desktop" ];
        "application/x-gnome-saved-search" = [ "nemo.desktop" ];
      };
    };

    home.file.".config/dunst/dunstrc".source = "/home/${username}/nixos-config/dots/dunstrc";
    home.file.".config/fastfetch".source = "/home/${username}/nixos-config/dots/fastfetch";
    home.file.".config/polybar/config.ini".source = "/home/${username}/nixos-config/dots/polybar-cfg.ini";
    home.file.".config/wireplumber".source = "/home/${username}/nixos-config/dots/wireplumber";
    home.file.".ssh".source = "/home/${username}/nixos-config/dots/ssh";

    programs.librewolf = {
      enable = true;
      languagePacks = [ "ru" "en-US" ];

      /* ---- POLICIES ---- */
      # Check about:policies#documentation for options.
      policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
          EnableTrackingProtection = {
          Value= true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar = "always"; # alternatives: "always" or "newtab"
          DisplayMenuBar = "never"; # alternatives: "always", "never" or "default-on"
          #SearchBar = "separate"; # alternative: "separate"

          /* ---- EXTENSIONS ---- */
          # Check about:support for extension/add-on ID strings.
          # Valid strings for installation_mode are "allowed", "blocked",
          # "force_installed" and "normal_installed".
          ExtensionSettings = {
          "*".installation_mode = "blocked"; # blocks all addons except the ones specified below
          # Disable WebRTC
          "jid1-5Fs7iTLscUaZBgwr@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/happy-bonobo-disable-webrtc/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # YouTube anti translate
          "{558160b9-32eb-4f4c-87d1-89ad3bdeb9dc}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-anti-translate/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # hide shorts for YT:
          "{88ebde3a-4581-4c6b-8019-2a05a9e3e938}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/hide-youtube-shorts/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Darkblue theme:
          "{894e1fa0-bfe2-4ee8-ad01-6e9ff4092ad0}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkblue-basic/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # FastForward
          "addon@fastforward.team" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/fastforwardteam/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Privacy Badger:
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # New Tab Override:
          "newtaboverride@agenedia.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Don`t accept webp
          "dont-accept-webp@jeffersonscher.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/dont-accept-webp/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # FoxyProxy
          "foxyproxy@eric.h.jung" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi";
              installation_mode = "force_installed";
              default_area = "navbar";
          };
          # Return YT dislike
          "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislikes/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # SponsorBlock
          "sponsorBlocker@ajay.app" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Stylus
          "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/latest.xpi";
              installation_mode = "force_installed";
              default_area = "navbar";
          };
          # Torrent Control
          "{e6e36c9a-8323-446c-b720-a176017e38ff}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/torrent-control/latest.xpi";
              installation_mode = "force_installed";
              default_area = "navbar";
          };
          # User-agen switcher
          "{a6c4a591-f1b2-4f03-b3ff-767e5bedf4e7}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/user-agent-string-switcher/latest.xpi";
              installation_mode = "force_installed";
              default_area = "navbar";
          };
          # YT high def
          "{7b1bf0b6-a1b9-42b0-b75d-252036438bdc}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-high-definition/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Load Reddit Images Directly
          "{4c421bb7-c1de-4dc6-80c7-ce8625e34d24}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/load-reddit-images-directly/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # KeepassXC-Browser
          "keepassxc-browser@keepassxc.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
          # Dark Reader
          "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
              installation_mode = "force_installed";
              default_area = "hidden";
          };
      };

          /* ---- PREFERENCES ---- */
          # Check about:config for options.
          Preferences = {
          "browser.contentblocking.category" = { Value = "strict"; Status = "locked"; };
          "extensions.pocket.enabled" = lock-false;
          "extensions.screenshots.disabled" = lock-true;
          "browser.topsites.contile.enabled" = lock-false;
          "browser.formfill.enable" = lock-false;
          "browser.search.suggest.enabled" = lock-false;
          "browser.search.suggest.enabled.private" = lock-false;
          "browser.urlbar.suggest.searches" = lock-false;
          "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
          "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
          "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
          "browser.newtabpage.activity-stream.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
          "browser.tabs.closeWindowWithLastTab" = lock-false;
          "browser.tabs.tabClipWidth" = { Value = 999; Status = "locked"; };
          "browser.translations.enable" = lock-false;
          "widget.use-xdg-desktop-portal.file-picker" = { Value = 1; Status = "locked"; };
          "security.OCSP.require" = lock-false;
          };
      };
    };
  };
}

