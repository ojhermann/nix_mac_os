{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.helix
    # bash
    pkgs.bash-language-server
    pkgs.shfmt
    # nix
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt
  ];

  programs.helix = {
    enable = true;

    settings = {
      theme = "default";
      editor.file-picker.hidden = false;
      editor.lsp.display-inlay-hints = true;
    };

    languages = {
      language = [
        {
          name = "bash";
          auto-format = true;
          formatter = {
            command = "shfmt";
          };
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
      ];
    };

  };
}
