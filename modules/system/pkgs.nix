{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ jdk21 ];
}
