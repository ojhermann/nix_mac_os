{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.zsh
  ];

  programs.zsh = {
    enable = true;

    shellAliases = {
      grep = "grep -i --color=auto";
      gs = "git status --short";
      ls = "ls --color=auto";
      restart = "sudo shutdown -r now";
      shutdown = "sudo shutdown -h now";
      switch = "sudo darwin-rebuild switch --flake ~/.config/nix";
      tree = "tree -C";
      zj = "zellij";
    };

  };
}
