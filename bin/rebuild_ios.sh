#!/usr/bin/env bash

# although Cocoapods exists for Linux (and will be installed with `make init`), it's not worth
# it to debug Cocoapods issues for iOS on a platform that can't even build or test against an iPhone
if [ "$(uname)" == "Darwin" ]; then
	cd ios && pod install --repo-update
elif [ "$(uname)" == "Linux" ]; then
  printf " ### Linux found; skipping cocoapods build."
fi
