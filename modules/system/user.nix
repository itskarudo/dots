{
  username,
  hostname,
  pkgs,
  ...
}:
{
  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  users.knownUsers = [ username ];
  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
    uid = 501;
    shell = pkgs.fish;
  };

  system.primaryUser = username;
  nix.settings.trusted-users = [ username ];

  programs.fish.enable = true;
}
