#!/system/bin/sh
STATE="/data/local/tmp/mahiru/sleep/"

rmdir "$STATE"
mkdir -p "$STATE"
while true; do
  SCREEN_STATE=$(dumpsys display | grep "mScreenState" | grep -oE "(ON|OFF)" | head -n 1)

  if [ "$SCREEN_STATE" = "OFF" ]; then
    if [ ! -f "$STATE/sleeping" ]; then

      # the clusters
      # echo 1 > /sys/devices/system/cpu/cpu1/online
      # echo 0 > /sys/devices/system/cpu/cpu2/online
      echo 0 > /sys/devices/system/cpu/cpu3/online
      echo 0 > /sys/devices/system/cpu/cpu4/online
      echo 0 > /sys/devices/system/cpu/cpu5/online
      # echo 0 > /sys/devices/system/cpu/cpu6/online
      echo 0 > /sys/devices/system/cpu/cpu7/online

      # the governor
      cat /sys/devices/system/cpu/cpufreq/policy0/scaling_governor > "$STATE/policy0"
      cat /sys/devices/system/cpu/cpufreq/policy6/scaling_governor > "$STATE/policy6"
      echo "powersave" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
      echo "powersave" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor

      # the gpu
      #cat /sys/class/devfreq/13000000.mali/governor > "$STATE/13000000.mali"
      #cat /sys/devices/platform/soc/10012000.dvfsrc/mtk-dvfsrc-devfreq/devfreq/mtk-dvfsrc-devfreq/governor > "$STATE/mtk.governor"
      #echo "powersave" > /sys/class/devfreq/13000000.mali/governor
      #echo "powersave" > /sys/devices/platform/soc/10012000.dvfsrc/mtk-dvfsrc-devfreq/devfreq/mtk-dvfsrc-devfreq/governor

      touch "$STATE/sleeping"
    fi

    # for the frequency
    # echo 1000000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
    # echo 1000000 > /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq

    # set freq to its min
    echo 500000 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
    echo 725000 > /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq


    # sleep time
    SLEEP="5"
  elif [ "$SCREEN_STATE" = "ON" ]; then
    if [ -f "$STATE/sleeping" ]; then

      # the clusters
      # echo 1 > /sys/devices/system/cpu/cpu1/online
      # echo 1 > /sys/devices/system/cpu/cpu2/online
      echo 1 > /sys/devices/system/cpu/cpu3/online
      echo 1 > /sys/devices/system/cpu/cpu4/online
      echo 1 > /sys/devices/system/cpu/cpu5/online
      # echo 1 > /sys/devices/system/cpu/cpu6/online
      echo 1 > /sys/devices/system/cpu/cpu7/online

      # the governor
      cat "$STATE/policy0" > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
      cat "$STATE/policy6" > /sys/devices/system/cpu/cpufreq/policy6/scaling_governor

      # the gpu
      #cat "$STATE/13000000.mali" > /sys/class/devfreq/13000000.mali/governor
      #cat "$STATE/mtk.governor" > /sys/devices/platform/soc/10012000.dvfsrc/mtk-dvfsrc-devfreq/devfreq/mtk-dvfsrc-devfreq/governor
      
      # for the frequency
      echo "2000000" > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq
      echo "2200000" > /sys/devices/system/cpu/cpufreq/policy6/scaling_max_freq


      rm "$STATE/sleeping"
    fi

    # sleep time
    SLEEP="1"
  fi

  sleep "$SLEEP"
done
