# Set the library to include if using this platform
PLATFORM_LIB := rpi
PLATFORM_EXT :=

# Platform targets
.PHONY: run
run:
	@python3 telemetry_scripts/aggregate_can_data.py \
	& python3 telemetry_scripts/rpi/GPS.py \
	& python3 telemetry_scripts/web_aggregate_can_data.py
