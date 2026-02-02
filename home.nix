{ config, pkgs, lib, ... }:

{
  imports = [
    ./home_pkgs/git.nix
    ./home_pkgs/hx.nix
  ];
}

