{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    mouse = true;
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 0;
    prefix = "C-a";
    plugins = with pkgs; [
      tmuxPlugins.sensible
      tmuxPlugins.vim-tmux-navigator
    ];
    extraConfig = ''
      set -as terminal-features ",xterm-256color:RGB"

      bind \\ split-window -h -c "#{pane_current_path}"
      bind "'" split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      bind c new-window -c "#{pane_current_path}"

      bind C-l send-keys 'C-l'

      set-option -g status-position bottom
      set -g focus-events on
      set -g status-style bg=default
      set -g status-left-length 99
      set -g status-right-length 99
      set -g status-justify absolute-centre
      set -g allow-passthrough on


      set -g status-left ""
      set -g status-right ""
      set -g window-status-current-style 'bg=color2,fg=color0'
      set -g window-status-format ' #W#{?window_zoomed_flag,*,} '
      set -g window-status-current-format ' #[bold]#W#{?window_zoomed_flag,*,} '

      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'C-v' send -X rectangle-toggle
      bind-key -T copy-mode-vi 'y' send -X copy-selection
    '';
  };
}
