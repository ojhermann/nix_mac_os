{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./home_pkgs/git.nix
    ./home_pkgs/hx.nix
    ./home_pkgs/zsh.nix
  ];

  home.packages = [
    pkgs.tree
  ];
}
