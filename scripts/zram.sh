#!/system/bin/sh
swapoff /dev/block/zram0
zramctl --reset /dev/block/zram0
echo 'lz4' > /sys/block/zram0/comp_algorithm
echo 4294967296 > /sys/block/zram0/disksize
mkswap /dev/block/zram0
swapon /dev/block/zram0

echo 100 > /proc/sys/vm/swappiness
echo 1 > /proc/sys/vm/laptop_mode
echo 1 > /proc/sys/kernel/sched_child_runs_first
