# Include the common config.
include make/config.mk

# Setup verbosity.
V :=

# Include the platform specific config.
include make/arch/$(ARCH).mk

# Include the projects.
include $(patsubst %,projects/%/project.mk,$(PROJECTS))

# All task.
all:
	$(V)echo Hello, world!

# Clean task.
.PHONY: clean
clean:
	$(V)rm -rf $(OUT)
