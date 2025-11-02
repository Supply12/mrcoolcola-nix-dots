{ pkgs, lib, ... }:
let
  nixowos = import (builtins.fetchGit {
    url = "https://github.com/yunfachi/nixowos";
  });
in 
{
  imports = [
    nixowos.nixosModules.default
    # or, if you're using Home Manager:
    # nixowos.homeManagerModules.default
  ];

  # Enable NixOwOS
  nixowos.enable = true;
  nixowos.name = "BebroNix";
}
