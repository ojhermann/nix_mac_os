{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.zsh
  ];

  programs.zsh = {
    enable = true;

    enableCompletion = true;

    completionInit = ''
      autoload -Uz compinit && compinit
      complete -C '${pkgs.awscli2}/bin/aws_completer' aws
    '';

    initContent = ''
      prompt off
      PS1="%F{cyan}%d %# %f"
      source /Users/otto/.config/nix/home_pkgs/zsh_scripts/rprompt.sh
    '';

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
