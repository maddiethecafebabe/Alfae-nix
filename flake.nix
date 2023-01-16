{
  description = "An Itch.io/Epic Games/GOG launcher that works through plugins";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
    alfae = {
      url = "github:suchmememanyskill/Alfae";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    alfae,
  }: let
    pkgs = import nixpkgs {
      config.allowUnfree = true;
      system = "x86_64-linux";
    };

    pkg = (pkgs.callPackage ./alfae.nix {}).overrideAttrs (old: {
      src = alfae;
      version = alfae.tag or "1.3.2";
    });
  in {
    packages.x86_64-linux = {
      alfae = pkg;
      default = pkg;
    };
  };
}
