{ config, pkgs, ...}:
{
  home.packages = [pkgs.helix];
  
  programs.helix = {
    enable = true;
    
    settings = {
      theme = "default";
      editor.file-picker.hidden = false;
      editor.lsp.display-inlay-hints = true;
    };
  
  };
}

