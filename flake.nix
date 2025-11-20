{
  inputs = {
    # The channel of nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    # Добавляем nixos-pince
    nixos-pince.url = "github:BreakingBread0/nixos-pince";
  };

  outputs = inputs@{ self, nixpkgs, nixos-pince, ... }: {
    nixosConfigurations.nix-desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Передаём все inputs в модули через specialArgs
      specialArgs = { inherit inputs; };
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
    };
  };
}
