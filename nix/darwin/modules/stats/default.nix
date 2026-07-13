{
  config,
  lib,
  ...
}:
{
  imports = [ ../brew ];

  options.brooklyn.programs.stats.enable = lib.mkEnableOption "stats" // {
    default = true;
  };

  config = lib.mkIf config.brooklyn.programs.stats.enable {
    homebrew.casks = [ "stats" ];

    home-manager.users.${config.common.username} = {
      targets.darwin.defaults = {
        "eu.exelban.Stats" = {
          "Battery_battery_additional" = "percentageAndTime";
          "Battery_battery_color" = 1;
          "Battery_battery_xlSize" = 1;
          "Battery_position" = 7;
          "Bluetooth_position" = 0;
          "CPU_barChart_position" = 0;
          "CPU_bar_chart_box" = 0;
          "CPU_bar_chart_color" = "utilization";
          "CPU_bar_chart_frame" = 1;
          "CPU_bar_chart_label" = 1;
          "CPU_label_position" = 2;
          "CPU_lineChart_position" = 4;
          "CPU_line_chart_box" = 0;
          "CPU_line_chart_color" = "utilization";
          "CPU_line_chart_frame" = 1;
          "CPU_line_chart_label" = 1;
          "CPU_line_chart_value" = 0;
          "CPU_line_chart_valueColor" = 0;
          "CPU_mini_position" = 3;
          "CPU_pieChart_position" = 5;
          "CPU_position" = 5;
          "CPU_tachometer_label" = 1;
          "CPU_tachometer_position" = 1;
          "CPU_widget" = "bar_chart";
          "Clock_position" = 8;
          CombinedModules = 1;
          "CombinedModules_popup" = 0;
          "CombinedModules_spacing" = 3;
          "Disk_barChart_position" = 0;
          "Disk_label_position" = 1;
          "Disk_memory_position" = 4;
          "Disk_mini_position" = 2;
          "Disk_networkChart_position" = 7;
          "Disk_oneView" = 1;
          "Disk_pieChart_position" = 3;
          "Disk_position" = 3;
          "Disk_speed_position" = 5;
          "Disk_text_position" = 6;
          "Disk_widget" = "bar_chart";
          "GPU_barChart_position" = 0;
          "GPU_bar_chart_box" = 0;
          "GPU_bar_chart_color" = "utilization";
          "GPU_bar_chart_frame" = 1;
          "GPU_bar_chart_label" = 1;
          "GPU_label_position" = 1;
          "GPU_lineChart_position" = 0;
          "GPU_line_chart_box" = 0;
          "GPU_line_chart_color" = "utilization";
          "GPU_line_chart_frame" = 1;
          "GPU_line_chart_label" = 1;
          "GPU_position" = 4;
          "GPU_state" = 1;
          "GPU_widget" = "bar_chart";
          LaunchAtLoginNext = 1;
          "NSStatusItem Preferred Position CPU_line_chart" = 178;
          "NSStatusItem Preferred Position CombinedModules" = 184;
          "NSStatusItem Preferred Position GPU_line_chart" = 179;
          "NSStatusItem Restore Position Disk" = 180;
          "NSToolbar Configuration eu.exelban.Stats.Settings.Toolbar" = {
            "TB Display Mode" = 1;
            "TB Icon Size Mode" = 1;
            "TB Is Shown" = 1;
            "TB Size Mode" = 1;
          };
          "NSWindow Frame eu.exelban.Stats.Settings.WindowFrame" = "396 286 728 480 0 0 1512 949 ";
          "Network_interfaceDetails" = 0;
          "Network_position" = 1;
          "Network_publicIPRefreshInterval" = "hour";
          "Network_speed_iconColor" = "transparent";
          "Network_speed_position" = 0;
          "Network_state_position" = 3;
          "Network_widget" = "speed";
          "RAM_chartColor" = "system";
          "RAM_notifications_pressure_state" = 1;
          "RAM_notifications_pressure_value" = "warning";
          "RAM_pieChart_position" = 0;
          "RAM_pie_chart_label" = 1;
          "RAM_position" = 2;
          "RAM_widget" = "pie_chart";
          "Remote_position" = 9;
          "SSD_bar_chart_box" = 0;
          "SSD_bar_chart_frame" = 1;
          "SSD_bar_chart_label" = 1;
          "SSD_network_chart_frame" = 1;
          "Sensors_position" = 6;
          "remote_tokens_migrated_to_keychain" = 1;
          runAtLoginInitialized = 1;
          setupProcess = 1;
          "support_ts" = 1781117304;
          "update-interval" = "Silent";
          "updater_check_ts" = 1781117202;
          version = "3.0.1";
        };
      };
    };
  };
}
