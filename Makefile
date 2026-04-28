HOSTNAME := $(shell hostname -s)
ACTIONS := build
SUDO_ACTIONS := check
REBUILD_CMD = $(if $(shell test -f /etc/NIXOS && echo true),nixos-rebuild,darwin-rebuild) $@
SUDO_REBUILD_CMD = $(if $(shell test -f /etc/NIXOS && echo true),$(REBUILD_CMD) --sudo,sudo $(REBUILD_CMD))
REBUILD_ARGS = --flake .\#$(HOSTNAME)

.DEFAULT_GOAL := switch

.PHONY: $(ACTIONS)
$(ACTIONS):
	$(REBUILD_CMD) $(REBUILD_ARGS)

.PHONY: $(SUDO_ACTIONS)
$(SUDO_ACTIONS):
	$(SUDO_REBUILD_CMD) $(REBUILD_ARGS)

.PHONY: switch
switch:
	$(SUDO_REBUILD_CMD) $(REBUILD_ARGS)
	@gen=$$(readlink /nix/var/nix/profiles/system | sed -E 's/^system-([0-9]+)-link$$/\1/'); \
	prev=$$((gen - 1)); \
	nix store diff-closures /nix/var/nix/profiles/system-$$prev-link /nix/var/nix/profiles/system-$$gen-link

devenv:
	devenv update

update:
	nix flake update

up: update switch devenv 
