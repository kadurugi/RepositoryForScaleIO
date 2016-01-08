#!/bin/sh

device_name=""
devices=""

for i in $@
do
 device_name=$i
 device_name=$(echo $device_name | sed "s|/dev/||g")
 partcount=$(ls /dev | grep $device_name[0-9a-zA-Z] | wc -l)
 result=$(ls /dev | grep $device_name[0-9a-zA-Z] | grep -v $partcount)

 for j in $result 
  do
   echo $j >> /tmp/scaleio/devices
  done
done

#echo -n $devices >> /tmp/deleteme

