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

# Hidden@Setup Copy default config
config/app_config.json:
	echo Copying default config...
	cp config/app_config.sample.json config/app_config.json
	echo Please add config secrets to 'config/app_config.json'.

init-flutter:  ##@Setup Download Flutter deps, precompile
	flutter pub get
	flutter pub run build_runner build

init: config/app_config.json init-flutter ##@Setup Configure Flutter

clean: ##@Development Clean various caches
	cd ios && rm -rf Podfile.lock
	cd ios && rm -rf ./Pods
	cd ios && pod cache clean --all
	cd ios && pod install --repo-update
	flutter clean

build: ##@Development (Re)build project
	flutter pub get
	flutter pub run build_runner build --delete-conflicting-outputs

watch: ##@Development Build continuously (gen files)
	flutter packages pub run build_runner watch --delete-conflicting-outputs

test: ##@Development Run tests against a connected device
	flutter test --machine

run: ##@Development Run a debug build against 'env' (local, sandbox, or production)
	flutter run --target lib/main_$(env).dart
