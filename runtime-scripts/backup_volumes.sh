#!/bin/bash 

timestamp() {
  date +"%Y-%m-%dT%H:%M:%S"
}

volume_prefixes=( influxdb chronograf telegraf kapacitor )

for i in "${volume_prefixes[@]}"
do
  archive_name="backup_${i}_$(timestamp).tar.bz2"
  volume_name="${i}-data-volume"  
  echo "processing: ${volume_name} ..."
  docker run --rm -v ${volume_name}:/volume -v $(pwd):/backup hypriot/armhf-busybox tar -cjf /backup/${archive_name} -C /volume ./
done
