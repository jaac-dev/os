#
#  Common Configuration
#

# When 0, make will not display the executed commands.
VERBOSE := 1

# The directory where intermediate and binary files will be placed.
OUT := build

# Defines the target architecture.
ARCH := x86_64-elf

# Defines the directories to include within the "projects" root directory.
# The project directory must have a "project.mk" file, as it's the actual included file.
PROJECTS := boot kernel common cd

# Defines the xorriso binary to use.
XORRISO := xorriso