env = sandbox
.PHONY: help init-flutter init test run
# HELP sourced from https://gist.github.com/prwhite/8168133

# Add help text after each target name starting with '\#\#'
# A category can be added with @category
HELP_FUNC = \
    %help; \
    while(<>) { \
        if(/^([a-z0-9_-]+):.*\#\#(?:@(\w+))?\s(.*)$$/) { \
            push(@{$$help{$$2}}, [$$1, $$3]); \
        } \
    }; \
    print "usage: make [target] env=<sandbox>\n\n"; \
    for ( sort keys %help ) { \
        print "$$_:\n"; \
        printf("  %-20s %s\n", $$_->[0], $$_->[1]) for @{$$help{$$_}}; \
        print "\n"; \
    }

help: ##@Miscellaneous Show this help.
	@perl -e '$(HELP_FUNC)' $(MAKEFILE_LIST)

init-clean: ##@Setup Remove Flutter packages
	flutter pub cache clean

init-flutter:  # Hidden@Setup Download Flutter deps, precompile
	flutter pub get

init: init-flutter ##@Setup Default config + pub get
	sudo gem install cocoapods

clean_local_environment:
	rm -f lib/Environment.dart

clean: clean_local_environment ##@Development Clean various caches
	rm -rf ~/.gradle/caches/*
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf ./Pods
	cd ios && pod cache clean --all
	cd ios && pod install --repo-update
	flutter clean

repair: clean ##@Development Repair and clean Flutter
	flutter pub cache repair

repair-xcode: ##@Development Run a build in XCode to repair mysterious failures
	open ios/Runner.xcworkspace

build: ##@Development (Re)build project
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs

watch: ##@Development Build continuously (gen files)
	flutter packages pub run build_runner watch --delete-conflicting-outputs

test: ##@Development Run tests against a connected device
	flutter test --machine

lib/Environment.dart:
	./bin/configure_local_environment.sh

run: clean_local_environment lib/Environment.dart ##@Development Run a debug build against 'env' (local, sandbox, or production)
	flutter run --dart-define=BUILD_ENV=$(env)

