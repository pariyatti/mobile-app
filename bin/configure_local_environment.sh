#!/usr/bin/env bash

printf "Configuring local Kosa environment...\n"

LOCAL_IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
  | grep -Eo '([0-9]*\.){3}[0-9]*' \
  | grep -v '127.0.0.1' \
  | grep "192.168")" # sometimes with an iphone plugged in you'll get an extra IP like '169.254.56.99'
printf " └─local IP addr  is '%s'\n" "$LOCAL_IP"

LOCAL_HOST=$(hostname)
printf " └─local hostname is '%s'\n" "$LOCAL_HOST"

# IS_IOS=$(ioreg -p IOUSB -l -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*' | grep -v '^\s.*' | grep "iPhone")
IS_IOS=$(system_profiler SPUSBDataType 2>/dev/null | grep "iPhone")
if [[ "$IS_IOS" == *"iPhone"* ]]; then IOS_DETECTED="yes"; else IOS_DETECTED="no"; fi
printf " └─iOS?     = '%s'\n" "$IOS_DETECTED"

# IS_ANDROID=$(ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*' | grep -v '^\s.*' | grep "Android")
IS_ANDROID=$(system_profiler SPUSBDataType 2>/dev/null | grep "Android")
if [[ "$IS_ANDROID" == *"Android"* ]]; then ANDROID_DETECTED="yes"; else ANDROID_DETECTED="no"; fi
printf " └─Android? = '%s'\n" "$ANDROID_DETECTED"

# TODO: this should check for an attached iPhone in addition to the host OS
if [ "$(uname)" == "Darwin" ] && [[ "$IS_IOS" == *"iPhone"* ]]; then
  printf " └─iPhone (MacOS) found: setting local hostname in lib/Environment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_HOST/g" './lib/EnvironmentTemplate.dart' > './lib/Environment.dart'
else
  printf " └─Android found: setting local IP in lib/Environment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_IP/g" './lib/EnvironmentTemplate.dart' > './lib/Environment.dart'
fi

printf "\n"
