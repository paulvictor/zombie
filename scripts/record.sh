#!/bin/bash
seconds=`date +%s`
BASE_URL="http://localhost:9000/patient_temperatures"
temp=`cat | tail -1 | awk -F'=' '{print $2}'`
curl -X POST $BASE_URL -F "patient_temperature[sampling_time]=$seconds" -F "patient_temperature[temperature]=$temp"
