{ configs, pgks, ...}:
{
  programs.git = {
    enable = true;
    userName = "Otto Hermann";
    userEmail = "ojhermann@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      pull.ff = "only";
      push.autoSetupRemote = true;
      alias = {
        cb = "!git rev-parse --abbrev-ref HEAD | pbcopy";
        up = "!git remote update -p; git merge --ff-only @{u}";
      };
    };
  };
}
