{ pkgs, config, ... }:
let
  nvimPackages = with pkgs; [
    tree-sitter
    astro-language-server
    biome
    clang-tools
    lua-language-server
    nixd
    nixfmt
    prettierd
    pyright
    ruff
    rust-analyzer
    stylua
    texlab
    tinymist
    typescript-go
    vscode-langservers-extracted
  ];
in
{

  home.packages =
    with pkgs;
    [
      (python314.withPackages (
        ps: with ps; [
          ipython
          pefile
          pip
          pycryptodome
          pyelftools
          # pwntools
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
      neovim
      ripgrep
      uv
      wget
    ]
    ++ nvimPackages;

  imports = [
    ./fish.nix
    ./tmux.nix
  ];

  xdg.configFile."nvim".source = config.lib.file.mkOutOfStoreSymlink "/etc/nix-darwin/configs/nvim";

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    options = [ "--cmd cd" ];
  };

}
