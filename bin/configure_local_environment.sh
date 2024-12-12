#!/usr/bin/env bash

printf "Configuring local Kosa environment...\n"

LOCAL_IP="$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
  | grep -Eo '([0-9]*\.){3}[0-9]*' \
  | grep -v '127.0.0.1' \
  | grep -Eo '(172|192).*')" # sometimes with an iphone plugged in you'll get an extra IP like '169.254.56.99'
                             # some IPs are in the range (172.*.*.*), so we check for both 172.* and 192.*
printf " └─local IP addr  is '%s'\n" "$LOCAL_IP"

LOCAL_HOST=$(hostname)
printf " └─local hostname is '%s'\n" "$LOCAL_HOST"

if [ "$(uname)" == "Darwin" ]; then
  USB_DETECT=$(system_profiler SPUSBDataType 2>/dev/null)
elif [ "$(uname)" == "Linux" ]; then
  USB_DETECT=$(lsusb -v 2>/dev/null)
else
  printf " └─UNKNOWN OPERATING SYSTEM: %s\n" "$(uname)"
  printf "                             Failed.\n"
  exit 1
fi

# IS_IOS=$(ioreg -p IOUSB -l -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*' | grep -v '^\s.*' | grep "iPhone")
IS_IOS=$(echo "$USB_DETECT" | grep -E ".*(iPod|iPhone|iPad).*")
if [[ "$IS_IOS" == *"iP"* ]]; then IOS_DETECTED="yes"; else IOS_DETECTED="no"; fi
printf " └─iOS?     = '%s'\n" "$IOS_DETECTED"

# IS_ANDROID=$(ioreg -p IOUSB -w0 | sed 's/[^o]*o //; s/@.*$//' | grep -v '^Root.*' | grep -v '^\s.*' | grep "Android")
IS_ANDROID=$(echo "$USB_DETECT" | grep "Android")
if [[ "$IS_ANDROID" == *"Android"* ]]; then ANDROID_DETECTED="yes"; else ANDROID_DETECTED="no"; fi
printf " └─Android? = '%s'\n" "$ANDROID_DETECTED"

if [ "$(uname)" == "Darwin" ] && [[ "$IS_IOS" == *"iP"* ]]; then
  printf " └─iPhone (MacOS) found: setting local hostname in lib/LocalEnvironment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_HOST/g" './lib/LocalEnvironmentTemplate.dart' > './lib/LocalEnvironment.dart'
elif [[ "$IS_ANDROID" == *"Android"* ]]; then
  printf " └─Android found: setting local IP in lib/LocalEnvironment.dart...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_IP/g" './lib/LocalEnvironmentTemplate.dart' > './lib/LocalEnvironment.dart'
else
  printf " └─NO DEVICE FOUND: Did you connect the phone, unlock it, and trust the computer?\n"
  printf "                    Using local IP address to create lib/LocalEnvironment.dart (for CI)...\n"
  sed -e "s/%MAKE_IP%/$LOCAL_IP/g" './lib/LocalEnvironmentTemplate.dart' > './lib/LocalEnvironment.dart'
fi

printf "\n"
