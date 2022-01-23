#!/usr/bin/env bash

LOCAL_IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
  | grep -Eo '([0-9]*\.){3}[0-9]*' \
  | grep -v '127.0.0.1' \
  | grep "192.168")" # sometimes with an iphone plugged in you'll get an extra IP like '169.254.56.99'
printf "local IP is '%s'\n" "$LOCAL_IP"

LOCAL_HOST=$(hostname)
printf "local hostname is '%s'\n" "$LOCAL_HOST"

# TODO: this should check for an attached iPhone in addition to the host OS
if [ "$(uname)" == "Darwin" ]; then
  printf "MacOS found: setting local hostname in lib/Environment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_HOST/g" './lib/EnvironmentTemplate.dart' > './lib/Environment.dart'
else
  printf "Linux found: setting local IP in lib/Environment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_IP/g" './lib/EnvironmentTemplate.dart' > './lib/Environment.dart'
fi
