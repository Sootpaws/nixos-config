{ lib, ... }: {
    programs.i3status-rust = {
        enable = true;
        bars.default = {
            icons = "material-nf";
            blocks = [
                {
                    block = "music";
                    format = " $icon $combo ";
                    interface_name_exclude = [ "firefox.*" ];
                }
                {
                    block = "temperature";
                    interval = 1;
                }
                {
                    block = "cpu";
                    format = lib.concatStrings [
                        " $icon $utilization $barchart "
                        "$frequency.eng(w:3) avg, $max_frequency.eng(w:3) max "
                    ];
                    interval = 1;
                }
                {
                    block = "memory";
                    format = lib.concatStrings [
                        " $icon "
                        "$mem_total_used.eng(prefix:M)/"
                        "$mem_total.eng(prefix:M)"
                        "($mem_total_used_percents.eng(w:2)) "
                        "+ $icon_swap "
                        "$swap_used.eng(prefix:M)/"
                        "$swap_total.eng(prefix:M)"
                        "($swap_used_percents.eng(w:2)) "
                    ];
                    interval = 1;
                }
                {
                    block = "net";
                    format = lib.concatStrings [
                        " $icon  {$signal_strength |}"
                        "$speed_up.eng(prefix:K)^icon_net_up "
                        "$speed_down.eng(prefix:K)^icon_net_down "
                    ];
                    interval = 1;
                    click = [{
                        button = "left";
                        cmd = "alacritty --command nmtui";
                    } {
                        button = "right";
                        cmd = "rfkill toggle all";
                    }];
                }
                {
                    block = "backlight";
                    step_width = 1;
                    minimum = 0;
                }
                {
                    block = "sound";
                    step_width = 1;
                    show_volume_when_muted = true;
                    headphones_indicator = true;
                    click = [{
                        button = "left";
                        cmd = "pavucontrol";
                    }];
                }
                {
                    block = "battery";
                    full_threshold = 99;
                    empty_threshold = 1;
                    format = " $icon $percentage -> $power $time ";
                    charging_format = " $icon $percentage <- $power $time ";
                    interval = 1;
                }
                {
                    block = "time";
                    format = " $icon $timestamp.datetime(f:'%m/%d/%Y %r') ";
                    interval = 1;
                }
            ];
        };
    };
}
