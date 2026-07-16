{ pkgs, ... }:
{
  system = {
    stateVersion = 6;
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToControl = true;
    };
    defaults = {
      ".GlobalPreferences"."com.apple.mouse.scaling" = 1.0;
      CustomUserPreferences.NSGlobalDomain."com.apple.mouse.linear" = true;
      CustomSystemPreferences."com.apple.dock".workspaces-auto-swoosh = false;
      dock = {
        autohide = true;
        orientation = "right";
        show-recents = false;
        mru-spaces = false;
      };
      finder = {
        CreateDesktop = true;
        FXDefaultSearchScope = "SCcf";
        QuitMenuItem = true;
        AppleShowAllExtensions = true;
      };
      NSGlobalDomain = {
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticWindowAnimationsEnabled = false;
        NSWindowResizeTime = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
    };
    activationScripts.extraActivation.text = ''
      ln -sf "${pkgs.jdk21}/Library/Java/JavaVirtualMachines/zulu-21.jdk" "/Library/Java/JavaVirtualMachines/"
    '';
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  networking = {
    knownNetworkServices = [
      "Wi-Fi"
      "Thunderbolt Bridge"
    ];
    dns = [
      "9.9.9.9"
      "1.1.1.1"
      "8.8.8.8"
    ];
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  imports = [
    ./core.nix
    ./user.nix
    ./brew.nix
    ./wm.nix
    ./pkgs.nix
  ];

}
