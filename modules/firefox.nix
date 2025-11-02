{ config, pkgs, ... }:

  let
    lock-false = {
      Value = false;
      Status = "locked";
    };
    lock-true = {
      Value = true;
      Status = "locked";
    };
  in
{
  programs = {
    firefox = {
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
        };
      };
    };
  };
}
