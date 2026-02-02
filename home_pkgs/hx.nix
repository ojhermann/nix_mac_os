{ config, pkgs, ... }:
{
  home.packages = [
    pkgs.helix
    # bash
    pkgs.bash-language-server
    pkgs.shfmt
    # markdown
    pkgs.dprint
    pkgs.markdown-oxide
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
          name = "markdown";
          auto-format = true;
          formatter = {
            command = "dprint";
            args = [
              "fmt"
              "--stdin"
              "md"
            ];
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

  # markdown: dprint config i.e. dprint init
  home.file."dprint.json" = {
    text = ''
      {
        "markdown": {},
        "excludes": [],
        "plugins": [
          "https://plugins.dprint.dev/markdown-0.20.0.wasm"
        ]
      }
    '';
  };
}
