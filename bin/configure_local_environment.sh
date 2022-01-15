#!/usr/bin/env bash

LOCAL_IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
  | grep -Eo '([0-9]*\.){3}[0-9]*' \
  | grep -v '127.0.0.1' \
  | grep "192.168")" # sometimes with an iphone plugged in you'll get an extra IP like '169.254.56.99'
printf "local IP is '%s'\n" "$LOCAL_IP"

printf "setting local IP in lib/Environment.dart...\n"
sed -e "s/%MAKE_IP%/$LOCAL_IP/g" './lib/EnvironmentTemplate.dart' > './lib/Environment.dart'
