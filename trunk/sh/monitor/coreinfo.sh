#!/bin/bash

unshared () {
    grep '^[0-9]\+$' "$1" > /dev/null
}

for cpu in $(ls -d /sys/devices/system/cpu/cpu[0-9]* | sort -t u -k 3 -n); do
    echo "${cpu##*/}: [Package #$(cat $cpu/topology/physical_package_id), Core #$(cat $cpu/topology/core_id)]"
    if ! unshared $cpu/topology/core_siblings; then
        echo "  same package as $(cat $cpu/topology/core_siblings)"
    fi
    if ! unshared $cpu/topology/thread_siblings; then
        echo "  same core as    $(cat $cpu/topology/thread_siblings)"
    fi
    for cache in $cpu/cache/index*; do
        printf "  %-15s " "L$(cat $cache/level) $(cat $cache/type):"
        echo "$(cat $cache/size) $(cat $cache/ways_of_associativity)-way with $(cat $cache/coherency_line_size) byte lines"
        if ! unshared $cache/shared_cpu_map; then
            printf "  %-15s [%s]\n" "" "shared with $(cat $cache/shared_cpu_map)"
        fi
    done
    echo
done
