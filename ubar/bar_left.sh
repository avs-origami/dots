#!/bin/sh
disk() {
    df -h | grep root | sed 's/   */ /g' | cut -d' ' -f5
}

temp() {
    temp_raw=$(cat /sys/class/thermal/thermal_zone*/temp | awk '{s+=$1}END{print s/NR}' RS="\n")
    temp=$(echo "$temp_raw / 1000" | bc)
    echo $temp C
}

window() {
    xid=$(grep focused .config/turtle/info.txt | cut -d':' -f2)
    xprop -id $xid _NET_WM_NAME | cut -d'"' -f2
}

echo -n ":D | $(window)"
