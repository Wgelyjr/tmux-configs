#!/bin/bash
# Functions for a tmux status bar

function memory_usage() {

    if [ "$(which bc)" ]; then

        # Display used, total, and percentage of memory using the free command.
        read used total <<< $(free -m | awk '/Mem/{printf $2" "$3}')
        # Calculate the percentage of memory used with bc.
        percent=$(bc -l <<< "100 * $total / $used")
        # Feed the variables into awk and print the values with formating.
        awk -v t=$total 'BEGIN {printf "%sMi",t}'

    fi

}


function battery_meter() {

	cat /sys/firmware/beepy/battery_volts | sed 's/$/V/'

}

function cpu_temp() {

	vcgencmd measure_temp | grep -E -o '[[:digit:]]{1,}\.[[:digit:]]' | sed 's/$/C/' | sed -z "s/\n//g"
}

function main() {

	printf '%s | %s | %s ' "$(memory_usage)" "$(cpu_temp)" "$(battery_meter)"

}

main
