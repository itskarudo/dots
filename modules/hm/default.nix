{
  lib,
  pkgs,
  username,
  ...
}:
{

  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/Users/${username}";
    stateVersion = "25.11";

    activation.restartShell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
      /bin/launchctl stop com.apple.Dock.agent
      /bin/launchctl start com.apple.Dock.agent
    '';

    packages = with pkgs; [
      avalonia-ilspy
      discord
      iina
      imhex
      orbstack
      qbittorrent
      qemu
      raycast
      utm
      wireshark
      zathura
    ];
  };

  imports = [
    ./git.nix
    ./kitty.nix
  ];

}
