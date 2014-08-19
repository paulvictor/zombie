#!/bin/bash
if [ -f /home/viktor/stuff/zombie/started ]
then
  seconds=`date +%s`
  echo $seconds
  BASE_URL="http://localhost:8000/patient_temperatures"
  temp=`cat /sys/bus/w1/devices/28-0000053c9d05/w1_slave | tail -1 | awk -F'=' '{print $2}'`
  echo $temp
  curl -X POST $BASE_URL -F "patient_temperature[sampling_time]=$seconds" -F "patient_temperature[temperature]=$temp"
fi
