#!/usr/bin/env bash

(

  cd $(dirname "$0")/..

  # although Cocoapods exists for Linux (and will be installed with `make init`), it's not worth
  # it to debug Cocoapods issues for iOS on a platform that can't even build or test against an iPhone
  if [ "$(uname)" == "Darwin" ]; then
    (
      cd ios
      rm -rf Podfile.lock
      rm -rf ./Pods
      pod cache clean --all
    )
  elif [ "$(uname)" == "Linux" ]; then
    printf " ### Linux found; skipping cocoapods clean."
  fi

)
