{
  programs.git = {
    enable = true;
    settings = {
      user.name = "karu";
      user.email = "itskarudo@protonmail.com";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
    ignores = [
      ".DS_Store"
    ];
  };
}
