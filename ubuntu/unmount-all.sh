#!/bin/sh
# Unmount all drives loaded in /mnt

for drives in `ls /mnt`
do
  umount /mnt/$drives;
done;