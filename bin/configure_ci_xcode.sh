#!/usr/bin/env bash

printf "Configuring CI XCode project...\n"

(
  printf "\nSanity check...\n"
  REPO=$(dirname "$0")/..
  if [ "$REPO" != "./bin/.." ]; then
    printf "####\n"
    printf "'configure_ci_xcode.sh' must be run from repo root. Exiting.\n"
    exit 1
  fi

  sed -i.bak -E '/.*LastSwiftMigration.*/r codemagic_hack.pbxproj' ios/Runner.xcodeproj/project.pbxproj
  sed -i.bak 's/CODE_SIGN_IDENTITY = "Apple Development";/CODE_SIGN_IDENTITY = "iPhone Distribution";/' ios/Runner.xcodeproj/project.pbxproj
  sed -i.bak 's/CODE_SIGN_STYLE = Automatic;/CODE_SIGN_STYLE = Manual;/' ios/Runner.xcodeproj/project.pbxproj
  sed -i.bak 's/PROVISIONING_PROFILE_SPECIFIER = "";/PROVISIONING_PROFILE_SPECIFIER = "Pariyatti App";/' ios/Runner.xcodeproj/project.pbxproj
)

printf "...done configuring CI XCode."
printf "\n"
