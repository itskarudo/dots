{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      package = pkgs.lilex;
      name = "Lilex";
      size = 13;
    };
    keybindings = {
      "ctrl+\\" = "launch --location=vsplit --cwd=current";
      "ctrl+'" = "launch --location=hsplit --cwd=current";
      "ctrl+a>z" = "combine : toggle_layout stack : scroll_prompt_to_bottom";
    };
    # these bindings need to be in extraConfig bcuz the order matters
    extraConfig = ''
map ctrl+h neighboring_window left
map ctrl+j neighboring_window down
map ctrl+k neighboring_window up
map ctrl+l neighboring_window right
map --when-focus-on var:IS_VIM=true ctrl+h
map --when-focus-on var:IS_VIM=true ctrl+j
map --when-focus-on var:IS_VIM=true ctrl+k
map --when-focus-on var:IS_VIM=true ctrl+l
  '';
    settings = {
      enabled_layouts = "splits,stack";
      modify_font = "cell_height 200%";
      disable_ligatures = "cursor";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      cursor = "#C8C093";
      cursor_text_color = "#ffffff";
      cursor_shape = "block";
      cursor_blink_interval = 0.5;
      cursor_stop_blinking_after = 0;
      scrollback_lines = 5000;
      url_style = "single";
      repaint_delay = 10;
      input_delay = 3;
      sync_to_monitor = "yes";
      enable_audio_bell = "no";
      remember_window_size = "yes";
      window_padding_width = 5.0;
      macos_titlebar_color = "#181616";
      background = "#181616";
      foreground = "#c5c9c5";
      selection_background = "#2D4F67";
      selection_foreground = "#C8C093";
      url_color = "#72A7BC";
      active_tab_background = "#12120f";
      active_tab_foreground = "#C8C093";
      inactive_tab_background = "#12120f";
      inactive_tab_foreground = "#a6a69c";

      color0 = "#0d0c0c";
      color1 = "#c4746e";
      color2 = "#8a9a7b";
      color3 = "#c4b28a";
      color4 = "#8ba4b0";
      color5 = "#a292a3";
      color6 = "#8ea4a2";
      color7 = "#C8C093";
      color8 = "#a6a69c";
      color9 = "#E46876";
      color10 = "#87a987";
      color11 = "#E6C384";
      color12 = "#7FB4CA";
      color13 = "#938AA9";
      color14 = "#7AA89F";
      color15 = "#c5c9c5";
      color16 = "#b6927b";
      color17 = "#b98d7b";
    };
  };
}
