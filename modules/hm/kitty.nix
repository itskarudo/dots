{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
    font = {
      package = pkgs.maple-mono.NF;
      name = "Maple Mono NF";
      size = 13;
    };
    settings = {
      enabled_layouts = "splits,stack";
      modify_font = "cell_height 210%";
      disable_ligatures = "cursor";
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      cursor = "#bfad9e";
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
      macos_titlebar_color = "#1a1a1a";
      background = "#1a1a1a";
      foreground = "#dadada";
      selection_background = "#2D4F67";
      selection_foreground = "#bfad9e";
      url_color = "#72A7BC";
      active_tab_background = "#12120f";
      active_tab_foreground = "#bfad9e";
      inactive_tab_background = "#12120f";
      inactive_tab_foreground = "#a6a69c";
      color0 = "#1a1a1a";
      color1 = "#d29393";
      color2 = "#b3b393";
      color3 = "#cbaa89";
      color4 = "#a8a1be";
      color5 = "#b39fb0";
      color6 = "#c0af8c";
      color7 = "#dadada";
      color8 = "#5b5b5b";
      color9 = "#c95954";
      color10 = "#828040";
      color11 = "#a6794c";
      color12 = "#5a6599";
      color13 = "#9c6995";
      color14 = "#74a39e";
      color15 = "#ffffff";
    };
  };
}
