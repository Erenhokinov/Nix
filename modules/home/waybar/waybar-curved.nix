{
  pkgs,
  lib,
  host,
  config,
  ...
}: let
  betterTransition = "all 0.25s ease-in-out";
  inherit (import ../../../hosts/${host}/variables.nix) clock24h;
in
  with lib; {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar;
      settings = [
        {
          layer = "top";
          position = "top";
          modules-center = ["hyprland/workspaces"];
          modules-left = [
            "custom/startmenu"
            "hyprland/window"
            "pulseaudio"
            "cpu"
            "memory"
            "idle_inhibitor"
          ];
          modules-right = [
            "custom/hyprbindings"
            "custom/notification"
            "custom/exit"
            "battery"
            "tray"
            "clock"
          ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              default = "";
              active = "";
              urgent = "";
            };
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };
          "clock" = {
            format =
              if clock24h == true
              then ''{:L%H:%M}''
              else ''{:L%I:%M %p}'';
            tooltip = true;
            tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          };
          "hyprland/window" = {
            max-length = 22;
            separate-outputs = false;
            rewrite = {
              "" = " 🙈 No Windows? ";
            };
          };
          "memory" = {
            interval = 5;
            format = " {}%";
            tooltip = true;
          };
          "cpu" = {
            interval = 5;
            format = " {usage:2}%";
            tooltip = true;
          };
          "pulseaudio" = {
            format = "{icon} {volume}% {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = " {volume}%";
            format-source-muted = "";
            format-icons = {
              headphone = "";
              hands-free = "";
              headset = "";
              phone = "";
              portable = "";
              car = "";
              default = ["" "" ""];
            };
            on-click = "sleep 0.1 && pavucontrol";
          };
          "custom/exit" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && wlogout";
          };
          "custom/startmenu" = {
            tooltip = false;
            format = "";
            on-click = "sleep 0.1 && rofi-launcher";
          };
          "custom/hyprbindings" = {
            tooltip = false;
            format = "󱕴";
            on-click = "sleep 0.1 && list-keybinds";
          };
          "idle_inhibitor" = {
            format = "{icon}";
            format-icons = {
              activated = "";
              deactivated = "";
            };
            tooltip = "true";
          };
          "custom/notification" = {
            tooltip = false;
            format = "{icon} {}";
            format-icons = {
              notification = "<span foreground='red'><sup></sup></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sup></sup></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sup></sup></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "sleep 0.1 && task-waybar";
            escape = true;
          };
          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{icon} {capacity}%";
            format-charging = "󰂄 {capacity}%";
            format-plugged = "󱘖 {capacity}%";
            format-icons = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
            on-click = "";
            tooltip = false;
          };
        }
      ];
      style = concatStrings [
        ''
          * {
            font-family: JetBrainsMono Nerd Font Mono;
            font-size: 16px;
            border-radius: 0px;
            border: none;
            min-height: 0px;
          }

          window#waybar {
            background-color: alpha(#${config.lib.stylix.colors.base00}, 0.75);
          }

          #workspaces {
            background: transparent;
            margin: 0px;
            padding: 0px 10px;
          }
          #workspaces button {
            min-width: 13px;
            min-height: 13px;
            padding: 0px;
            margin: 0px 6px;
            border-radius: 50%;
            background-color: alpha(#${config.lib.stylix.colors.base05}, 0.35);
            border: none;
            transition: ${betterTransition};
          }
          #workspaces button.active {
            background-color: transparent;
            border: 2px solid #${config.lib.stylix.colors.base0D};
            min-width: 14px;
            min-height: 14px;
          }
          #workspaces button:hover {
            background-color: alpha(#${config.lib.stylix.colors.base0D}, 0.5);
          }

          #window, #pulseaudio, #cpu, #memory, #idle_inhibitor,
          #custom-hyprbindings, #network, #battery,
          #custom-notification, #tray, #custom-exit, #clock, #custom-startmenu {
            background: transparent;
            color: #${config.lib.stylix.colors.base05};
            padding: 0px 14px;
            margin: 0px;
          }

          tooltip {
            background: #${config.lib.stylix.colors.base00};
            border: 1px solid #${config.lib.stylix.colors.base08};
            border-radius: 12px;
          }
          tooltip label {
            color: #${config.lib.stylix.colors.base08};
          }
        ''
      ];
    };
  }
