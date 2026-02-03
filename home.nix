{
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

  home.sessionVariables = {
    EDITOR = "hx";
    VISUAL = "hx";
  };

  home.activation.setDefaultBrowser = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.defaultbrowser}/bin/defaultbrowser chrome
  '';

  home.packages = [
    # aws-cli
    pkgs.awscli2
    # defaultbrowser
    pkgs.defaultbrowser
    # google-chrome
    pkgs.google-chrome
    # rust
    pkgs.bacon
    pkgs.cargo
    pkgs.rustc
    # tree
    pkgs.tree
    # scripts
    (pkgs.writeShellScriptBin "watch-dir-python" ''
      #!/bin/zsh

      CURRENT=$(tree -C -a --gitignore -I ".git")
      PRIOR="$CURRENT"
      clear && tree -C -a --gitignore -I ".git"

      while true; do
      	CURRENT=$(tree -C -a --gitignore -I ".git")
      	if [[ "$CURRENT" != "$PRIOR" ]]; then
      		PRIOR="$CURRENT"
      		clear && tree -C -a --gitignore -I ".git"
      	fi
      done
    '')
    (pkgs.writeShellScriptBin "watch-dir-rust" ''
      #!/bin/zsh

      CURRENT=$(tree)
      PRIOR="$CURRENT"
      clear && tree -C -I "target"

      while true; do
      	CURRENT=$(tree -C)
      	if [[ "$CURRENT" != "$PRIOR" ]]; then
      		PRIOR="$CURRENT"
      		clear && tree -C -I "target"
      	fi
      done
    '')
    (pkgs.writeShellScriptBin "watch-git" ''
      #!/bin/zsh

      if ! git rev-parse --git-dir >/dev/null 2>&1; then
      	print -P "%F{green}not a git repository%f"
      	exit 0
      fi

      CURRENT="C"
      PRIOR="P"
      while true; do
      	if [[ "$CURRENT" != "$PRIOR" ]]; then
      		clear && git status --short
      		PRIOR=$CURRENT
      	fi
      	CURRENT=$(git status --short)
      done
    '')
  ];
}
