HOSTNAME := $(shell hostname -s)
ACTIONS := build
SUDO_ACTIONS := check switch
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

update:
	nix flake update

up: update switch
