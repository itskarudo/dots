{

  services.yabai = {
    enable = true;
    enableScriptingAddition = true;
    config = {
      layout = "bsp";
      window_gap = 6;
      focus_follows_mouse = "off";
      window_shadow = "float";
      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";
    };
    extraConfig = ''
      yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
      sudo yabai --load-sa

      yabai -m signal --add event=mission_control_exit action='echo "refresh" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=display_added action='echo "refresh" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=display_removed action='echo "refresh" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_created action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_destroyed action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_focused action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_moved action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_resized action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_minimized action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'
      yabai -m signal --add event=window_deminimized action='echo "refresh windows" | nc -U /tmp/yabai-indicator.socket'

      yabai -m rule --add app="^(Calculator|System Preferences|System Settings|Archive Utility)$" manage=off
      yabai -m rule --add title="^Preferences" manage=off
      yabai -m rule --add title="^Settings" manage=off
      yabai -m rule --add app="^Notes$" manage=off
      yabai -m rule --add app="^QuickTime Player$" manage=off
      yabai -m rule --add app="^Weather$" manage=off

      yabai -m rule --add app="^Arc$" manage=on

      yabai -m rule --add app=".*" sub-layer=normal
    '';
  };

  services.skhd = {
    enable = true;
    skhdConfig = ''
      alt - h : yabai -m window --focus west
      alt - l : yabai -m window --focus east
      alt - j : yabai -m window --focus south
      alt - k : yabai -m window --focus north

      alt + shift - h : yabai -m window --warp west
      alt + shift - l : yabai -m window --warp east
      alt + shift - j : yabai -m window --warp south
      alt + shift - k : yabai -m window --warp north

      ctrl + alt - h : yabai -m window --resize left:-100:0 ; yabai -m window --resize right:-100:0
      ctrl + alt - j : yabai -m window --resize bottom:0:100 ; yabai -m window --resize top:0:100
      ctrl + alt - k : yabai -m window --resize top:0:-100 ; yabai -m window --resize bottom:0:-100
      ctrl + alt - l : yabai -m window --resize right:100:0 ; yabai -m window --resize left:100:0

      alt - 1 : yabai -m space --focus 1
      alt - 2 : yabai -m space --focus 2
      alt - 3 : yabai -m space --focus 3
      alt - 4 : yabai -m space --focus 4
      alt - 5 : yabai -m space --focus 5
      alt - 6 : yabai -m space --focus 6
      alt - 7 : yabai -m space --focus 7
      alt - 8 : yabai -m space --focus 8
      alt - 9 : yabai -m space --focus 9

      alt + shift - 1 : yabai -m window --space 1 --focus
      alt + shift - 2 : yabai -m window --space 2 --focus
      alt + shift - 3 : yabai -m window --space 3 --focus
      alt + shift - 4 : yabai -m window --space 4 --focus
      alt + shift - 5 : yabai -m window --space 5 --focus
      alt + shift - 6 : yabai -m window --space 6 --focus
      alt + shift - 7 : yabai -m window --space 7 --focus
      alt + shift - 8 : yabai -m window --space 8 --focus
      alt + shift - 9 : yabai -m window --space 9 --focus

      alt - space : yabai -m window --toggle float

      alt - f         : yabai -m window --toggle zoom-fullscreen
      alt - d         : yabai -m space --toggle padding --toggle gap

      alt - o         : yabai -m config focus_follows_mouse autofocus
      alt - p         : yabai -m config focus_follows_mouse off

      cmd - return : bash -c 'pid=$(pgrep kitty); [ -n "$pid" ] && kitten @ "--to=unix:/tmp/kitty-$pid" launch --type=os-window || open -a Kitty.app'

      alt - b : open -a Zen
    '';
  };

}
