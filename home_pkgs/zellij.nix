{ pkgs, ... }:
{
  home.packages = [
    pkgs.zellij
  ];

  programs.zellij = {
    enable = true;

    settings = {
      theme = "kanagawa";
    };

    layouts = {
      python = ''
                layout {
            tab name="code: python" {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                pane split_direction="vertical" {
                    pane split_direction="horizontal" {
                        size "15%"
                        pane {
                            name "directory"
                            size "80%"
                            command "sh"
                            args "-c" "~/.dotfiles/scripts/watch_dir_python.sh"
                        }
                        pane {
                            name "git"
                            size "20%"
                            command "sh"
                            args "-c" "~/.dotfiles/scripts/watch_git.sh"
                        }
                    }
                    pane split_direction="vertical" {
                        size "85%"
                        pane split_direction="horizontal" {
                            pane {
                                name "helix"
                                size "80%"
                                focus true
                                edit "."
                            }
                            pane {
                                name "zsh"
                                size "20%"
                            }
                        }
                    }
                }
                pane size=1 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
        }
      '';
      rust = ''
          layout {
            tab name="main" {
                pane size=1 borderless=true {
                    plugin location="zellij:tab-bar"
                }
                pane split_direction="vertical" {
                    pane split_direction="horizontal" {
                        size "15%"
                        pane {
                            name "directory"
                            size "80%"
                            command "sh"
                            args "-c" "~/.dotfiles/scripts/watch_dir_rust.sh"
                        }
                        pane {
                            name "git"
                            size "20%"
                            command "sh"
                            args "-c" "~/.dotfiles/scripts/watch_git.sh"
                        }
                    }
                    pane split_direction="vertical" {
                        size "60%"
                        pane split_direction="horizontal" {
                            pane {
                                name "helix"
                                size "80%"
                                focus true
                                edit "."
                            }
                            pane {
                                name "zsh"
                                size "20%"
                            }
                        }
                    }
                    pane {
                        name "bacon"
                        size "25%"
                        command "bacon"
                    }
                }
                pane size=1 borderless=true {
                    plugin location="zellij:status-bar"
                }
            }
        }
      '';
    };
  };
}
