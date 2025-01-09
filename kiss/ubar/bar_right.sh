#!/bin/sh

battery() {
	echo BAT $(cat /sys/class/power_supply/BAT1/capacity)%
}

mem() {
	used=$(free -m | sed -e '/Mem/!d' -e 's/   */ /g' | cut -d' ' -f3)
	total=$(free -m | sed -e '/Mem/!d' -e 's/   */ /g' | cut -d' ' -f2)
	echo MEM $((100 * $used / $total))%
}

cpu() {
	cpu=$(iostat | grep -A1 avg-cpu | sed -e 's/   */ /g' | cut -d' ' -f2 | grep -v %user | xargs printf "%.*f\n" "$p")
	echo CPU $cpu%
}

temp() {
    temp_raw=$(cat /sys/class/thermal/thermal_zone*/temp | awk '{s+=$1}END{print s/NR}' RS="\n")
    temp=$(echo "$temp_raw / 1000" | bc)
    echo TEMP $temp C
}

datetime() {
	echo $(date | cut -d':' -f1,2)
}

echo -n " $(battery) | $(mem) | $(cpu) | $(temp) | $(datetime) "
