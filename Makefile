# Allow linting on specific filepaths if needed
FILEPATH :=

# Issues to ignore while linting
LINT_IGNORE :=

# Location of platform
PLATFORMS_DIR := platform
PLATFORM ?= rpi
PLATFORM_DIR := $(PLATFORMS_DIR)/$(PLATFORM)

# Includes platform-specific configurations
include $(PLATFORMS_DIR)/$(PLATFORM)/platform.mk

.PHONY: socketcan
socketcan:
	@sudo modprobe can
	@sudo modprobe can_raw
	@sudo modprobe vcan
	@sudo ip link add dev vcan0 type vcan || true
	@sudo ip link set up vcan0 || true
	@ip link show vcan0

.PHONY: lint
lint:
	@echo "Linting using flake8"
	@flake8 --ignore=$(LINT_IGNORE) $(FILEPATH)

.PHONY: format
format:
	@echo "Formatting all files using autopep8"
	@autopep8 --in-place --recursive --aggressive --aggressive .

.PHONY: test
test:
	@echo "Running pytest on all files"
	@pytest
