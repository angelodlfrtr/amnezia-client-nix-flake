{
  description = "Amnezia VPN Client";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
        };
        inherit (pkgs) stdenv;
      in rec {
        packages.default = pkgs.qt6Packages.callPackage ./default.nix {};
      }
    );
}
