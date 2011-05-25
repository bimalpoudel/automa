#!/bin/sh
# Mount all possible drives, b,c,d,e,f

# automated mount/unmount of the devices
# 1:03 AM 5/10/2011

for letter in b c d e f
do
  for hdd in `ls /dev/sd${letter}?`
  do
  
  if [ -f $hdd ]; then
    dir=$(echo $hdd|sed 's/\/dev\/sd/hd/')
    umount $hdd
    mkdir -p /mnt/$dir
    mount $hdd /mnt/$dir
  fi;
  done;
  echo $letter
done;