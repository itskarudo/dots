{ pkgs, ... }:
{

  home.packages = with pkgs; [
    (python314.withPackages (
      ps: with ps; [
        ipython
        pefile
        pip
        pycryptodome
        pyelftools
        pwntools
        requests
        setuptools
        unicorn
        z3-solver
      ]
    ))
    apktool
    bun
    cmake
    eza
    # neovim
    ripgrep
    uv
    wget
  ];

  imports = [
    ./fish.nix
    ./tmux.nix
  ];

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

}
