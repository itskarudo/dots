{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    brews = [
    ];
    casks = [
      "anki"
      "arc"
      "burp-suite"
      "genymotion"
      "helium-browser"
      # "mactex-no-gui"
      "mattermost"
      "protonvpn"
      "steam"
      "telegram"
      "xquartz"
      "zed"
      "zen"
    ];
  };
}
