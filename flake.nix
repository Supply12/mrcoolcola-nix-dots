{
  inputs = {
    # The channel of nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Mc launcher
    fjordlauncher = {
      url = "github:unmojang/FjordLauncher";

      # Optional: Override the nixpkgs input of fjordlauncher to use the same revision as the rest of your flake
      # Note that this may break the reproducibility mentioned above, and you might not be able to access the binary cache
      #
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = inputs@{ self, nixpkgs, fjordlauncher, ... }: {
    nixosConfigurations.nix-desktop = nixpkgs.lib.nixosSystem {
      # NOTE: Change this to aarch64-linux if you are on ARM
      system = "x86_64-linux";
      # Modules (nix configs) and fjord launcher
      modules = [
        ./modules/configuration.nix
        ./modules/hardware-configuration.nix
        ./modules/boot-cfg.nix
        ./modules/syncthing.nix
        ./modules/home-manager.nix
        ./modules/flatpak.nix
        ./modules/custom-services.nix
        ./modules/bebronix-branding.nix
        ./modules/invisible-networking.nix
        ./modules/vscodium.nix

        (
          { pkgs, ... }:
          {
            environment.systemPackages = [ fjordlauncher.packages.${pkgs.system}.fjordlauncher ];
          }
        )
      ];
      # pizdec nechitaemo
    };
  };
}
