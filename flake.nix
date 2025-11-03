{
  inputs = {
    # The channel of nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };
  outputs = inputs@{ self, nixpkgs, ... }: {
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
      ];
      # pizdec nechitaemo
    };
  };
}
