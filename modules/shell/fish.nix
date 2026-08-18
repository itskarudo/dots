_: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      if command -q nix-your-shell
        nix-your-shell fish | source
      end

      function fish_user_key_bindings
        fish_vi_key_bindings
        bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
      end

      set fish_greeting
      set fish_key_bindings fish_user_key_bindings
    '';

    shellAliases = {
      gic = "git clone";
      gs = "git status";
      ls = "eza --icons auto";
      objdump = "objdump -M intel";
      py = "ipython";
      v = "nvim";
    };
  };
}
