{
  inputs,
  lib,
  config,
  ...
}:
{
  imports = [
    (inputs.nix-wrapper-modules.lib.getInstallModule {
      name = "neovim";
      value = inputs.nix-wrapper-modules.lib.wrapperModules.neovim;
    })
  ];

  wrappers.neovim = { pkgs, ... }: {
    enable = true;
    settings.config_directory = ../../configs/nvim;

    specs.lze = with pkgs.vimPlugins; [
      lze
      lzextras
    ];

    specs.general = with pkgs.vimPlugins; [
      kanagawa-nvim
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
    ];

    specs.lazy = with pkgs.vimPlugins; {
      lazy = true;
      data = [
        nvim-autopairs
        barbar-nvim
        blink-cmp
        conform-nvim
        gitsigns-nvim
        heirline-nvim
        indent-blankline-nvim
        nvim-lspconfig
        neo-tree-nvim
        nvim-treesitter
        typst-preview-nvim
        vim-kitty-navigator
        vimtex
        nvim-web-devicons
      ];
    };

    runtimePkgs = with pkgs; [
      astro-language-server
      biome
      clang-tools
      lua-language-server
      nixd
      nixfmt
      prettierd
      ruff
      rust-analyzer
      stylua
      tinymist
      ty
      typescript-language-server
      vscode-langservers-extracted
    ];

  };

  home.sessionVariables = {
    EDITOR = lib.getExe config.wrappers.neovim.wrapper;
  };
}
