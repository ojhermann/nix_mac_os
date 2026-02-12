{ pkgs, ... }:
{
  home.packages = [
    pkgs.helix
    # bash
    pkgs.bash-language-server
    pkgs.shfmt
    # docker-compose
    pkgs.docker-compose-language-service
    pkgs.yamlfix
    pkgs.yaml-language-server
    # dockerfile
    pkgs.dockerfile-language-server
    pkgs.hadolint
    # haskell
    pkgs.haskell-language-server
    pkgs.ormolu
    # kdl
    pkgs.kdlfmt
    # markdown
    pkgs.dprint
    pkgs.markdown-oxide
    # nix
    pkgs.nil
    pkgs.nixd
    pkgs.nixfmt
    # python
    pkgs.python313Packages.jedi-language-server
    pkgs.python313Packages.python-lsp-server
    pkgs.ruff
    pkgs.ty
    # rust
    pkgs.lldb
    pkgs.rust-analyzer
    # toml
    pkgs.taplo
    pkgs.tombi
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
          name = "docker-compose";
          auto-format = true;
          formatter = {
            command = "yamlfix";
            args = [ "-" ];
          };
        }
        {
          name = "dockerfile";
          auto-format = true;
          formatter.command = "hadolint";
        }
        {
          name = "haskell";
          auto-format = true;
          formatter = {
            command = "ormolu";
          };
        }
        {
          name = "kdl";
          auto-format = true;
          formatter = {
            command = "kdlfmt";
            args = [ "format" ];
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
        {
          name = "pkl";
          auto-format = true;
          formatter = {
            command = "pkl";
            args = [
              "format"
              "-w"
            ];
          };
        }
        {
          name = "python";
          auto-format = true;
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
        }
        {
          name = "rust";
          auto-format = true;
          formatter = {
            command = "cargo";
            args = [ "fmt" ];
          };
        }
        {
          name = "toml";
          auto-format = true;
          formatter = {
            command = "taplo";
            args = [
              "fmt"
              "-"
            ];
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
