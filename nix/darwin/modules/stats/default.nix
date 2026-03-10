{ config, ... }:
{
  imports = [ ../brew ];

  homebrew.casks = [ "stats" ];

  home-manager.users.${config.common.username} = {
    targets.darwin.defaults = {
      "eu.exelban.Stats" = {
        Battery_battery_additional = "percentageAndTime";
        Battery_battery_color = 1;
        Battery_battery_xlSize = 1;
        CPU_barChart_position = 3;
        CPU_label_position = 1;
        CPU_lineChart_position = 0;
        CPU_line_chart_box = 0;
        CPU_line_chart_color = "utilization";
        CPU_line_chart_frame = 1;
        CPU_line_chart_label = 1;
        CPU_line_chart_value = 0;
        CPU_line_chart_valueColor = 0;
        CPU_widget = "line_chart";
        Disk_barChart_position = 1;
        Disk_label_position = 0;
        Disk_networkChart_position = 2;
        Disk_oneView = 1;
        Disk_widget = "label,bar_chart,network_chart";
        GPU_lineChart_position = 0;
        GPU_line_chart_box = 0;
        GPU_line_chart_frame = 1;
        GPU_line_chart_label = 1;
        GPU_state = 1;
        GPU_widget = "line_chart";
        LaunchAtLoginNext = 1;
        "NSStatusItem Preferred Position Battery_battery" = 177;
        "NSStatusItem Preferred Position CPU_line_chart" = 178;
        "NSStatusItem Preferred Position Disk" = 180;
        "NSStatusItem Preferred Position GPU_line_chart" = 179;
        "NSStatusItem Preferred Position Network_speed" = 182;
        "NSStatusItem Preferred Position RAM_pie_chart" = 181;
        "NSToolbar Configuration eu.exelban.Stats.Settings.Toolbar" = {
          "TB Display Mode" = 1;
          "TB Icon Size Mode" = 1;
          "TB Is Shown" = 1;
          "TB Size Mode" = 1;
        };
        Network_publicIPRefreshInterval = "hour";
        Network_speed_iconColor = "transparent";
        Network_speed_position = 0;
        Network_state_position = 3;
        Network_widget = "speed";
        RAM_chartColor = "system";
        RAM_notifications_pressure_state = 1;
        RAM_notifications_pressure_value = "warning";
        RAM_pieChart_position = 0;
        RAM_pie_chart_label = 1;
        RAM_widget = "pie_chart";
        SSD_bar_chart_box = 0;
        SSD_bar_chart_frame = 1;
        SSD_network_chart_frame = 1;
        runAtLoginInitialized = 1;
        setupProcess = 1;
        support_ts = 1773171710;
        update-interval = "Silent";
        version = "2.12.3";
      };
    };
  };
}
