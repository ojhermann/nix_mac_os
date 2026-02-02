{
  config,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  imports = [
    ./home_pkgs/git.nix
    ./home_pkgs/hx.nix
    ./home_pkgs/zellij.nix
    ./home_pkgs/zsh.nix
  ];

  home.packages = [
    pkgs.google-chrome
    # rust
    pkgs.cargo
    pkgs.rustc
    pkgs.tree
  ];
}
